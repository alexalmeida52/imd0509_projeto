import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:imd0509_projeto/controllers/api.dart';
import 'package:http/http.dart' as http;

import '../models/doctor.dart';

class DoctorController extends ChangeNotifier {
  List<Doctor> _doctorsList = [];

  Future<List<Doctor>> fetchDoctorsList() async {
    print('Fetch doctors\n${Api.baseUrl}${Api.doctorsPath}');
    final response =
        await http.get(Uri.parse('${Api.baseUrl}${Api.doctorsPath}'));

    if (response.statusCode != 200) {
      return [];
    }

    final lista = jsonDecode(response.body).cast<Map<String, dynamic>>();
    _doctorsList = lista.map<Doctor>((item) => Doctor.fromJson(item)).toList();
    notifyListeners();
    return _doctorsList;
  }

  List<Doctor> getDoctors() {
    return _doctorsList;
  }

  void setDoctor(List<Doctor> doctorsList) {
    _doctorsList = doctorsList;
  }

  Future<Response> remove(String id) async {
    final Response response =
        await http.delete(Uri.parse('${Api.baseUrl}${Api.doctorsPath}/$id'));

    if (response.statusCode == 204) {
      int index = _doctorsList.indexWhere((p) => p.id == id);
      if (index >= 0) {
        _doctorsList.removeAt(index);
        notifyListeners();
      }
    }
    return response;
  }

  Future<void> saveDoctor(Doctor doctor) {
    if (doctor.id != null) {
      return updateDoctor(doctor);
    } else {
      return createDoctor(doctor);
    }
  }

  Future<void> updateDoctor(Doctor doctor) async {
    print('Atualizando doctor');
    print('name: ${doctor.name}');
    print('last_name: ${doctor.last_name}');
    print('avatar: ${doctor.avatarUrl}');
    print('speciality: ${doctor.speciality}');
    final response = await http.put(
        Uri.parse('${Api.baseUrl}${Api.doctorsPath}/${doctor.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "name": doctor.name,
          "last_name": doctor.last_name,
          "avatar": doctor.avatarUrl,
          "speciality": doctor.speciality
        }));

    if (response.statusCode == 204) {
      print('Atualizado doctor');

      int index = _doctorsList.indexWhere((p) => p.id == doctor.id);

      if (index >= 0) {
        _doctorsList[index] = doctor;
        notifyListeners();
      }
    }
    return Future.value();
  }

  Future<void> createDoctor(Doctor doctor) async {
    print('${doctor.name}');
    print('${doctor.speciality}');
    print('${doctor.address}');
    print('${doctor.avatarUrl}');
    print('${doctor.rating}');
    
    final response = await http.post(
        Uri.parse('${Api.baseUrl}${Api.doctorsPath}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "name": doctor.name,
          "last_name": doctor.last_name,
          "avatar": doctor.avatarUrl,
          "speciality": doctor.speciality,
          "gender": "M",
          "birthday": "1996-10-10",
          "clinic": "MyHealth",
          "price": 300.0
        }));

    if (response.statusCode == 204) {
      print('Profissional cadastrado');
      _doctorsList.add(doctor);
      notifyListeners();
    }
  }
}
