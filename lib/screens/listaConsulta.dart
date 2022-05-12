import 'package:flutter/material.dart';
import 'package:imd0509_projeto/components/listaConsultas.dart';

import '../models/consultas.dart';
import '../utils/app_routes.dart';
import '../utils/mock/consultaList.dart';

class ConsultaMedica extends StatefulWidget {
  @override
  State<ConsultaMedica> createState() => _ConsultaMedicaState();

}

class _ConsultaMedicaState extends State<ConsultaMedica> {
  List<Consulta> _consutList = consultaListMocked;
  List<Consulta> _filterListConsulta = [];
  int tabSelected = 2;

  initState() {
    // at the beginning, all users are shown
    _filterConsultaFuturas(); 
    super.initState();
  }

  _filterConsulta() {
    //print(value);
    setState(() {
      tabSelected = 1;
      _filterListConsulta = _consutList
          .where((consulta) =>
              consulta.data.compareTo(DateTime.now()) < 0)
          .toList();
    });
  }

  _filterConsultaFuturas() {
    setState(() {
      tabSelected = 2;
      _filterListConsulta = _consutList
          .where((consulta) =>
              consulta.data.compareTo(DateTime.now()) > 0)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(242, 242, 242, 1),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(8.0),
                    //color: Colors.red,
                    child: ElevatedButton(
                      onPressed: _filterConsulta,
                      child: Text('PASSADAS'),
                      style: ElevatedButton.styleFrom(
                          primary:  Colors.white,
                          onPrimary:  Colors.greenAccent,
                          side: tabSelected == 1
                              ? BorderSide(
                                  width: 3.0, color: Colors.greenAccent)
                              : BorderSide(
                                  color: Colors.black.withOpacity(0.1))),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(8.0),
                    //color: Colors.blue,
                    child: ElevatedButton(
                      onPressed: _filterConsultaFuturas,
                      child: Text('FUTURAS'),
                      style: ElevatedButton.styleFrom(
                          primary:  Colors.white,
                          onPrimary: Colors.greenAccent,
                          side: tabSelected == 2
                              ? BorderSide(
                                  width: 3.0, color: Colors.greenAccent)
                              : BorderSide(
                                  color: Colors.black.withOpacity(0.1))),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Text('Médicos disponíveis',
            //   style: TextStyle(
            //     color: Color.fromRGBO(28, 45, 62, 1),
            //     fontSize: 26
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            ListaConsulta(_filterListConsulta)
          ],
        ),
      ),
    );
  }
}
