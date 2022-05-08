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
    return Column(
      children: [
        AvailableDoctorsList()
      ],
    );
  }
}
