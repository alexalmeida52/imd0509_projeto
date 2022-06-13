import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PatientPerfil extends StatefulWidget {
  const PatientPerfil({Key? key}) : super(key: key);

  @override
  State<PatientPerfil> createState() => _PatientPerfilState();
}

class _PatientPerfilState extends State<PatientPerfil> {
  @override
  Widget build(BuildContext context) {
    return Text('perfil');
  }
}