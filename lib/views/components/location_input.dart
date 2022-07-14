import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imd0509_projeto/models/place.dart';
import 'package:imd0509_projeto/utils/location_util.dart';
import 'package:flutter/material.dart';
import 'package:imd0509_projeto/views/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  void Function(PlaceLocation) onSubmit;

  LocationInput(this.onSubmit);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  final _locationController = TextEditingController();

  Future<void> _getCurrentUserLocation() async {
    final locData =
        await Location().getLocation(); //pega localização do usuário

    //CARREGANDO NO MAPA

    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);

    String address =
        await LocationUtil.getAddress(locData.latitude!, locData.longitude!);
    print('Endereço encontrado');
    final _placeLocation = new PlaceLocation(
        latitude: locData.latitude!.toString(),
        longitude: locData.longitude!.toString(),
        address: address);

    setState(() {
      print(staticMapImageUrl);
      _previewImageUrl = staticMapImageUrl;
    });

    widget.onSubmit(_placeLocation);
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
          fullscreenDialog: true, builder: ((context) => MapScreen())),
    );

    if (selectedPosition == null) return;

    print(selectedPosition.latitude);
    print(selectedPosition.longitude);

    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: selectedPosition.latitude,
        longitude: selectedPosition.longitude);

    String address = await LocationUtil.getAddress(
        selectedPosition.latitude, selectedPosition.longitude);
    final _placeLocation = new PlaceLocation(
        latitude: selectedPosition.latitude.toString(),
        longitude: selectedPosition.longitude.toString(),
        address: address);

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
    print('Chamando o set de local');
    widget.onSubmit(_placeLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Text('Localização não informada!')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Localização atual'),
              onPressed: _getCurrentUserLocation,
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              label: Text('Selecione no Mapa'),
              onPressed: _selectOnMap,
            ),
          ],
        ),
        Column(
          children: [
            TextButton.icon(
              icon: Icon(Icons.edit),
              label: Text('Digite o endereço'),
              onPressed: () async {
                await showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            color: Colors.indigo,
                            width: double.infinity,
                            child: const Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Informe o endereço',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _locationController,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                  labelText: 'Endereço',
                                  helperText:
                                      'Ex.: Rua José Roque da Silva, 176, Poço Branco, RN'),
                            ),
                          ),
                          ElevatedButton.icon(
                              icon: Icon(Icons.add),
                              label: Text('Adicionar'),
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Theme.of(context).colorScheme.secondary,
                                onPrimary: Colors.black,
                                elevation: 5,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () async {
                                final String address = _locationController.text;

                                PlaceLocation placeLocation =
                                    await LocationUtil.getLocal(address);

                                String address_url = await LocationUtil.generateLocationPreviewImage(latitude: double.parse(placeLocation.latitude), longitude: double.parse(placeLocation.longitude));

                                 setState(() {
                                  _previewImageUrl = address_url;
                                });

                                widget.onSubmit(placeLocation);
                                Navigator.pop(context);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                    'Local adicionado',
                                    textAlign: TextAlign.center,
                                  )),
                                );
                              })
                        ],
                      );
                    });
              },
            ),
          ],
        )
      ],
    );
  }

}
