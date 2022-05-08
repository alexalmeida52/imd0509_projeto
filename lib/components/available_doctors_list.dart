import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imd0509_projeto/utils/mock/doctorsList.dart';

import '../models/doctor.dart';
import '../utils/app_routes.dart';

class AvailableDoctorsList extends StatefulWidget {
  @override
  State<AvailableDoctorsList> createState() => _AvailableDoctorsListState();
}

class _AvailableDoctorsListState extends State<AvailableDoctorsList> {
  List<Doctor> doctorsList = doctorsListMocked;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: doctorsList.isEmpty
            ? Text('Nenhuma tarefa cadastrada')
            : ListView.builder(
                shrinkWrap: true,
                itemCount: doctorsList.length,
                itemBuilder: (context, index) {
                  final doctor = doctorsList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.CREATE_SCHEDULE
                      );
                    },
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(doctor.name),
                          Text(doctor.speciality),
                          Text(doctor.address)
                        ]
                      ),
                    ),
                  );
                },
              ));
  }
}
