import 'package:flutter/material.dart';
import 'package:imd0509_projeto/controllers/patient_controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateBirthdayComponent extends StatefulWidget {
  final Map arg;
  UpdateBirthdayComponent(this.arg);

  @override
  State<UpdateBirthdayComponent> createState() =>
      _UpdateBirthdayComponentState();
}

class _UpdateBirthdayComponentState extends State<UpdateBirthdayComponent> {

  DateTime _dataSelecionada = DateTime.now();
  @override
  void initState() {
    _dataSelecionada = DateTime.parse(widget.arg['value1']);

    super.initState();
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2023))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dataSelecionada = pickedDate;
      });
    });
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
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.arg['title']}',
                    style: TextStyle(
                        fontSize: 25, color: Theme.of(context).colorScheme.primary),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              '${DateFormat('dd/MM/yyyy').format(_dataSelecionada)}',
                              style: TextStyle(
                                fontSize: 40,
                                color: Theme.of(context).colorScheme.primary,
                                fontFamily: 'RobotoBold'
                              ),
                            ),
                          TextButton(
                              onPressed: _showDatePicker, child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.date_range),
                                  Text('Selecionar data'),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                String birthday = _dataSelecionada.toString();
      
                await Provider.of<PatientController>(context, listen: false)
                    .updateField(widget.arg['patientId'], 'birthday', birthday);
                Navigator.pop(context);
              },
              child: Text('Atualizar'))
        ],
      ),
    );
  }
}
