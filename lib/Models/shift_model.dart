import 'package:flutter/foundation.dart';

@immutable
class ShiftModel {
  final String? staffId;
  final List<Shift>? shifts;

  const ShiftModel({
    this.staffId,
    this.shifts,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    var shiftsJson = json['Shifts'] as List<dynamic>?;
    List<Shift>? shifts = shiftsJson
        ?.map((shift) => Shift.fromJson(shift as Map<String, dynamic>))
        .toList();

    return ShiftModel(
      staffId: json['StaffId'] as String?,
      shifts: shifts,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'StaffId': staffId,
      'Shifts': shifts?.map((shift) => shift.toJson()).toList(),
    };
  }
}

@immutable
class Shift {
  final String? day;
  final String? startTime;
  final String? endTime;
  final bool? isAvailable;

  const Shift({
    this.day,
    this.startTime,
    this.endTime,
    this.isAvailable,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      day: json['Day'] as String?,
      startTime: json['StartTime'] as String?,
      endTime: json['EndTime'] as String?,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Day': day,
      'StartTime': startTime,
      'EndTime': endTime,
      'isAvailable': isAvailable,
    };
  }
}
