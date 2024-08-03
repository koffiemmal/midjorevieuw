// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class LocationPLace {
  final String placeName;
  final LatLng location;
  final String positionTime;

  LocationPLace({
    required this.placeName,
    required this.location,
    required this.positionTime,
  });

  factory LocationPLace.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return LocationPLace(
      placeName: data['nom'] ?? 'Unknown',
      location: LatLng(data['latitude'], data['longitude']),
      positionTime: data['time'] ?? '',
    );
  }
}
