import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:imd0509_projeto/controllers/api.dart';
import 'package:http/http.dart' as http;

import '../models/doctor.dart';

class DoctorController extends ChangeNotifier {
  List<Doctor> _doctorsList = [];

  Future<List<Doctor>> fetchDoctorsList() async {
    print('Fetch doctors\n ${Api.baseUrl}${Api.doctorsPath}');
    final response =
        await http.get(Uri.parse('${Api.baseUrl}${Api.doctorsPath}'));
        
    if (response.statusCode != 200) {
      return [];
    } 

    final lista = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return lista.map<Doctor>((item) => Doctor.fromJson(item)).toList();
  }

  List<Doctor> getDoctors() {
    return _doctorsList;
  }

  void setDoctor(List<Doctor> doctorsList) {
    _doctorsList = doctorsList;
  }
}
