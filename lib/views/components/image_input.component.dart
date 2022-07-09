import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  //Capturando Imagem
  File? _storedImage;
  File? _image;

  _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
      _image = null;
    });

    //pegar pasta que posso salvar documentos
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy(
      '${appDir.path}/$fileName',
    );
    widget.onSelectImage(savedImage);
  }

  _getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile =
        await _picker.pickImage(source: ImageSource.gallery) as XFile;

    if (imageFile == null) return;

    setState(() {
      _image = File(imageFile.path);
      _storedImage = null;
    });

    widget.onSelectImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          //child: Text('Nenhuma imagem!'),
          //verificar se tem imagem
          child: _storedImage != null || _image != null
              ? Image.file(
                  _storedImage ?? _image!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Text('Nenhuma Imagem!'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              TextButton.icon(
                icon: Icon(Icons.camera),
                label: Text('Tirar foto'),
                onPressed: _takePicture,
              ),
              TextButton.icon(
                icon: Icon(Icons.add_a_photo),
                label: Text('Anexar foto'),
                onPressed: _getImage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
