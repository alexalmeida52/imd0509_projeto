import 'dart:convert';

import 'package:imd0509_projeto/models/place.dart';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyC_g-I-mmIwEoXukxrY9hF4ku0tIefsgHE';

class LocationUtil {
  static String generateLocationPreviewImage({
    double? latitude,
    double? longitude,
  }) {
    //https://developers.google.com/maps/documentation/maps-static/overview
    //https://pub.dev/packages/google_maps_flutter
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAddress(double lat, double long) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${long}&key=AIzaSyC_g-I-mmIwEoXukxrY9hF4ku0tIefsgHE'));
    final map = jsonDecode(response.body).cast<String, dynamic>();
    final result = map['results'][0]['formatted_address'];

    print(result);
    return result;
  }

  static Future<PlaceLocation> getLocal(String address) async {
    final response = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=AIzaSyC_g-I-mmIwEoXukxrY9hF4ku0tIefsgHE'));

    final map = jsonDecode(response.body).cast<String, dynamic>();
    
    return PlaceLocation(
      latitude: map['results'][0]['geometry']['location']['lat'].toString(), 
      longitude: map['results'][0]['geometry']['location']['lng'].toString(),
      address: map['results'][0]['formatted_address']
    );
  }

}
// https://maps.googleapis.com/maps/api/geocode/json?latlng=-5.6192591,-35.6677319&key=AIzaSyC_g-I-mmIwEoXukxrY9hF4ku0tIefsgHE
// https://maps.googleapis.com/maps/api/geocode/json?address=176+rua+jose+roque+da+silva&key=AIzaSyC_g-I-mmIwEoXukxrY9hF4ku0tIefsgHE