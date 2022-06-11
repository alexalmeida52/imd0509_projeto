import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:imd0509_projeto/controllers/api.dart';
import 'package:http/http.dart' as http;

import '../../models/consultas.dart';

class ConsultController extends ChangeNotifier {
  List<Consulta> _consultaList = [];

  Future<List<Consulta>> fetchConsultList() async {
    print('Fetch consults\n ${Api.baseUrl}${Api.consultPath}');
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
}
