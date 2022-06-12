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
  final _lastNameController = TextEditingController();
  final _specialityController = TextEditingController();
  final _addressController = TextEditingController();
  final _avatarUrlController = TextEditingController();
  final _ratingController = TextEditingController();
  List<bool> errors = [false, false, false, false, false];


  _submitForm() async {
    final name = _nameController.text;
    final lastName = _lastNameController.text;
    final speciality = _specialityController.text;
    final address = _addressController.text;
    final avatarUrl = _avatarUrlController.text;
    final rating = _ratingController.text;

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

    errors = [false, false, false, false, false];

    final doctorController = context.read<DoctorController>();

    Doctor doctor; 
    if(widget.doctorEditing != null) {
      doctor = new Doctor(
          name: name,
          last_name: lastName,
          speciality: speciality,
          address: address,
          id: widget.doctorEditing!.id,
          avatarUrl: avatarUrl,
          rating: widget.doctorEditing!.rating
      );
    } else {
      doctor = new Doctor(
          name: name,
          last_name: lastName,
          speciality: speciality,
          address: address,
          avatarUrl: avatarUrl,
          // rating: int.parse(rating)
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
        _addressController.text = widget.doctorEditing!.address;
        _ratingController.text = widget.doctorEditing!.rating != null ? (widget.doctorEditing!.rating).toString() : '0';
        _avatarUrlController.text = widget.doctorEditing!.avatarUrl ?? '';
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
            if (widget.doctorEditing != null) Row(
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
              // keyboardType: TextInputType.number,
              // inputFormatters: <TextInputFormatter>[
              //   FilteringTextInputFormatter.digitsOnly,
              // ], // Only numbers can be entered
            ),
            SizedBox(height: 20,),
            TextField(
              onChanged: (value) => {setInputError(value, 0)},
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Endereço',
                helperText: errors[3] ? '*Campo obrigatório' : null,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: errors[3] ? Colors.red : Colors.green.shade200,
                      width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              onChanged: (value) => {setInputError(value, 4)},
              controller: _avatarUrlController,
              decoration: InputDecoration(
                labelText: 'Avatar url',
                helperText: errors[4] ? '*Campo obrigatório' : null,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: errors[4] ? Colors.red : Colors.green.shade200,
                      width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 20,),
            if (widget.doctorEditing == null) ElevatedButton(onPressed: _submitForm, child: Text('Cadastrar'))
          ]),
        ),
      ),
    );
  }
}
