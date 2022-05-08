import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecionar horário')),
      body: Center(
        child: Container(
          child: Text('Criar agendamento'),
        ),
      ),
    );
  }
}
