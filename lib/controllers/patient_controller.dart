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
}
