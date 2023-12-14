import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_weather_app/modules/manage_location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WeatherData {
  final double cityCoordLat;
  final double cityCoordLon;
  final String cityCountry;
  final int cityId;
  final String cityName;
  final String citySunRise;
  final String citySunSet;
  final int cityTimezone;
  final String cloudsName;
  final int cloudsValue;
  final String dateTime;
  final String feelsLikeUnit;
  final double feelsLikeValue;
  final String humidityUnit;
  final int humidityValue;
  final String precipitationMode;
  final String pressureUnit;
  final int pressureValue;
  final double temperatureMax;
  final double temperatureMin;
  final String temperatureUnit;
  final double temperatureValue;
  final int visibilityValue;
  final String weatherIcon;
  final int weatherNumber;
  final String weatherValue;
  final String windDirectionCode;
  final String windDirectionName;
  final double windDirectionValue;
  final String windSpeedName;
  final String windSpeedUnit;
  final double windSpeedValue;

  WeatherData(
      {required this.cityCoordLat,
      required this.cityCoordLon,
      required this.cityCountry,
      required this.cityId,
      required this.cityName,
      required this.citySunRise,
      required this.citySunSet,
      required this.cityTimezone,
      required this.cloudsName,
      required this.cloudsValue,
      required this.dateTime,
      required this.feelsLikeUnit,
      required this.feelsLikeValue,
      required this.humidityUnit,
      required this.humidityValue,
      required this.precipitationMode,
      required this.pressureUnit,
      required this.pressureValue,
      required this.temperatureMax,
      required this.temperatureMin,
      required this.temperatureUnit,
      required this.temperatureValue,
      required this.visibilityValue,
      required this.weatherIcon,
      required this.weatherNumber,
      required this.weatherValue,
      required this.windDirectionCode,
      required this.windDirectionName,
      required this.windDirectionValue,
      required this.windSpeedName,
      required this.windSpeedUnit,
      required this.windSpeedValue});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityCoordLat: (json['city_coord_lat'] as num?)?.toDouble() ?? 0.0,
      cityCoordLon: (json['city_coord_lon'] as num?)?.toDouble() ?? 0.0,
      cityCountry: json['city_country'] as String? ?? "",
      cityId: (json['city_id'] as int?) ?? 0,
      cityName: json['city_name'] as String? ?? "",
      citySunRise: json['city_sun_rise'] as String? ?? "",
      citySunSet: json['city_sun_set'] as String? ?? "",
      cityTimezone: (json['city_timezone'] as int?) ?? 0,
      cloudsName: json['clouds_name'] as String? ?? "",
      cloudsValue: (json['clouds_value'] as int?) ?? 0,
      dateTime: json['date_time'] as String? ?? "",
      feelsLikeUnit: json['feels_like_unit'] as String? ?? "",
      feelsLikeValue: (json['feels_like_value'] as num?)?.toDouble() ?? 0.0,
      humidityUnit: json['humidity_unit'] as String? ?? "",
      humidityValue: (json['humidity_value'] as int?) ?? 0,
      precipitationMode: json['precipitation_mode'] as String? ?? "",
      pressureUnit: json['pressure_unit'] as String? ?? "",
      pressureValue: (json['pressure_value'] as int?) ?? 0,
      temperatureMax: (json['temperature_max'] as num?)?.toDouble() ?? 0.0,
      temperatureMin: (json['temperature_min'] as num?)?.toDouble() ?? 0.0,
      temperatureUnit: json['temperature_unit'] as String? ?? "",
      temperatureValue: (json['temperature_value'] as num?)?.toDouble() ?? 0.0,
      visibilityValue: (json['visibility_value'] as int?) ?? 0,
      weatherIcon: json['weather_icon'] as String? ?? "",
      weatherNumber: (json['weather_number'] as int?) ?? 0,
      weatherValue: json['weather_value'] as String? ?? "",
      windDirectionCode: json['wind_direction_code'] as String? ?? "",
      windDirectionName: json['wind_direction_name'] as String? ?? "",
      windDirectionValue:
          (json['wind_direction_value'] as num?)?.toDouble() ?? 0.0,
      windSpeedName: json['wind_speed_name'] as String? ?? "",
      windSpeedUnit: json['wind_speed_unit'] as String? ?? "",
      windSpeedValue: (json['wind_speed_value'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class ForecastData {
  final int cloudsAll;
  final String cloudsUnit;
  final String cloudsValue;
  final String feelsLikeUnit;
  final double feelsLikeValue;
  final String from;
  final String humidityUnit;
  final int humidityValue;
  final double precipitationProbability;
  final String precipitationType;
  final String precipitationUnit;
  final double precipitationValue;
  final String pressureUnit;
  final int pressureValue;
  final String symbolName;
  final int symbolNumber;
  final String symbolVar;
  final double tempMax;
  final double tempMin;
  final String tempUnit;
  final double tempValue;
  final String to;
  final int visibilityValue;
  final String windDirectionCode;
  final int windDirectionDeg;
  final String windDirectionName;
  final double windGustGust;
  final String windGustUnit;
  final double windSpeedMps;
  final String windSpeedName;
  final String windSpeedUnit;

  ForecastData({
    required this.cloudsAll,
    required this.cloudsUnit,
    required this.cloudsValue,
    required this.feelsLikeUnit,
    required this.feelsLikeValue,
    required this.from,
    required this.humidityUnit,
    required this.humidityValue,
    required this.precipitationProbability,
    required this.precipitationType,
    required this.precipitationUnit,
    required this.precipitationValue,
    required this.pressureUnit,
    required this.pressureValue,
    required this.symbolName,
    required this.symbolNumber,
    required this.symbolVar,
    required this.tempMax,
    required this.tempMin,
    required this.tempUnit,
    required this.tempValue,
    required this.to,
    required this.visibilityValue,
    required this.windDirectionCode,
    required this.windDirectionDeg,
    required this.windDirectionName,
    required this.windGustGust,
    required this.windGustUnit,
    required this.windSpeedMps,
    required this.windSpeedName,
    required this.windSpeedUnit,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    return ForecastData(
      cloudsAll: (json['clouds_all'] as int?) ?? 0,
      cloudsUnit: json['clouds_unit'] as String? ?? '',
      cloudsValue: json['clouds_value'] as String? ?? '',
      feelsLikeUnit: json['feels_like_unit'] as String? ?? '',
      feelsLikeValue: (json['feels_like_value'] as num?)?.toDouble() ?? 0.0,
      from: json['from_'] as String? ?? '',
      humidityUnit: json['humidity_unit'] as String? ?? '',
      humidityValue: (json['humidity_value'] as int?) ?? 0,
      precipitationProbability:
          (json['precipitation_probability'] as num?)?.toDouble() ?? 0.0,
      precipitationType: json['precipitation_type'] as String? ?? '',
      precipitationUnit: json['precipitation_unit'] as String? ?? '',
      precipitationValue:
          (json['precipitation_value'] as num?)?.toDouble() ?? 0.0,
      pressureUnit: json['pressure_unit'] as String? ?? '',
      pressureValue: (json['pressure_value'] as int?) ?? 0,
      symbolName: json['symbol_name'] as String? ?? '',
      symbolNumber: (json['symbol_number'] as int?) ?? 0,
      symbolVar: json['symbol_var'] as String? ?? '',
      tempMax: (json['temperature_max'] as num?)?.toDouble() ?? 0.0,
      tempMin: (json['temperature_min'] as num?)?.toDouble() ?? 0.0,
      tempUnit: json['temperature_unit'] as String? ?? '',
      tempValue: (json['temperature_value'] as num?)?.toDouble() ?? 0.0,
      to: json['to_'] as String? ?? '',
      visibilityValue: (json['visibility_value'] as int?) ?? 0,
      windDirectionCode: json['windDirection_code'] as String? ?? '',
      windDirectionDeg: (json['windDirection_deg'] as int?) ?? 0,
      windDirectionName: json['windDirection_name'] as String? ?? '',
      windGustGust: (json['windGust_gust'] as num?)?.toDouble() ?? 0.0,
      windGustUnit: json['windGust_unit'] as String? ?? '',
      windSpeedMps: (json['windSpeed_mps'] as num?)?.toDouble() ?? 0.0,
      windSpeedName: json['windSpeed_name'] as String? ?? '',
      windSpeedUnit: json['windSpeed_unit'] as String? ?? '',
    );
  }
}

class DataModel extends ChangeNotifier {
  late String cityName = '';
  List<WeatherData> weatherData = [];
  List<ForecastData> forecastData = [];
  bool dataFetchedOnce = false;

  get getWeatherData {
    cityName;
    weatherData;
    forecastData;
    dataFetchedOnce;
  }

  Future<int> setCityNameGeolocate() async {
    String temp = await getCityName_();
    if (temp != "NotFound") {
      if (temp.toLowerCase() != cityName) {
        dataFetchedOnce = false;
      }
      cityName = temp;
      notifyListeners();
      print("Notified");
      print("cityName changed to : $cityName");
      await saveCitynameLocally(cityName);
      return 0;
    } else {
      return 1;
    }
  }

  Future<int> setCityName(String cityname) async {
    if (cityname.toLowerCase() != cityName) {
      dataFetchedOnce = false;
    }
    cityName = cityname;
    notifyListeners();
    print("Notified");
    print("cityName changed to : $cityName");
    await saveCitynameLocally(cityName);
    return 0;
  }

  Future<int> fetchWeatherData() async {
    // get weatherData from the flask server and set it onto the getter variable
    final response = await http.get(Uri.parse(
        'http://localhost:5000/api/weather?city_name=${cityName.toLowerCase()}'));
    if (response.statusCode == 200) {
      if (response.body.toString() == "\"error\"") {
        print("Error in fetching data from python server.");
        return 1;
      }
      String jsonString = response.body.toString().replaceAll("NaN", "null");
      try {
        final List<dynamic> jsonList = json.decode(jsonString);
        weatherData =
            jsonList.map((json) => WeatherData.fromJson(json)).toList();
      } catch (e) {
        print('Error decoding JSON: $e');
        weatherData = [];
        return 1;
      }
      notifyListeners();
      return 0;
    } else {
      weatherData = [];
      return 1;
    }
  }

  Future<int> fetchForecastData() async {
    // get forecastData from the flask server and set it onto the getter variable
    final response = await http.get(Uri.parse(
        'http://localhost:5000/api/forecast?city_name=${cityName.toLowerCase()}'));
    if (response.statusCode == 200) {
      if (response.body.toString() == "\"error\"") {
        print("Error in fetching data from python server.");
        return 1;
      }
      String jsonString = response.body.toString().replaceAll("NaN", "null");
      try {
        final List<dynamic> jsonList = json.decode(jsonString);
        forecastData =
            jsonList.map((json) => ForecastData.fromJson(json)).toList();
      } catch (e) {
        print('Error decoding JSON: $e');
        weatherData = [];
        return 1;
      }
      print("forcast data has ${forecastData.length} items ");
      notifyListeners();
      return 0;
    } else {
      forecastData = [];
      return 1;
    }
  }

  Future<int> fetchNewData(String mode) async {
    // get forecastData from the flask server and set it onto the getter variable
    late final http.Response response;
    if (mode == "LocalHost") {
      response = await http.get(Uri.parse(
          'http://localhost:5000/api/weather_n_forecast?city_name=${cityName.toLowerCase()}'));
    } else if (mode == "Remote") {
      response = await http.get(Uri.parse(
          'http://192.168.101.8:5000/api/weather_n_forecast?city_name=${cityName.toLowerCase()}'));
      // response = await http.get(Uri.parse(
      //     'http://10.5.131.228:5000/api/weather_n_forecast?city_name=${cityName.toLowerCase()}'));
    } else {
      return 1;
    }

    if (response.statusCode == 200) {
      if (response.body.toString() == "\"error\"") {
        print("Error in fetching data from python server.");
        return 1;
      }
      String jsonString = response.body.toString().replaceAll("NaN", "null");
      try {
        final Map<String, dynamic> jsonData = json.decode(jsonString);
        final List<dynamic> weatherList = jsonData['weather_data'];
        final List<dynamic> forecastList = jsonData['forecast_data'];
        weatherData =
            weatherList.map((json) => WeatherData.fromJson(json)).toList();
        forecastData =
            forecastList.map((json) => ForecastData.fromJson(json)).toList();
      } catch (e) {
        print('Error decoding JSON: $e');
        weatherData = [];
        return 1;
      }
      print("forcast data has ${forecastData.length} items ");
      dataFetchedOnce = true;
      notifyListeners();
      return 0;
    } else {
      forecastData = [];
      return 1;
    }
  }

  // Future<int> fetchNewDataRemote() async {
  //   // get forecastData from the flask server and set it onto the getter variable
  //   final response = await http.get(Uri.parse(
  //       'http://10.3.15.93:5000/api/weather_n_forecast?city_name=${cityName.toLowerCase()}'));
  //   if (response.statusCode == 200) {
  //     if (response.body.toString() == "\"error\"") {
  //       print("Error in fetching data from python server.");
  //       return 1;
  //     }
  //     String jsonString = response.body.toString().replaceAll("NaN", "null");

  //     try {
  //       final Map<String, dynamic> jsonData = json.decode(jsonString);
  //       final List<dynamic> weatherList = jsonData['weather_data'];
  //       final List<dynamic> forecastList = jsonData['forecast_data'];
  //       weatherData =
  //           weatherList.map((json) => WeatherData.fromJson(json)).toList();
  //       forecastData =
  //           forecastList.map((json) => ForecastData.fromJson(json)).toList();
  //     } catch (e) {
  //       print('Error decoding JSON: $e');
  //       weatherData = [];
  //       return 1;
  //     }
  //     print("forcast data has ${forecastData.length} items ");
  //     notifyListeners();
  //     return 0;
  //   } else {
  //     forecastData = [];
  //     return 1;
  //   }
  // }

  Future<int> fetchBothDataJsonBin() async {
    // get forecastData from jsonbin.io and set it onto the getter variable
    const binId = '6537c76012a5d376598fe229'; // Replace with the actual bin ID
    const apiUrl = 'https://api.jsonbin.io/v3/b/$binId';
    const masterKey =
        "\$2a\$10\$7DtsQl0ZlTmcxAKKDWqrqeuPYpSvtjNRgKRU4z9H7dOCCshhd/kI6";

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'X-Master-Key': masterKey, // Replace with your JSONbin.io API key
      });
      if (response.statusCode == 200) {
        if (response.body.toString() == "\"error\"") {
          print("Error in fetching data from python server.");
          return 1;
        }
        String jsonString = response.body.toString().replaceAll("NaN", "null");
        print(jsonString);

        try {
          final Map<String, dynamic> jsonData = json.decode(jsonString);
          final List<dynamic> weatherList = jsonData['record']['weather_data'];
          final List<dynamic> forecastList =
              jsonData['record']['forecast_data'];
          weatherData =
              weatherList.map((json) => WeatherData.fromJson(json)).toList();
          forecastData =
              forecastList.map((json) => ForecastData.fromJson(json)).toList();
        } catch (e) {
          print('Error decoding JSON: $e');
          weatherData = [];
          return 1;
        }
        print("forcast data has ${forecastData.length} items ");
        print(" xxxxxxxxx =  ${weatherData[0].dateTime}");
        print(forecastData.length);
        notifyListeners();
        return 0;
      } else {
        forecastData = [];
        return 1;
      }
    } catch (e) {
      print(e);
      return 1;
    }
  }

  Future<void> saveCitynameLocally(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('LocalCityName', cityName);
  }

  Future<int> getnsetLocalCityname() async {
    final prefs = await SharedPreferences.getInstance();
    final String cityname = prefs.getString('LocalCityName') ?? "";
    if (cityname != "") {
      setCityName(cityname);
      return 0;
    } else {
      return 1;
    }
  }

  // Future<void> saveJsonLocally(String jsonString) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('LocalJsonData', jsonString);
  // }

  // Future<int> fetchDataLocally() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String jsonString = prefs.getString('LocalJsonData') ?? "";
  //   if (jsonString == "") {
  //     print("No Local Data found");
  //     return 1;
  //   }
  //   try {
  //     final Map<String, dynamic> jsonData = json.decode(jsonString);
  //     final List<dynamic> weatherList = jsonData['weather_data'];
  //     final List<dynamic> forecastList = jsonData['forecast_data'];
  //     weatherData =
  //         weatherList.map((json) => WeatherData.fromJson(json)).toList();
  //     forecastData =
  //         forecastList.map((json) => ForecastData.fromJson(json)).toList();
  //   } catch (e) {
  //     print('Error decoding JSON: $e');
  //     weatherData = [];
  //     return 1;
  //   }
  //   print("forcast data has ${forecastData.length} items ");
  //   notifyListeners();
  //   return 0;
  // }
}
