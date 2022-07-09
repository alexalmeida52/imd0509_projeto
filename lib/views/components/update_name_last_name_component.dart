import 'package:flutter/material.dart';
import 'package:imd0509_projeto/controllers/patient_controller.dart';
import 'package:provider/provider.dart';

class UpdateNameLastNameComponent extends StatefulWidget {
  final Map arg;
  UpdateNameLastNameComponent(this.arg);

  @override
  State<UpdateNameLastNameComponent> createState() =>
      _UpdateNameLastNameComponentState();
}

class _UpdateNameLastNameComponentState
    extends State<UpdateNameLastNameComponent> {
  final _nameController = TextEditingController();

  final _lastNameController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.arg['value1'];
    _lastNameController.text = widget.arg['value2'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 28.0, bottom: 0.0, left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.arg['title']}',
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: '${widget.arg['label1']}',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green.shade200, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: '${widget.arg['label2']}',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green.shade200, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                String name = _nameController.text;
                String lastName = _lastNameController.text;
      
                await Provider.of<PatientController>(context, listen: false)
                    .updateField(widget.arg['patientId'], 'name', name);
                await Provider.of<PatientController>(context, listen: false)
                    .updateField(
                        widget.arg['patientId'], 'last_name', lastName);
                Navigator.pop(context);
              },
              child: Text('Atualizar'))
        ],
      ),
    );
  }
}
