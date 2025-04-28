import 'package:flutter/foundation.dart';

@immutable
class StaffModel {
  final String? hospitalId;
  final String? name;
  final String? email;
  final String? dob;
  final String? gender;
  final String? phone;
  final String? doctorDescription;
  final String? profilePhoto;
  final List<String>? specialization;

  const StaffModel({
    this.hospitalId,
    this.name,
    this.email,
    this.dob,
    this.gender,
    this.phone,
    this.doctorDescription,
    this.profilePhoto,
    this.specialization,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      hospitalId: json['HospitalId'] as String?,
      name: json['Name'] as String?,
      email: json['Email'] as String?,
      dob: json['DOB'] as String?,
      gender: json['Gender'] as String?,
      phone: json['Phone'] as String?,
      doctorDescription: json['DoctorDescription'] as String?,
      profilePhoto: json['ProfilePhoto'] as String?,
      specialization: (json['Specialization'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'HospitalId': hospitalId,
      'Name': name,
      'Email': email,
      'DOB': dob,
      'Gender': gender,
      'Phone': phone,
      'DoctorDescription': doctorDescription,
      'ProfilePhoto': profilePhoto,
      'Specialization': specialization,
    };
  }
}
