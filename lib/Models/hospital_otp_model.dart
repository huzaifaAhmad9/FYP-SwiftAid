import 'package:flutter/foundation.dart';

@immutable
class HospitalOtpModel {
  final String? userId;
  final String? otp;
  final DateTime? createdAt;
  final DateTime? expireAt;

  const HospitalOtpModel({
    this.userId,
    this.otp,
    this.createdAt,
    this.expireAt,
  });

  factory HospitalOtpModel.fromJson(Map<String, dynamic> json) {
    return HospitalOtpModel(
      userId: json['UserID'] as String?,
      otp: json['OTP'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      expireAt:
          json['expireAt'] != null ? DateTime.parse(json['expireAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userId,
      'OTP': otp,
      'createdAt': createdAt?.toIso8601String(),
      'expireAt': expireAt?.toIso8601String(),
    };
  }
}
