import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

Future<String> getCityName_() async {
  String cityName = "NotFound";
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

  if (isLocationServiceEnabled) {
    // Request permission to access the location
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      print("access denied");
    } else if (permission == LocationPermission.deniedForever) {
      print("access denied forever");
    } else {
      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print(position);

      final url =
          'https://nominatim.openstreetmap.org/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}';
      final response = await http.get(Uri.parse(url));
      print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['address']['city'] != Null) {
          cityName = data['address']['city'] ?? data['address']['county'];
          cityName = cityName.toLowerCase();
        }
      } else {
        throw Exception('Failed to get city name');
      }
    }
  } else {
    print("location service not enabled");
  }
  print("from getCityName_ cityname = $cityName");
  return cityName;
}
