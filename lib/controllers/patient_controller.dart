import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:imd0509_projeto/controllers/api.dart';
import 'package:imd0509_projeto/models/place.dart';

import '../models/patient.dart';
import 'package:http/http.dart' as http;

class PatientController extends ChangeNotifier {
  Patient? patient;

  PatientController({this.patient});

  Patient getPatient() {
    return patient!;
  }

  Future<void> fetchPatient() async {
    print('buscando paciente');
    final response = await http.get(Uri.parse(
        '${Api.baseUrl}${Api.patientsPath}/612c033506ca88075f225bb6'));
    print('response');
    final patientResponse = jsonDecode(response.body).cast<String, dynamic>();
    print('decode');
    patient = Patient.fromJson(patientResponse);
    print('Consulta finalizada');
    notifyListeners();
  }

  Future<void> updateField(String patientId, String field, String value) async {
    print(patientId);
    print(field);
    print(value);
    final response = await http.put(
        Uri.parse('${Api.baseUrl}${Api.patientsPath}/$patientId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"$field": value}));

    switch (field) {
      case 'name':
        patient!.name = value;
        break;
      case 'last_name':
        patient!.last_name = value;
        break;
      case 'birthday':
        patient!.birthday = value;
        break;
      case 'email':
        patient!.email = value;
        break;
      case 'phone':
        patient!.phone = value;
        break;
      case 'lat':
        patient!.placeLocation = PlaceLocation(latitude: value, longitude: patient!.placeLocation!.longitude, address: patient!.placeLocation!.address);
        break;
      case 'long':
        patient!.placeLocation = PlaceLocation(latitude: patient!.placeLocation!.latitude, longitude: value, address: patient!.placeLocation!.address);
        break;
      case 'address':
        patient!.placeLocation = PlaceLocation(latitude: patient!.placeLocation!.latitude, longitude: patient!.placeLocation!.longitude, address: value);
        break;
      default:
    }
    notifyListeners();
    return Future.value();
  }
}
