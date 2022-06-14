import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:imd0509_projeto/controllers/api.dart';
import 'package:http/http.dart' as http;
import 'package:imd0509_projeto/models/patient.dart';
import 'package:imd0509_projeto/utils/mock/patientList.dart';

class PatientController extends ChangeNotifier {
  List<Patient> _patientsList = patientListMocked;

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
        id: newPatient.id,
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
    bool hasId = data['id'] != null;

    final patient = Patient(
      name: data['name'] as String,
      last_name: data['last_name'] as String,
      birthday: data['birthday'] as String,
      gender: data['gender'] as String,
      email: data['email'] as String,
      phone: data['phone'] as String,
      password: data['password'] as String,
    );
    
    if (hasId) {
      return updatePatient(patient);
    } else {
      return addPatient(patient);
    }
  }

  Future<void> updatePatient(Patient patient) async {
    final response = await http.put(
        Uri.parse('${Api.baseUrl}${Api.patientsPath}/${patient.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'id': patient.id,
          'name': patient.name,
          'last_name': patient.last_name,
          'gender': patient.gender,
          'email': patient.email,
          'password': patient.password,
          'birthday': patient.birthday,
          'phone': patient.phone,
        }));

    if (response.statusCode == 204) {

      int index = _patientsList.indexWhere((p) => p.id == patient.id);

      if (index >= 0) {
        _patientsList[index] = patient;
        notifyListeners();
      }
    }
    return Future.value();
  }

  Future<http.Response> removePatient(String id) async{
    final http.Response response =
        await http.delete(Uri.parse('${Api.baseUrl}${Api.patientsPath}/$id'));

    if (response.statusCode == 204) {
      int index = _patientsList.indexWhere((p) => p.id == id);
      if (index >= 0) {
        _patientsList.removeAt(index);
        notifyListeners();
      }
    }
    return response;
  }
}
