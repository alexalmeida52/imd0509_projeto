import 'package:flutter/material.dart';
import 'package:imd0509_projeto/views/components/listaConsultas.dart';
import 'package:imd0509_projeto/controllers/consult_controller.dart';
import 'package:provider/provider.dart';

import '../../models/consultas.dart';
import '../../utils/app_routes.dart';

class ConsultaMedica extends StatefulWidget {
  @override
  State<ConsultaMedica> createState() => _ConsultaMedicaState();
}

class _ConsultaMedicaState extends State<ConsultaMedica> {
  List<Consulta> _consutList = [];
  List<Consulta> _filterListConsulta = [];
  int tabSelected = 2;

  initState() {
    // at the beginning, all users are shown
    _filterConsultaFuturas();
    super.initState();
  }

  _filterConsulta() {
    setState(() {
      tabSelected = 1;
    });
  }

  _filterConsultaFuturas() {
    setState(() {
      tabSelected = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final consultsController = Provider.of<ConsultController>(context);

    Future<List<Consulta>> getConsults() async {
      print('Buscando consultas');
      if (tabSelected == 1) {
        final temp = await consultsController.fetchConsultList();
        _filterListConsulta = temp
            .where((consulta) => consulta.data.compareTo(DateTime.now()) < 0)
            .toList();
        return _filterListConsulta;
      } else {
        final temp = await consultsController.fetchConsultList();
        _filterListConsulta = temp
            .where((consulta) => consulta.data.compareTo(DateTime.now()) > 0)
            .toList();
        return _filterListConsulta;
      }
    }

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
                          primary: Colors.white,
                          onPrimary: Colors.greenAccent,
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
                          primary: Colors.white,
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
            FutureBuilder<List<Consulta>>(
                future:
                    getConsults(), // Uso de um future para esperar a consulta a api
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListaConsulta(
                        filteredListConsults: _filterListConsulta);
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Erro ao buscar dados');
                  } else {
                    return Expanded(
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
