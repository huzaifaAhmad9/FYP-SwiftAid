import 'package:flutter/foundation.dart';

@immutable
class HospitalModel {
  final String? name;
  final String? email;
  final String? phone;
  final String? profilePhoto;
  final String? password;
  final String? address;
  final String? description;
  final double? latitude;
  final double? longitude;
  final bool? isVerified;

  const HospitalModel({
    this.name,
    this.email,
    this.phone,
    this.profilePhoto,
    this.password,
    this.address,
    this.description,
    this.latitude,
    this.longitude,
    this.isVerified,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    final location = json['Location'] as Map<String, dynamic>?;

    return HospitalModel(
      name: json['Name'] as String?,
      email: json['Email'] as String?,
      phone: json['Phone'] as String?,
      profilePhoto: json['ProfilePhoto'] as String?,
      password: json['Password'] as String?,
      address: json['Address'] as String?,
      description: json['Description'] as String?,
      latitude:
          location != null ? (location['latitude'] as num?)?.toDouble() : null,
      longitude:
          location != null ? (location['longitude'] as num?)?.toDouble() : null,
      isVerified: json['isVerified'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Email': email,
      'Phone': phone,
      'ProfilePhoto': profilePhoto,
      'Password': password,
      'Address': address,
      'Description': description,
      'Location': {
        'latitude': latitude,
        'longitude': longitude,
      },
      'isVerified': isVerified,
    };
  }
}
