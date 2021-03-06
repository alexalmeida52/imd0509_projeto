import 'package:imd0509_projeto/models/place.dart';

class Patient {
  String? id;
  String name;
  String last_name;
  String gender;
  String birthday;
  String email;
  String phone;
  String password;
  bool? isFirstConnection;
  String? avatarUrl;
  PlaceLocation? placeLocation;

  Patient(
      {this.id,
      required this.name,
      required this.last_name,
      required this.gender,
      required this.email,
      required this.birthday,
      required this.password,
      required this.phone,
      this.isFirstConnection = true,
      this.avatarUrl,
      this.placeLocation
      });
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        id: json['_id'],
        name: json['name'],
        last_name: json['last_name'],
        gender: json['gender'],
        email: json['email'],
        password: json['password'],
        birthday: json['birthday'],
        phone: json['phone'],
        avatarUrl: json['avatarUrl'],
        placeLocation: PlaceLocation(latitude: json['lat'] ?? '0', longitude: json['long'] ?? '0', address: json['address'] ?? 'Sem local')
    );
  }
}
