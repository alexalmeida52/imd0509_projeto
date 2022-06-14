import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imd0509_projeto/utils/mock/consultaList.dart';

import 'package:intl/intl.dart';

import '../../models/consultas.dart';
import '../../utils/app_routes.dart';

class ListaConsulta extends StatefulWidget {
  List<Consulta> filteredListConsults;
  bool? isManagement;

  ListaConsulta({required this.filteredListConsults, this.isManagement = false});

  @override
  State<ListaConsulta> createState() => _ListaConsultaState();
}

class _ListaConsultaState extends State<ListaConsulta> {
  // List<Consulta> consultaList = consultaListMocked;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.filteredListConsults.isEmpty
            ? Text('Nenhuma consulta marcada')
            : Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.filteredListConsults.length,
                itemBuilder: (context, index) {
                  final consulta = widget.filteredListConsults[index];
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
                            Row(
                              children: [
                                Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: new NetworkImage(consulta.avatarUrl ?? 'https://cdn-icons-png.flaticon.com/512/219/219986.png')
                                          )
                                      )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${consulta.doctor.name} ${consulta.doctor.last_name}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 17
                                        ),
                                        ),
                                      Text(consulta.speciality ?? 'Médico'),
                                      Text(consulta.address ?? 'Local'),
                                      Text(DateFormat("dd/MM/yyyy").format(consulta.data)),
                                      Text(
                                        'R\$ ${consulta.valor != null ? consulta.valor!.toStringAsFixed(2).replaceAll('.', ',') : 'R\$ 0,00'}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                        )

                                    ],
                                  ),
                                ),
                              ],
                            ),
                             Container(
                               padding: const EdgeInsets.all(10),
                               alignment: Alignment.centerRight,
                               child: Text(
                                 consulta.status ?? 'Ativo',
                                overflow: TextOverflow.fade,
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
              ),
            ));
  }
}
