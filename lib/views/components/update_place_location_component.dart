import 'package:flutter/material.dart';
import 'package:imd0509_projeto/controllers/patient_controller.dart';
import 'package:imd0509_projeto/models/place.dart';
import 'package:imd0509_projeto/views/components/location_input.dart';
import 'package:provider/provider.dart';

class UpdatePlaceLocationComponent extends StatefulWidget {
  final Map arg;
  UpdatePlaceLocationComponent(this.arg);

  @override
  State<UpdatePlaceLocationComponent> createState() =>
      _UpdatePlaceLocationComponentState();
}

class _UpdatePlaceLocationComponentState
    extends State<UpdatePlaceLocationComponent> {
  PlaceLocation placeLocation = PlaceLocation(latitude: '', longitude: '', address: '');

  @override
  void initState() {
    super.initState();
  }

  void setPlaceLocation(PlaceLocation local) {
    placeLocation = local;
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
              LocationInput(setPlaceLocation)
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();

                await Provider.of<PatientController>(context, listen: false)
                    .updateField(
                        widget.arg['patientId'], 'lat', placeLocation.latitude);
                await Provider.of<PatientController>(context, listen: false)
                    .updateField(
                        widget.arg['patientId'], 'long', placeLocation.longitude);
                await Provider.of<PatientController>(context, listen: false)
                    .updateField(widget.arg['patientId'], 'address',
                        placeLocation.address);
                Navigator.pop(context);
              },
              child: Text('Atualizar'))
        ],
      ),
    );
  }
}
