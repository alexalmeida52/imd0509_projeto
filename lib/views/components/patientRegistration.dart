import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:imd0509_projeto/controllers/patient_controller.dart';
import 'package:imd0509_projeto/models/patient.dart';
import 'package:provider/provider.dart';

class PatientRegistration extends StatefulWidget {
  // final Patient? patientEditing;
  // final int? index;
  // PatientRegistration(this.patientEditing, this.index);
  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  

  final _priceFocus = FocusNode();
  final _emailFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final patient = arg as Patient;
        _formData['name'] = patient.name;
        _formData['last_name'] = patient.last_name;
        _formData['gender'] = patient.gender;
        _formData['email'] = patient.email;
        _formData['password'] = patient.password;
        _formData['birthday'] = patient.birthday;
        _formData['phone'] = patient.phone;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _emailFocus.dispose();
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    // Provider.of<PatientController>(
    //   context,
    //   listen: false,
    // ).savePatient(_formData).then((value) {
    //   Navigator.pop(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro Perfil'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['name']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (_name) {
                  final name = _name ?? '';

                  if (name.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }

                  if (name.trim().length < 3) {
                    return 'Nome precisa no mínimo de 3 letras.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['last_name']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Sobrenome',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (last_name) =>
                    _formData['last_name'] = last_name ?? '',
                validator: (_last_name) {
                  final last_name = _last_name ?? '';

                  if (last_name.trim().isEmpty) {
                    return 'Sobrenome é obrigatório';
                  }

                  if (last_name.trim().length < 3) {
                    return 'Sobrenome precisa no mínimo de 3 letras.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['birthday']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Data de nascimento',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (birthday) => _formData['birthday'] = birthday ?? '',
                validator: (_birthday) {
                  final birthday = _birthday ?? '';

                  if (birthday.trim().isEmpty) {
                    return 'Data de nascimento é obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['gender']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Sexo: ',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (gender) => _formData['gender'] = gender ?? '',
                validator: (_gender) {
                  final gender = _gender ?? '';

                  if (gender.trim().isEmpty) {
                    return 'Data de nascimento é obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: _formData['phone']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Telefone',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (phone) => _formData['phone'] = phone ?? '',
                validator: (_phone) {
                  final phone = _phone ?? '';

                  if (phone.trim().isEmpty) {
                    return 'Telefone é obrigatório';
                  }

                  if (phone.trim().length < 3) {
                    return 'Telefone precisa no mínimo de 9 digítos.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['email']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (email) => _formData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';

                  if (email.trim().isEmpty) {
                    return 'Email é obrigatório';
                  }

                  if (email.trim().length < 10) {
                    return 'Email precisa no mínimo de 3 letras.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['password']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (password) => _formData['password'] = password ?? '',
                validator: (_password) {
                  final password = _password ?? '';

                  if (password.trim().isEmpty) {
                    return 'Senha é obrigatório';
                  }

                  if (password.trim().length < 3) {
                    return 'Senha precisa de no mínimo de 6 digítos.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
