import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:imd0509_projeto/controllers/api.dart';
import 'package:http/http.dart' as http;
import 'package:imd0509_projeto/models/patient.dart';

class PatientController extends ChangeNotifier {
  List<Patient> _patientsList = [];

  Future<List<Patient>> fetchPatientList() async {
    print('Fetch Patients\n ${Api.baseUrl}${Api.patientsPath}');
    final response =
        await http.get(Uri.parse('${Api.baseUrl}${Api.patientsPath}'));

    if (response.statusCode != 200) {
      return [];
    }

    final lista = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return lista.map<Patient>((item) => Patient.fromJson(item)).toList();
  }

  List<Patient> getPatients() {
    return _patientsList;
  }

  void setPatient(List<Patient> PatientsList) {
    _patientsList = PatientsList;
  }

  Future<void> addPatient(Patient newPatient) {
    print('adicionando');
    final future = http.post(Uri.parse('${Api.baseUrl}/patients'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': newPatient.name,
          'last_name': newPatient.last_name,
          'gender': newPatient.gender,
          'email': newPatient.email,
          'password': newPatient.password,
          'birthday': newPatient.birthday,
          'phone': newPatient.phone,
        }));
    return future.then((response) {
      print('espera a requisição acontecer');
      print(jsonDecode(response.body));
      print(response.statusCode);
      _patientsList.add(Patient(
        name: newPatient.name,
        last_name: newPatient.last_name,
        gender: newPatient.gender,
        email: newPatient.email,
        password: newPatient.password,
        birthday: newPatient.birthday,
        phone: newPatient.phone,
      ));
      notifyListeners();
    });
  }

  Future<void> savePatient(Map<String, Object> data) {
    final newPatient = Patient(
      name: data['name'] as String,
      last_name: data['last_name'] as String,
      birthday: data['birthday'] as String,
      gender: data['gender'] as String,
      email: data['email'] as String,
      phone: data['phone'] as String,
      password: data['password'] as String,
    );
    return addPatient(newPatient);
  }
}
