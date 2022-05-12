import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imd0509_projeto/utils/mock/doctorsList.dart';

import '../models/doctor.dart';
import '../utils/app_routes.dart';

class AvailableDoctorsList extends StatefulWidget {
  List<Doctor> _filteredListDoctors;

  AvailableDoctorsList(this._filteredListDoctors);

  @override
  State<AvailableDoctorsList> createState() => _AvailableDoctorsListState();
}

class _AvailableDoctorsListState extends State<AvailableDoctorsList> {
  // void _selectedDoctor(Doctor doctor) {
  //   Navigator.of(context).pushNamed('/perfil-doctor', arguments: doctor);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget._filteredListDoctors.isEmpty
            ? Text('Nenhum profissional encontrado')
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget._filteredListDoctors.length,
                  itemBuilder: (context, index) {
                    final doctor = widget._filteredListDoctors[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new AssetImage(doctor
                                                        .avatarUrl !=
                                                    null
                                                ? 'assets/${doctor.avatarUrl!}'
                                                : 'assets/user_default.png')))),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(doctor.name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromRGBO(
                                                28, 45, 62, 1))),
                                    Text(doctor.speciality,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                28, 45, 62, 1))),
                                    Text(doctor.address,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                28, 45, 62, 1))),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  '/profile_doctor',
                                                  arguments: doctor);
                                              //_selectedDoctor(doctor);
                                            },
                                            child: Text('Perfil')),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          width: 100,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushNamed(
                                                        '/create_schecule',
                                                        arguments: doctor);
                                              },
                                              child:
                                                  Text('Agendar consulta')),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Icon(
                                  Icons.bookmark_outline_outlined,
                                  size: 40,
                                  color: Color.fromRGBO(28, 45, 62, 1),
                                ),
                              ]),
                        ),
                      ),
                    );
                  },
                ),
              ));
  }
}
