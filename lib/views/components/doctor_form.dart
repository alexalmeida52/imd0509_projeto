import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:imd0509_projeto/controllers/doctor_controller.dart';
import 'package:imd0509_projeto/models/doctor.dart';
import 'package:imd0509_projeto/models/place.dart';
import 'package:imd0509_projeto/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imd0509_projeto/views/components/image_input.component.dart';
import 'package:imd0509_projeto/views/components/location_input.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class DoctorForm extends StatefulWidget {
  final Doctor? doctorEditing;
  final int? index;
  DoctorForm(this.doctorEditing, this.index);

  @override
  State<DoctorForm> createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  PlaceLocation placeLocation = new PlaceLocation(latitude: '0', longitude: '0');

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _specialityController = TextEditingController();
  final _ratingController = TextEditingController();
  List<bool> errors = [false, false, false, false, false];
  String? avatarUrl;

  _submitForm() async {
    final name = _nameController.text;
    final lastName = _lastNameController.text;
    final speciality = _specialityController.text;
    final rating = _ratingController.text;

    setState(() {
      if (name.isEmpty) {
        errors[0] = true;
      }
      if (speciality.isEmpty) {
        errors[1] = true;
      }
    });

    if (name.isEmpty || speciality.isEmpty) {
      return;
    }

    errors = [false, false, false, false, false];

    final doctorController = context.read<DoctorController>();

    Doctor doctor;
    if (widget.doctorEditing != null) {
      doctor = new Doctor(
        name: name,
        last_name: lastName,
        speciality: speciality,
        id: widget.doctorEditing!.id,
        avatarUrl: avatarUrl,
        rating: widget.doctorEditing!.rating,
        placeLocation: placeLocation
      );
    } else {
      doctor = new Doctor(
        name: name,
        last_name: lastName,
        speciality: speciality,
        avatarUrl: avatarUrl,
        // rating: int.parse(rating)
        placeLocation: placeLocation
      );
    }

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
      setState(() {
        _nameController.text = widget.doctorEditing!.name;
        _lastNameController.text = widget.doctorEditing!.last_name;
        // TODO
        // _addressController.text = widget.doctorEditing!.address;
        _ratingController.text = widget.doctorEditing!.rating != null
            ? (widget.doctorEditing!.rating).toString()
            : '0';
        avatarUrl = widget.doctorEditing!.avatarUrl ?? '';
        _specialityController.text =
            widget.doctorEditing!.speciality.toString();
      });
    }
    print('url $avatarUrl');
    super.initState();
  }

  void setPlaceLocation(PlaceLocation local) {
    placeLocation = local;
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
            if (widget.doctorEditing != null)
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
                  ElevatedButton(
                      onPressed: _submitForm, child: Icon(Icons.save))
                ],
              ),
            SizedBox(height: 20),
            ImageInput((String url) {
              avatarUrl = url;
            }, avatarUrl),
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
              onChanged: (value) => {setInputError(value, 1)},
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Sobrenome',
                helperText: errors[1] ? '*Campo obrigatório' : null,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: errors[1] ? Colors.red : Colors.green.shade200,
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
                helperText: errors[2] ? '*Campo obrigatório' : null,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: errors[2] ? Colors.red : Colors.green.shade200,
                      width: 2.0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            LocationInput(setPlaceLocation),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            if (widget.doctorEditing == null)
              ElevatedButton(onPressed: _submitForm, child: Text('Cadastrar'))
          ]),
        ),
      ),
    );
  }
}
