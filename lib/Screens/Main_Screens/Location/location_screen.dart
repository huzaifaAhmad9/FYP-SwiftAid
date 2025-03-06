import 'package:swift_aid/Screens/Main_Screens/Location/emergency_registration.dart';
import 'package:swift_aid/Screens/personal_details/component/text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swift_aid/components/custom_listtile.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/components/custom_text.dart';
import 'package:swift_aid/api_routes/app_routes.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Completer;
import 'dart:developer' show log;
import 'dart:convert' show json;

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _controllers = List.generate(1, (index) => TextEditingController());

  String mapTheme = '';
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = [];
  LatLng? _currentLocation;
  static const CameraPosition _defaultCameraPosition = CameraPosition(
    target: LatLng(31.515795241966867, 74.41747899905428),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _setMapStyle(GoogleMapController controller) async {
    if (mapTheme.isEmpty) {
      mapTheme = await DefaultAssetBundle.of(context)
          .loadString('assets/maptheme/silver_theme.json');
    }
    controller.setMapStyle(mapTheme);
  }

  Future<void> _getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return;
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      log('Current Position: ${position.latitude}, ${position.longitude}');
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: _currentLocation!,
            infoWindow: const InfoWindow(title: 'Your Location'),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      });

      _fetchNearbyHospitals();
      _moveCamera(_currentLocation!);
    } catch (e) {
      log('Error getting user location: $e');
    }
  }

  Future<void> _fetchNearbyHospitals() async {
    if (_currentLocation == null) return;
    const String apiKey = AppRoutes.mapApi;
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentLocation!.latitude},${_currentLocation!.longitude}&radius=1500&type=hospital&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        setState(() {
          for (var place in results) {
            _markers.add(
              Marker(
                markerId: MarkerId(place['place_id']),
                position: LatLng(
                  place['geometry']['location']['lat'],
                  place['geometry']['location']['lng'],
                ),
                infoWindow: InfoWindow(
                  title: place['name'],
                  snippet: place['vicinity'],
                ),
              ),
            );
          }
        });
      } else {
        log('Failed to fetch nearby hospitals: ${response.body}');
      }
    } catch (e) {
      log('Error fetching nearby hospitals: $e');
    }
  }

  Future<void> _moveCamera(LatLng target) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: target, zoom: 15),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Map',
          style: TextStyle(color: AppColors.lightWhite),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_outlined),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (BuildContext context) {
                  return SizedBox(
                    height: screenHeight * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomTextFormField(
                            controller: _controllers[0],
                            cursor: AppColors.primaryColorLight,
                            errorBorderColor: AppColors.redColor,
                            borderColor: AppColors.primaryColor,
                            borderRadius: 20,
                            hintText: 'Search location',
                            keyboardType: TextInputType.name,
                            prefixIcon: const Icon(
                              CupertinoIcons.search,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: CustomText(
                            text: 'NearBy Hospitals',
                            size: 16.0,
                            weight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomListTile(
                                leading: const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.primaryColor,
                                ),
                                title: 'National Hospital',
                                subtitle: '5.5 KM Away',
                                trailing: CustomButton(
                                  width: 150,
                                  height: 40,
                                  borderRadius: 12.0,
                                  fontSize: 11,
                                  backgroundColor: AppColors.primaryColor,
                                  text: 'Emergency Register',
                                  onPressed: () {
                                    //! Close the first bottom sheet
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16)),
                                      ),
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: screenHeight * 0.3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const CustomText(
                                                  text:
                                                      'Emergency Registration',
                                                  size: 22.0,
                                                  weight: FontWeight.bold,
                                                ),
                                                const CustomText(
                                                  text:
                                                      'Send details to your nearest hospital',
                                                  size: 15.0,
                                                  weight: FontWeight.normal,
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenHeight * 0.03),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      height: 60,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1.0,
                                                            color: AppColors
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      child: ListTile(
                                                        onTap: () {},
                                                        leading: const Icon(
                                                          Icons.keyboard_voice,
                                                          color: AppColors
                                                              .primaryColor,
                                                        ),
                                                        title: const Text(
                                                          'By Voice',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 60,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1.0,
                                                            color: AppColors
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      child: ListTile(
                                                        onTap: () {},
                                                        leading: const Icon(
                                                          Icons
                                                              .chat_bubble_outline,
                                                          color: AppColors
                                                              .primaryColor,
                                                        ),
                                                        title: const Text(
                                                            'By Form',
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: screenHeight * 0.03,
                                                ),
                                                Center(
                                                  child: CustomButton(
                                                    width: double.infinity,
                                                    height: 50,
                                                    borderRadius: 15.0,
                                                    fontSize: 14,
                                                    backgroundColor:
                                                        AppColors.primaryColor,
                                                    text: 'Next',
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  const EmergencyRegistration()));
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          markers: Set<Marker>.of(_markers),
          initialCameraPosition: _defaultCameraPosition,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _setMapStyle(controller);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllers.asMap().forEach((i, c) => c.dispose());
    super.dispose();
  }
}
