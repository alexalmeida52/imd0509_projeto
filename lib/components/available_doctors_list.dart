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
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.CREATE_SCHEDULE
                        );
                      },
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network('https://cdn-icons-png.flaticon.com/512/219/219983.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(doctor.name),
                                  Text(doctor.speciality),
                                  Text(doctor.address)
                                ],
                              ),
                            ),
                            Icon(Icons.bookmark_outline_outlined, size: 40,),
                          ]
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
