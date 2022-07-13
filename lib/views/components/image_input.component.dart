import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

import '../../controllers/upload_image_controller.dart';

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

    String url = await UploadImage.upload(_storedImage!);

    //pegar pasta que posso salvar documentos
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy(
      '${appDir.path}/$fileName',
    );
    widget.onSelectImage(url);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: _takePicture,
              child: Icon(
                Icons.add_a_photo,
                size: 25,
                color: Colors.green[200],
              ),
            )),
        Container(
          width: 180.0,
          height: 180.0,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 5, color: Theme.of(context).colorScheme.primary),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: _storedImage == null
                    ? AssetImage('assets/user_default.png') as ImageProvider
                    : FileImage(_storedImage!),
                fit: BoxFit.cover,
              )),
        ),
      ],
    );
  }
}
