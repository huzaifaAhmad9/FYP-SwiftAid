import 'package:flutter/foundation.dart';

@immutable
class CaseModel {
  final String? userId;
  final String? hospitalId;
  final String? patientName;
  final String? estimatedAge;
  final String? gender;
  final String? visibleInjuries;
  final bool? isConscious;
  final IncidentDetails? incidentDetails;
  final List<Media>? photosOrVideos;
  final DateTime? createdAt;

  const CaseModel({
    this.userId,
    this.hospitalId,
    this.patientName,
    this.estimatedAge,
    this.gender = 'Unknown',
    this.visibleInjuries,
    this.isConscious,
    this.incidentDetails,
    this.photosOrVideos,
    this.createdAt,
  });

  factory CaseModel.fromJson(Map<String, dynamic> json) {
    return CaseModel(
      userId: json['UserId'] as String?,
      hospitalId: json['HospitalId'] as String?,
      patientName: json['PatientName'] as String?,
      estimatedAge: json['EstimatedAge'] as String?,
      gender: json['Gender'] as String? ?? 'Unknown',
      visibleInjuries: json['VisibleInjuries'] as String?,
      isConscious: json['IsConscious'] as bool?,
      incidentDetails: json['IncidentDetails'] != null
          ? IncidentDetails.fromJson(json['IncidentDetails'])
          : null,
      photosOrVideos: (json['PhotosOrVideos'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e))
          .toList(),
      createdAt:
          json['CreatedAt'] != null ? DateTime.parse(json['CreatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'HospitalId': hospitalId,
      'PatientName': patientName,
      'EstimatedAge': estimatedAge,
      'Gender': gender,
      'VisibleInjuries': visibleInjuries,
      'IsConscious': isConscious,
      'IncidentDetails': incidentDetails?.toJson(),
      'PhotosOrVideos': photosOrVideos?.map((e) => e.toJson()).toList(),
      'CreatedAt': createdAt?.toIso8601String(),
    };
  }
}

@immutable
class IncidentDetails {
  final String? type;
  final String? description;
  final Location? location;
  final DateTime? dateTimeOfIncident;

  const IncidentDetails({
    this.type,
    this.description,
    this.location,
    this.dateTimeOfIncident,
  });

  factory IncidentDetails.fromJson(Map<String, dynamic> json) {
    return IncidentDetails(
      type: json['Type'] as String?,
      description: json['Description'] as String?,
      location:
          json['Location'] != null ? Location.fromJson(json['Location']) : null,
      dateTimeOfIncident: json['DateTimeOfIncident'] != null
          ? DateTime.parse(json['DateTimeOfIncident'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Type': type,
      'Description': description,
      'Location': location?.toJson(),
      'DateTimeOfIncident': dateTimeOfIncident?.toIso8601String(),
    };
  }
}

@immutable
class Location {
  final String? address;
  final GeoCoordinates? geoCoordinates;

  const Location({
    this.address,
    this.geoCoordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address: json['Address'] as String?,
      geoCoordinates: json['GeoCoordinates'] != null
          ? GeoCoordinates.fromJson(json['GeoCoordinates'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Address': address,
      'GeoCoordinates': geoCoordinates?.toJson(),
    };
  }
}

@immutable
class GeoCoordinates {
  final double? lat;
  final double? lng;

  const GeoCoordinates({
    this.lat,
    this.lng,
  });

  factory GeoCoordinates.fromJson(Map<String, dynamic> json) {
    return GeoCoordinates(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

@immutable
class Media {
  final String? url;
  final String? type; // 'photo' or 'video'

  const Media({
    this.url,
    this.type,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      url: json['url'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'type': type,
    };
  }
}
