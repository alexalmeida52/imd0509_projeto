import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imd0509_projeto/controllers/doctor_controller.dart';
import 'package:imd0509_projeto/utils/mock/doctorsList.dart';
import 'package:imd0509_projeto/views/components/doctor_form.dart';
import 'package:provider/provider.dart';

import '../../models/doctor.dart';
import '../../utils/app_routes.dart';

class AvailableDoctorsList extends StatefulWidget {
  List<Doctor> filteredListDoctors;
  bool? isManagement;

  AvailableDoctorsList(
      {required this.filteredListDoctors, this.isManagement = false});

  @override
  State<AvailableDoctorsList> createState() => _AvailableDoctorsListState();
}

class _AvailableDoctorsListState extends State<AvailableDoctorsList> {
  // void _selectedDoctor(Doctor doctor) {
  //   Navigator.of(context).pushNamed('/perfil-doctor', arguments: doctor);
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.filteredListDoctors.length);
    return Container(
        child: widget.filteredListDoctors.isEmpty
            ? Text('Nenhum profissional encontrado')
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.filteredListDoctors.length,
                  itemBuilder: (context, index) {
                    final doctor = widget.filteredListDoctors[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Stack(children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(doctor
                                                      .avatarUrl ??
                                                  'https://cdn-icons-png.flaticon.com/512/219/219986.png')))),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(doctor.name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromRGBO(
                                                  28, 45, 62, 1))),
                                      Text(doctor.speciality,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  28, 45, 62, 1))),
                                      Text(doctor.address,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  28, 45, 62, 1))),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    '/profile_doctor',
                                                    arguments: doctor);
                                                //_selectedDoctor(doctor);
                                              },
                                              child: Text('Perfil')),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            width: 100,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          '/create_schecule',
                                                          arguments: doctor);
                                                },
                                                child:
                                                    Text('Agendar consulta')),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  if (!widget.isManagement!)
                                    Icon(
                                      Icons.bookmark_outline_outlined,
                                      size: 40,
                                      color: Color.fromRGBO(28, 45, 62, 1),
                                    ),
                                  if (widget.isManagement!)
                                    Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            showModalBottomSheet<void>(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SingleChildScrollView(
                                                  child: Container(child: DoctorForm(doctor, index)),
                                                );
                                              },
                                            );

                                            // ScaffoldMessenger.of(context).showSnackBar(
                                            //   SnackBar(
                                            //       content: Text(
                                            //     'Lugar atualizado com sucesso!',
                                            //     textAlign: TextAlign.center,
                                            //   )),
                                            // );
                                          },
                                          child: Icon(Icons.edit),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.blue),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            final isRemoving =
                                                await showDialog<bool>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: const Text(
                                                  'Atenção!',
                                                  style: TextStyle(
                                                      color: Colors.orange,
                                                      fontSize: 24),
                                                ),
                                                content: const Text(
                                                    'Você tem certeza que deseja apagar o profissional?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, false),
                                                    child:
                                                        const Text('Cancelar'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, true),
                                                    child:
                                                        const Text('Confirmar'),
                                                  ),
                                                ],
                                              ),
                                            );

                                            if (isRemoving!) {
                                              final doctorsController = context
                                                  .read<DoctorController>();

                                              final response = await doctorsController.remove(doctor.id);

                                              if (response.statusCode == 204) {
                                                showSnackBar(context,
                                                    'Profissional removido com sucesso!');
                                              }
                                            }
                                          },
                                          child: Icon(Icons.delete),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red),
                                        ),
                                      ],
                                    )
                                ]),
                          ),
                        ),
                      ]),
                    );
                  },
                ),
              ));
  }

  showSnackBar(context, String desc) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        '$desc',
        textAlign: TextAlign.center,
      )),
    );
  }

  alert(context) {
    AlertDialog(
      title: const Text('Selecione os países'),
      content:
          SingleChildScrollView(child: Text('Tem certeza que deseja remover?')),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: const Text('Confirmar'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
