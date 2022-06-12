import 'package:flutter/material.dart';
import 'package:imd0509_projeto/controllers/doctor_controller.dart';
import 'package:imd0509_projeto/utils/app_routes.dart';
import 'package:imd0509_projeto/views/components/doctor_form.dart';
import 'package:provider/provider.dart';

import '../../models/doctor.dart';

class CreateDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar profissional'),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //       },
        //       icon: Icon(Icons.save)),
        // ],
      ),
      body: DoctorForm(null, null),
    );
  }
}
