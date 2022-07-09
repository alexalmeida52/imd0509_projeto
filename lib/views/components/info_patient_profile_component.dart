import 'package:flutter/material.dart';
import 'package:imd0509_projeto/controllers/patient_controller.dart';
import 'package:provider/provider.dart';

class InfoPatientProfile extends StatefulWidget {
  final dynamic value;
  final IconData icon;

  InfoPatientProfile(this.value, this.icon);

  @override
  State<InfoPatientProfile> createState() => _InfoPatientProfileState();
}

class _InfoPatientProfileState extends State<InfoPatientProfile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.value),
      leading: Icon(widget.icon),
      trailing: Icon(Icons.arrow_right),
    );
  }
}
