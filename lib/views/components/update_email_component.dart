import 'package:flutter/material.dart';
import 'package:imd0509_projeto/controllers/patient_controller.dart';
import 'package:provider/provider.dart';

class UpdateEmailComponent extends StatefulWidget {
  final Map arg;
  UpdateEmailComponent(this.arg);

  @override
  State<UpdateEmailComponent> createState() =>
      _UpdateEmailComponentState();
}

class _UpdateEmailComponentState
    extends State<UpdateEmailComponent> {
  final _emailController = TextEditingController();
  @override
  void initState() {
    _emailController.text = widget.arg['value1'];

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
                      controller: _emailController,
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
                String email = _emailController.text;
      
                await Provider.of<PatientController>(context, listen: false)
                    .updateField(widget.arg['patientId'], 'email', email);
                Navigator.pop(context);
              },
              child: Text('Atualizar'))
        ],
      ),
    );
  }
}
