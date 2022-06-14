import 'package:imd0509_projeto/models/doctor.dart';

class Consulta {
  String name;
  String speciality;
  String address;
  int? rating;
  String? avatarUrl;
  DateTime data;
  double valor;
  String status;
  Doctor doctor;

  Consulta({
    required this.name,
    required this.speciality,
    required this.address,
    this.avatarUrl,
    required this.data,
    required this.valor,
    required this.status,
    this.rating,
    required this.doctor
  });

  factory Consulta.fromJson(Map<String, dynamic> json) {
    return Consulta(
      name: json['doctor_id']['name'],
      speciality: json['doctor_id']['speciality'],
      address: 'Local',
      avatarUrl: json['doctor_id']['avatar'],
      data: DateTime.parse(json['start_date']),
      valor: json['doctor_id']['price'],
      status: 'Ativo',
      doctor: Doctor.fromJson(json['doctor_id'])
    );
  }
}
