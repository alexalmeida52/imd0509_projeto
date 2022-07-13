import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

import '../../controllers/upload_image_controller.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  final String? avatarUrlOld;

  ImageInput(this.onSelectImage, this.avatarUrlOld);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  String? avatarUrl;
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

    String url = await UploadImage.upload(File(imageFile.path));
    setState(() {
      _storedImage = File(imageFile.path);
    });

    print('uploaded image \n $url');

    widget.onSelectImage(url);
  }

   _getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile =
        await _picker.pickImage(source: ImageSource.gallery) as XFile;

    if (imageFile == null) return;

    String url = await UploadImage.upload(File(imageFile.path));
    setState(() {
      _storedImage = File(imageFile.path);
    });

    widget.onSelectImage(url);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: InkWell(
            onTap: _getImage,
            child: Icon(
              Icons.file_upload_outlined,
              size: 25,
              color: Colors.green[200],
            ),
          )
        ),
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
                    ? widget.avatarUrlOld != null
                        ? NetworkImage(widget.avatarUrlOld!) as ImageProvider
                        : AssetImage('assets/user_default.png')
                    : FileImage(_storedImage!),
                fit: BoxFit.cover,
              )),
        ),
      ],
    );
  }
}
