import 'package:imd0509_projeto/controllers/doctor_controller.dart';
import 'package:imd0509_projeto/models/doctor.dart';
import 'package:imd0509_projeto/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DoctorForm extends StatefulWidget {
  final Doctor? doctorEditing;
  final int? index;
    DoctorForm(this.doctorEditing, this.index);

  @override
  State<DoctorForm> createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  final _nameController = TextEditingController();
  final _specialityController = TextEditingController();
  List<bool> errors = [false, false];


  _submitForm() async {
    final name = _nameController.text;
    final speciality = _specialityController.text;

    setState(() {
      if (name.isEmpty) {
        errors[0] = true;
      }
      if (speciality.isEmpty) {
        errors[1] = true;
      }
    });

    if (name.isEmpty ||
        speciality.isEmpty) {
      return;
    }

    errors = [false, false];

    final doctorController = context.read<DoctorController>();

    final doctor = new Doctor(
        name: name,
        speciality: speciality,
        address: 'Local',
        id: widget.doctorEditing!.id,
        avatarUrl: widget.doctorEditing!.avatarUrl,
        rating: widget.doctorEditing!.rating
    );

    await doctorController.saveDoctor(doctor);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        'Atualizado com sucesso!',
        textAlign: TextAlign.center,
      )),
    );

    Navigator.pop(context);
  }

  void setInputError(value, inputNumber) {
    setState(() {
      errors[inputNumber] = value.isEmpty ? true : false;
    });
  }

  List<Map<String, dynamic>> ls = [];

  @override
  void initState() {
    if (widget.doctorEditing != null) {
      print(widget.doctorEditing);
      setState(() {
        _nameController.text = widget.doctorEditing!.name;
        _specialityController.text = widget.doctorEditing!.speciality.toString();
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Editar informações',
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                ElevatedButton(onPressed: _submitForm, child: Icon(Icons.save))
              ],
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => {setInputError(value, 0)},
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
                helperText: errors[0] ? '*Campo obrigatório' : null,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: errors[0] ? Colors.red : Colors.green.shade200,
                      width: 2.0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _specialityController,
              decoration: InputDecoration(
                labelText: 'Especialidade',
                helperText: errors[1] ? '*Campo obrigatório' : null,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: errors[1] ? Colors.red : Colors.green.shade200,
                      width: 2.0),
                ),
              ),
              // keyboardType: TextInputType.number,
              // inputFormatters: <TextInputFormatter>[
              //   FilteringTextInputFormatter.digitsOnly,
              // ], // Only numbers can be entered
            )
          ]),
        ),
      ),
    );
  }
}
