import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imd0509_projeto/controllers/doctor_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    final doctorController =
        Provider.of<DoctorController>(context, listen: false);

    Future<List<Doctor>> getDoctors() async {
      print('Iniciando o fetch');
      print('chamando o controller');
      final response = await doctorController.fetchDoctorsList();
      print('controller retornou');
      return response;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.CADASTRAR_PROFISSIONAIS,
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
                  return Consumer<DoctorController>(
                      builder: (context, doctors, child) {
                    return AvailableDoctorsList(
                        filteredListDoctors: doctors.getDoctors(), 
                        isManagement: true
                    );
                  });
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
