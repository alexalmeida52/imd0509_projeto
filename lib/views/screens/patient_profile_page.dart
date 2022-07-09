import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imd0509_projeto/controllers/patient_controller.dart';
import 'package:imd0509_projeto/views/components/patient_profile_component.dart';
import 'package:provider/provider.dart';

class PatientProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PatientProfileComponent(),
      backgroundColor:  Colors.white12,
    );
    
  }
}
