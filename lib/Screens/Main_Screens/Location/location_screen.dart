import 'package:swift_aid/Screens/Main_Screens/Location/Registration/emergency_registration_voice.dart';
import 'package:swift_aid/Screens/Main_Screens/Location/Registration/emergency_registration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swift_aid/components/custom_listtile.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/components/custom_text.dart';
import 'package:swift_aid/api_routes/app_routes.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
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

    final url = AppRoutes.nearbyHospitalsUrl(
      _currentLocation!.latitude,
      _currentLocation!.longitude,
    );

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        setState(() {
          for (var place in results) {
            _markers.add(Marker(
              markerId: MarkerId(place['place_id']),
              position: LatLng(
                place['geometry']['location']['lat'],
                place['geometry']['location']['lng'],
              ),
              infoWindow: InfoWindow(
                title: place['name'],
                snippet: place['vicinity'] +
                    (place['user_ratings_total'] != null
                        ? '\n${place['user_ratings_total']} Reviews'
                        : '') +
                    (place['opening_hours'] != null &&
                            place['opening_hours']['open_now'] != null
                        ? '\nOpen Now: ${place['opening_hours']['open_now'] ? 'Yes' : 'No'}'
                        : ''),
              ),
            ));
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
                        SizedBox(height: screenHeight * 0.02),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: CustomText(
                            text: 'NearBy Hospitals',
                            size: 22.0,
                            weight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Expanded(
                          child: FutureBuilder(
                            future: _getUserLocations(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return const Center(
                                    child: Text('Error getting location'));
                              }

                              Position userPosition = snapshot.data as Position;

                              var sortedMarkers = _markers
                                  .where((marker) =>
                                      marker.markerId.value !=
                                      'current_location')
                                  .toList();

                              sortedMarkers.sort((a, b) {
                                double distanceA = _calculateDistance(
                                    userPosition, a.position);
                                double distanceB = _calculateDistance(
                                    userPosition, b.position);
                                return distanceA.compareTo(distanceB);
                              });

                              return ListView.builder(
                                itemCount: sortedMarkers.length * 2,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index.isOdd) {
                                    return const Divider(
                                      color: Colors.grey,
                                      thickness: 1.0,
                                      indent: 20.0,
                                      endIndent: 20.0,
                                    );
                                  }

                                  int itemIndex = index ~/ 2;

                                  var place = sortedMarkers[itemIndex];

                                  return CustomListTile(
                                    leading: const Icon(
                                      Icons.location_on_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                    title: place.infoWindow.title ??
                                        'Hospital Name',
                                    subtitle: place.infoWindow.snippet ??
                                        'Distance: Unknown',
                                    trailing: CustomButton(
                                      width: 150,
                                      height: 40,
                                      borderRadius: 12.0,
                                      fontSize: 11,
                                      backgroundColor: AppColors.primaryColor,
                                      text: 'Emergency Register',
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the first bottom sheet
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(16)),
                                          ),
                                          builder: (BuildContext context) {
                                            return const EmergencyRegistrationBottomSheet();
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        )
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
          mapType: MapType.normal,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _setMapStyle(controller);
          },
        ),
      ),
    );
  }

//! Helper function to calculate the distance between two positions
  double _calculateDistance(Position userPosition, LatLng markerPosition) {
    return Geolocator.distanceBetween(
      userPosition.latitude,
      userPosition.longitude,
      markerPosition.latitude,
      markerPosition.longitude,
    );
  }

//! Helper function to get the user's current location
  Future<Position> _getUserLocations() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}

//! Bottom Model Sheet
class EmergencyRegistrationBottomSheet extends StatelessWidget {
  const EmergencyRegistrationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.25,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Emergency Registration',
              size: 22.0,
              weight: FontWeight.bold,
            ),
            const CustomText(
              text: 'Send details to your nearest hospital',
              size: 15.0,
              weight: FontWeight.normal,
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildEmergencyOption('By Voice', Icons.keyboard_voice,
                    onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const VoiceRecorderScreen()));
                }),
                _buildEmergencyOption('By Form', Icons.chat_bubble_outline,
                    onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const EmergencyRegistration()));
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyOption(String title, IconData icon,
      {VoidCallback? onTap}) {
    return Container(
      height: 60,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppColors.primaryColor),
        title: Text(
          title,
          style: const TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
