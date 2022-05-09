import 'package:flutter/material.dart';
import 'package:imd0509_projeto/components/available_doctors_list.dart';

import '../utils/app_routes.dart';

class AvailableDoctors extends StatefulWidget {
  @override
  State<AvailableDoctors> createState() => _AvailableDoctorsState();
}

class _AvailableDoctorsState extends State<AvailableDoctors> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Médicos disponíveis', 
            style: TextStyle(
              color: Color.fromRGBO(28, 45, 62, 1),
              fontSize: 26
            ),
          ),
          SizedBox(
            height: 20,
          ),
          AvailableDoctorsList()
        ],
      ),
    );
  }
}
