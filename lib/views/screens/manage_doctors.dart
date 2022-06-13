import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imd0509_projeto/controllers/doctor_controller.dart';
import 'package:imd0509_projeto/controllers/patient_controller.dart';
import 'package:imd0509_projeto/models/doctor.dart';
import 'package:imd0509_projeto/utils/mock/doctorsList.dart';
import 'package:imd0509_projeto/views/components/main_drawer.dart';
import 'package:imd0509_projeto/views/screens/available_doctors.dart';
import 'package:provider/provider.dart';

import '../../utils/app_routes.dart';
import '../components/available_doctors_list.dart';

class ManageDoctors extends StatefulWidget {
  @override
  State<ManageDoctors> createState() => _ManageDoctorsState();
}

class _ManageDoctorsState extends State<ManageDoctors> {
  List<Doctor> doctorList = [];

  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  
  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<PatientController>(
      context,
      listen: false,
    ).savePatient(_formData).then((value) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final doctorController = Provider.of<DoctorController>(context);

    Future<List<Doctor>> getDoctors() async {
      print('Iniciando o fetch');
      print('chamando o controller');
      doctorList = await doctorController.fetchDoctorsList();
      print('controller retornou');
      return doctorList;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.HOME,
                );
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<List<Doctor>>(
              future:
                  getDoctors(), // Uso de um future para esperar a consulta a api
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('sucesso!!!');
                  return AvailableDoctorsList(
                      filteredListDoctors: doctorList, isManagement: true);
                } else {
                  return Text('Erro ao buscar dados');
                }
              }),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
