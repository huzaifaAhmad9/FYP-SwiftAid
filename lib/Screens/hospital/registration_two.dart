// ignore_for_file: library_private_types_in_public_api

import 'package:swift_aid/Screens/personal_details/component/text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:swift_aid/Screens/hospital/select_from_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swift_aid/components/responsive_sized_box.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class RegistrationTwo extends StatefulWidget {
  const RegistrationTwo({super.key});

  @override
  _RegistrationTwoState createState() => _RegistrationTwoState();
}

class _RegistrationTwoState extends State<RegistrationTwo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String address = '';
  bool isLoading = false;

  Future<void> fetchAddressFromLatLong() async {
    final lat = double.tryParse(latitudeController.text);
    final lon = double.tryParse(longitudeController.text);
    if (lat == null || lon == null) {
      setState(() => address = '');
      return;
    }
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          address =
              '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        });
      } else {
        setState(() => address = 'No address found');
      }
    } catch (e) {
      log('Error fetching address: $e');
      setState(() => address = 'Error getting address');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () async {
                final LatLng? result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SelectFromMap()),
                );

                if (result != null) {
                  setState(() {
                    latitudeController.text = result.latitude.toString();
                    longitudeController.text = result.longitude.toString();
                  });
                  fetchAddressFromLatLong();
                }
              },
              child: const Icon(
                FontAwesomeIcons.mapPin,
                size: 20,
              )),
          const SizedBox(
            width: 13,
          )
        ],
        title: const Text(
          'Registration',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 15),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    child: Image.asset(
                      'assets/images/splash.png',
                      color: AppColors.primaryColor,
                      cacheHeight: 30,
                      cacheWidth: 30,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 30,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Complete All Registration\nProcesses .....',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    3.heightBox,
                    CustomTextFormField(
                      controller: latitudeController,
                      hintText: 'Enter Latitude',
                      labelText: 'Latitude',
                      keyboardType: TextInputType.number,
                      onTap: () {},
                      onChanged: (_) => fetchAddressFromLatLong(),
                      borderColor: AppColors.primaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Latitude is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      controller: longitudeController,
                      hintText: 'Enter Longitude',
                      labelText: 'Longitude',
                      keyboardType: TextInputType.number,
                      onTap: () {},
                      onChanged: (_) => fetchAddressFromLatLong(),
                      borderColor: AppColors.primaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Longitude is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        address.isEmpty
                            ? '📌 Address will appear here'
                            : '📌 Address: $address',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      controller: descriptionController,
                      hintText: 'Enter Description',
                      labelText: 'Description',
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                      borderColor: AppColors.primaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      backgroundColor: AppColors.primaryColor,
                      borderRadius: 20,
                      width: 250,
                      text: 'Register',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //! logic here
                        } else {
                          log('Validation failed!');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
