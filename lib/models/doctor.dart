import 'package:imd0509_projeto/models/place.dart';

class Doctor {
  String? id;
  String name;
  String last_name;
  String speciality;
  int? rating;
  String? avatarUrl;
  PlaceLocation? placeLocation;

  Doctor({
    this.id,
    required this.name,
    required this.last_name,
    required this.speciality,
    this.avatarUrl,
    this.rating,
    this.placeLocation
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'],
      name: json['name'],
      last_name: json['last_name'],
      speciality: json['speciality'],
      avatarUrl: json['avatar'],
      placeLocation: PlaceLocation(latitude: json['lat'] ?? '0', longitude: json['long'] ?? '0', address: json['address'] ?? 'Sem local')
    );
  }
}
