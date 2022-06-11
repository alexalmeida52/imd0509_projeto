import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imd0509_projeto/views/components/main_drawer.dart';

class ManageDoctors extends StatelessWidget {
  const ManageDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      drawer: MainDrawer(),
    );
  }
}
