import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:imd0509_projeto/controllers/doctor_controller.dart';
import 'package:imd0509_projeto/controllers/patient_controller.dart';
import 'package:imd0509_projeto/models/patient.dart';
import 'package:imd0509_projeto/utils/mock/patientList.dart';
import 'package:imd0509_projeto/views/components/patientList.dart';
import 'package:imd0509_projeto/views/components/patientPerfil.dart';
import 'package:imd0509_projeto/views/components/patientRegistration.dart';
import 'package:provider/provider.dart';

class Perfil extends StatefulWidget {
  
  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  List<Patient> _patient = patientListMocked;
  

  initState() {
    
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    final patientController = Provider.of<PatientController>(context);
    bool firstConnect = true;
    // Future<List<Patient>> getPatients() async {
    //   print('Iniciando o fetch');
    //   print('chamando o controller');
    //   _filterListPatients = await patientController.fetchPatientList();
    //   print('controller retornou');
    //   return _filterListPatients;
    // } 
    void toogleFirstConnection(bool firstConnect){
      firstConnect = false;
    }
    
    return Container(
      color: Color.fromRGBO(242, 242, 242, 1),
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0, left: 18.0, right: 18.0),
        child:  _patient[0].isFirstConnection == true ? PatientRegistration() : PatientPerfil() 
      ),
    );
  }
}
