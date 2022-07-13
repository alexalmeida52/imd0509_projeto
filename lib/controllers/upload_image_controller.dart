import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UploadImage {
  static final String baseUrl = 'https://ucarecdn.com';
  static Future<String> upload(File imageFile) async {
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse('https://upload.uploadcare.com/base/');

    var request = http.MultipartRequest('POST', uri);
    var multipartFile = http.MultipartFile('uploadedfile', stream, length,
        filename: imageFile.path);

    request.files.add(multipartFile);
    request.fields.addAll({'UPLOADCARE_PUB_KEY': 'demopublickey'});

    final response = await request.send();
    final strResponse = await response.stream.bytesToString();
    final map = jsonDecode(strResponse);
    return '$baseUrl/${map['uploadedfile']}/';
  }
}
