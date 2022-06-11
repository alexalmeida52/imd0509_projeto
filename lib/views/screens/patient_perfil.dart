import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:imd0509_projeto/controllers/doctor_controller.dart';
import 'package:imd0509_projeto/controllers/patient_controller.dart';
import 'package:imd0509_projeto/models/patient.dart';
import 'package:imd0509_projeto/utils/mock/patientList.dart';
import 'package:provider/provider.dart';

class PatientPerfil extends StatefulWidget {
  @override
  State<PatientPerfil> createState() => _PatientPerfilState();
}

class _PatientPerfilState extends State<PatientPerfil> {
  List<Patient> _patientsList = patientListMocked;
  List<Patient> _filterListPatients = [];
  String _searchText = '';
  final _searchPatientsController = TextEditingController();

  initState() {
    super.initState();
  }

  _filterPatients(String value) {
    setState(() {
      _filterListPatients = _patientsList
          .where((patient) =>
              patient.name.toLowerCase().contains(value.toLowerCase()) ||
              value == '')
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final patientController = Provider.of<PatientController>(context);

    Future<List<Patient>> getPatients() async {
      print('Iniciando o fetch');
      print('chamando o controller');
      _filterListPatients = await patientController.fetchPatientList();
      print('controller retornou');
      return _filterListPatients;
    }

    return Container(
      color: Color.fromRGBO(242, 242, 242, 1),
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0, left: 18.0, right: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchPatientsController,
              // onChanged: _filterDoctors,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                    onTap: () {
                      _searchPatientsController.text = '';
                      // _filterDoctors(_searchDoctorController.text);
                    },
                    child: Icon(Icons.close)),
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(18.0),
                label: Text(
                  'Nome do paciente',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                      fontWeight: FontWeight.bold),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                    borderRadius: BorderRadius.circular(0)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Lista pacientes',
              style:
                  TextStyle(color: Color.fromRGBO(28, 45, 62, 1), fontSize: 26),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount:_filterListPatients.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final patient = _filterListPatients[index];
                     return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Stack(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(patient.name + ' ' + patient.last_name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color:
                                                    Color.fromRGBO(28, 45, 62, 1))),
                                        Text('Sexo: ' + patient.gender + ' Nascimento: ' + patient.birthday ,
                                            style: TextStyle(
                                                color:
                                                    Color.fromRGBO(28, 45, 62, 1))),                                        
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(onPressed: (){}, icon: Icon(Icons.edit),color:  Theme.of(context).colorScheme.primary),
                                        IconButton(onPressed: (){}, icon: Icon(Icons.delete), color: Colors.red,)
                                      ],
                                    )
                                  ]),
                            ),
                          ),
                        ]
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
