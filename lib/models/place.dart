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

class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File image;
  final String phone;

  Place({
    required this.id,
    required this.title,
    this.location,
    required this.image,
    required this.phone
  });
}
