import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imd0509_projeto/utils/mock/consultaList.dart';

import 'package:intl/intl.dart';

import '../../models/consultas.dart';
import '../../utils/app_routes.dart';

class ListaConsulta extends StatefulWidget {
  List<Consulta> _filterListConsulta;

  ListaConsulta(this._filterListConsulta);

  @override
  State<ListaConsulta> createState() => _ListaConsultaState();
}

class _ListaConsultaState extends State<ListaConsulta> {
  // List<Consulta> consultaList = consultaListMocked;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget._filterListConsulta.isEmpty
            ? Text('Nenhuma consulta marcada')
            : ListView.builder(
                shrinkWrap: true,
                itemCount: widget._filterListConsulta.length,
                itemBuilder: (context, index) {
                  final consulta = widget._filterListConsulta[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 0.8),
                    child: InkWell(
                      // onTap: () {
                      //   Navigator.of(context).pushNamed(
                      //     AppRoutes.CREATE_SCHEDULE
                      //   );
                      // },
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new AssetImage(
                                              consulta.avatarUrl != null 
                                              ? 'assets/${consulta.avatarUrl!}' 
                                              : 'assets/user_default.png'
                                          )
                                      )
                                  )),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    consulta.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 17
                                    ),
                                    ),
                                  Text(consulta.speciality),
                                  Text(consulta.address),
                                  Text(DateFormat("dd/MM/yyyy").format(consulta.data)),
                                  Text(
                                    'R\$' + consulta.valor.toStringAsFixed(2).replaceAll('.', ','),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                    )

                                ],
                              ),
                            ),
                             Container(
                               padding: const EdgeInsets.all(10),
                               alignment: Alignment.centerRight,
                               child: Text(
                                 consulta.status,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    
                                    fontSize: 11,
                                    color: Color.fromARGB(255, 98, 101, 98)),
                               ),
                             )
                          ]
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
