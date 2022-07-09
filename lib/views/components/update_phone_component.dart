import 'package:flutter/material.dart';
import 'package:imd0509_projeto/controllers/patient_controller.dart';
import 'package:provider/provider.dart';

class UpdatePhoneComponent extends StatefulWidget {
  final Map arg;
  UpdatePhoneComponent(this.arg);

  @override
  State<UpdatePhoneComponent> createState() =>
      _UpdatePhoneComponentState();
}

class _UpdatePhoneComponentState
    extends State<UpdatePhoneComponent> {
  final _phoneController = TextEditingController();
  @override
  void initState() {
    _phoneController.text = widget.arg['value1'];

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
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: '${widget.arg['label1']}',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green.shade200, width: 2.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                String phone = _phoneController.text;
      
                await Provider.of<PatientController>(context, listen: false)
                    .updateField(widget.arg['patientId'], 'phone', phone);
                Navigator.pop(context);
              },
              child: Text('Atualizar'))
        ],
      ),
    );
  }
}
