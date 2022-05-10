import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/doctor.dart';

class PerfilDoctor extends StatelessWidget {
  // final Doctor _doctor;
  // const PerfilDoctor(this._doctor);
  @override
  Widget build(BuildContext context) {
    final Doctor doctor = ModalRoute.of(context)?.settings.arguments as Doctor;
    return Scaffold(
      appBar: AppBar(title: Text('${doctor.name}')),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new AssetImage(doctor.avatarUrl != null
                                  ? 'assets/${doctor.avatarUrl!}'
                                  : 'assets/user_default.png')))),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text('${doctor.name}', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                        Text('${doctor.speciality}'),
                        Text('${doctor.address}'),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Quarta (21 de fevereiro de 2022)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                '08:00 - 12:00',
                                style: TextStyle(color: Colors.black54),
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Hospital HappyVida, Zona Norte',
                                style: TextStyle(color: Colors.black54),
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                '6 horários disponíveis',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 15),
                              )),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushNamed('/create_schecule', arguments: doctor);
                            },
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'AGENDAR',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Color.fromRGBO(65, 188, 89, 1)),
                                )),
                          ),
                        ]),
                      )
                    ]),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
