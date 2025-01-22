import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swift_aid/api_routes/app_routes.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async' show Completer;
import 'dart:developer' show log;
import 'dart:convert' show json;

class MainMap extends StatefulWidget {
  const MainMap({super.key});

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
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
          PopupMenuButton(
            onSelected: (String theme) {
              _controller.future.then((controller) {
                if (context.mounted) {
                  DefaultAssetBundle.of(context)
                      .loadString('assets/maptheme/$theme')
                      .then((string) {
                    controller.setMapStyle(string);
                  });
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'silver_theme.json',
                child: Text('Silver'),
              ),
              const PopupMenuItem(
                value: 'night_theme.json',
                child: Text('Night'),
              ),
              const PopupMenuItem(
                value: 'retro_theme.json',
                child: Text('Retro'),
              ),
            ],
          )
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
}
