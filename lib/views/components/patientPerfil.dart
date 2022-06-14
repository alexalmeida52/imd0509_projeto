import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:imd0509_projeto/models/patient.dart';
import 'package:imd0509_projeto/utils/app_routes.dart';
import 'package:imd0509_projeto/utils/mock/patientList.dart';
import 'package:provider/provider.dart';

import '../../controllers/patient_controller.dart';

class PatientPerfil extends StatefulWidget {
  const PatientPerfil({Key? key}) : super(key: key);

  @override
  State<PatientPerfil> createState() => _PatientPerfilState();
}

class _PatientPerfilState extends State<PatientPerfil> {
  


  splitbirthday(String birthday) {
    List<String> split = birthday.split('T');
    List<String> format = split[0].split('-');
    return format[2] + '-' + format[1] + '-' + format[0];
  }

  @override
  Widget build(BuildContext context) {
    List<Patient> patient = patientListMocked;
    final patientController = Provider.of<PatientController>(context);
 

    Future<List<Patient>> getPatients() async {
      final response = await patientController.fetchPatientList();
      return response;
    }
  
    Future<List<Patient>> patientList  = getPatients();
    return Column(
      children: [
        Text(patient.last.name + " " + patient.last.last_name,
            style:
                TextStyle(fontSize: 20, color: Color.fromRGBO(28, 45, 62, 1))),
        Text('Nascimento: ' + splitbirthday(patient.last.birthday) + " Sexo: " + patient.last.gender,
            style:
                TextStyle(fontSize: 18, color: Color.fromRGBO(28, 45, 62, 1))),
        Text('Email: ' + patient.last.email,
            style:
                TextStyle(fontSize: 18, color: Color.fromRGBO(28, 45, 62, 1))),
        Text('Telefone: ' + patient.last.phone,
            style:
                TextStyle(fontSize: 18, color: Color.fromRGBO(28, 45, 62, 1))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.PATIENT_REGISTRATION);
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              onPressed: () {
                final patientsController = context
                                                  .read<PatientController>();

                final response = patientsController.removePatient(patient.last.id ?? '');

                                              // if (response.statusCode == 204) {
                                              //   showSnackBar(context,
                                              //       'Profissional removido com sucesso!');
                                              // }
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        )
      ],
    );
  }
}
