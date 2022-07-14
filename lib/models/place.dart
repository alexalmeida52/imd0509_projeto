import 'dart:io';

class PlaceLocation {
  final String latitude;
  final String longitude;
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address = '',
  });
}
