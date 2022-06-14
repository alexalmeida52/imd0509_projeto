import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:imd0509_projeto/models/patient.dart';

class PatientList extends StatefulWidget {
  List<Patient> filterListPatients;

  PatientList({required this.filterListPatients});
  @override
  State<PatientList> createState() => _PatientListState();

  
}

class _PatientListState extends State<PatientList> {
  splitbirthday(String birthday){
    List<String> split = birthday.split('T');
    List<String> format = split[0].split('-');
    return format[2]+ '-' + format[1] + '-' + format[0];
  }
  
  @override
  Widget build(BuildContext context) {
    print(widget.filterListPatients.length);
    return Expanded(
              child: widget.filterListPatients.isEmpty
            ? Text('Nenhum profissional encontrado')
            :ListView.builder(
                  itemCount: widget.filterListPatients.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final patient = widget.filterListPatients[index];
                     return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Stack(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(patient.name + ' ' + patient.last_name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color:
                                                    Color.fromRGBO(28, 45, 62, 1))),
                                        Text('Sexo: ' + patient.gender,
                                            style: TextStyle(
                                                color:
                                                    Color.fromRGBO(28, 45, 62, 1))),
                                        Text( 'Nascimento: ' + splitbirthday(patient.birthday), style: TextStyle(
                                                color:
                                                    Color.fromRGBO(28, 45, 62, 1)) )                                       
                                      ],
                                    )
                                  ]),
                            ),
                          ),
                        ]
                      ),
                    );
                  }),
            );
  }
}