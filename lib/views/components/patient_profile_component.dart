import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imd0509_projeto/utils/app_routes.dart';
import 'package:imd0509_projeto/views/components/info_patient_profile_component.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

import '../../controllers/patient_controller.dart';
import 'image_input.component.dart';

class PatientProfileComponent extends StatefulWidget {
  @override
  State<PatientProfileComponent> createState() =>
      _PatientProfileComponentState();
}

class _PatientProfileComponentState extends State<PatientProfileComponent> {
  File? _storedImage;

  File? _image;

  @override
  Widget build(BuildContext context) {
    // final patient = Provider.of<PatientController>(context, listen: false);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 18, right: 18),
        child: FutureBuilder(
            future: Provider.of<PatientController>(context, listen: false)
                .fetchPatient(),
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<PatientController>(
                    child: Center(
                      child: Text('Nenhum paciente'),
                    ),
                    builder: (context, controller, child) {
                      return Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Editar Perfil',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 30,
                                  fontFamily: 'RobotoBold',
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              ImageInput((String url) {
                                print('Atualizando avatar');
                                Provider.of<PatientController>(context,
                                        listen: false)
                                    .updateField(controller.patient!.id!,
                                        'avatarUrl', url);
                              }, controller.patient!.avatarUrl)
                            ],
                          ),
                          SizedBox(height: 28),
                          ElevatedButton(
                            onPressed: () {
                              Map<String, dynamic> arg = {
                                "label1": "Nome",
                                "label2": "Sobrenome",
                                "field1": "name",
                                "field2": "last_name",
                                "title": "Seu nome e sobrenome",
                                "value1": controller.patient!.name,
                                "value2": controller.patient!.last_name,
                                "isString": true,
                                "patientId": controller.patient!.id
                              };
                              Navigator.pushNamed(
                                  context, AppRoutes.EDIT_PATIENT_FIELD,
                                  arguments: arg);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green[200],
                              padding: EdgeInsets.all(0),
                            ),
                            child: InfoPatientProfile(
                                '${controller.patient!.name} ${controller.patient!.last_name}',
                                Icons.person),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              Map<String, dynamic> arg = {
                                "label1": "Data",
                                "field1": "birthday",
                                "title": "Seu aniversário",
                                "value1": controller.patient!.birthday,
                                "isString": false,
                                "patientId": controller.patient!.id
                              };
                              Navigator.pushNamed(
                                  context, AppRoutes.EDIT_PATIENT_FIELD,
                                  arguments: arg);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green[200],
                              padding: EdgeInsets.all(0),
                            ),
                            child: InfoPatientProfile(
                                '${DateFormat('dd/MM/yyyy').format(DateTime.parse(controller.patient!.birthday))}',
                                Icons.date_range),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              Map<String, dynamic> arg = {
                                "label1": "Email",
                                "field1": "email",
                                "title": "Seu e-mail",
                                "value1": controller.patient!.email,
                                "isString": true,
                                "patientId": controller.patient!.id
                              };
                              Navigator.pushNamed(
                                  context, AppRoutes.EDIT_PATIENT_FIELD,
                                  arguments: arg);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green[200],
                              padding: EdgeInsets.all(0),
                            ),
                            child: InfoPatientProfile(
                                '${controller.patient!.email}', Icons.mail),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              Map<String, dynamic> arg = {
                                "label1": "Contato",
                                "field1": "phone",
                                "title": "Seu telefone",
                                "value1": controller.patient!.phone,
                                "isString": true,
                                "patientId": controller.patient!.id
                              };
                              Navigator.pushNamed(
                                  context, AppRoutes.EDIT_PATIENT_FIELD,
                                  arguments: arg);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green[200],
                              padding: EdgeInsets.all(0),
                            ),
                            child: InfoPatientProfile(
                                '${controller.patient!.phone}', Icons.phone),
                          ),
                        ],
                      );
                    })),
      ),
    );
  }
}
