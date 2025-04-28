import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String? name;
  final String? email;
  final String? phone;
  final String? profilePhoto;
  final String? password;
  final String? gender;
  final DateTime? dob;
  final String? address;
  final String? healthState;
  final bool? isVerified;

  const UserModel({
    this.name,
    this.email,
    this.phone,
    this.profilePhoto,
    this.password,
    this.gender,
    this.dob,
    this.address,
    this.healthState,
    this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['Name'] as String?,
      email: json['Email'] as String?,
      phone: json['Phone'] as String?,
      profilePhoto: json['ProfilePhoto'] as String?,
      password: json['Password'] as String?,
      gender: json['Gender'] as String?,
      dob: json['DOB'] != null ? DateTime.parse(json['DOB']) : null,
      address: json['Address'] as String?,
      healthState: json['HealthState'] as String?,
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
      'Gender': gender,
      'DOB': dob?.toIso8601String(),
      'Address': address,
      'HealthState': healthState,
      'isVerified': isVerified,
    };
  }
}
