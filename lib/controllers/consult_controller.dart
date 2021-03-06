import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:imd0509_projeto/controllers/api.dart';
import 'package:http/http.dart' as http;

import '../../models/consultas.dart';

class ConsultController extends ChangeNotifier {
  List<Consulta> _consultaList = [];

  Future<List<Consulta>> fetchConsultList() async {
    final response =
        await http.get(Uri.parse('${Api.baseUrl}${Api.consultPath}'));

    if (response.statusCode != 200) {
      return [];
    }

    final lista = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return lista.map<Consulta>((item) => Consulta.fromJson(item)).toList();
  }

  List<Consulta> getConsults() {
    return _consultaList;
  }

  void setConsults(List<Consulta> consultsList) {
    _consultaList = consultsList;
    notifyListeners();
  }

  void addConsult(Consulta consulta) async {

    final response = await http.post(
    Uri.parse('${Api.baseUrl}${Api.consultPath}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "start_date": consulta.data.toString(),
      "patient_id": '612c033506ca88075f225bb6',
      "doctor_id": consulta.doctor.id,
      "timetable_id": '612c27ec73b6c3082569bb1a'
    }));

    if (response.statusCode == 204) {
      _consultaList.add(consulta);
    }
  }
}
