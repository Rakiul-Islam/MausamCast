import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_weather_app/modules/manage_location.dart';
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
      cityCoordLat: json['city_coord_lat']?.toDouble() ?? 0.0,
      cityCoordLon: json['city_coord_lon']?.toDouble() ?? 0.0,
      cityCountry: json['city_country'] ?? "",
      cityId: json['city_id'] ?? 0,
      cityName: json['city_name'] ?? "",
      citySunRise: json['city_sun_rise'] ?? "",
      citySunSet: json['city_sun_set'] ?? "",
      cityTimezone: json['city_timezone'] ?? 0,
      cloudsName: json['clouds_name'] ?? "",
      cloudsValue: json['clouds_value'] ?? 0,
      dateTime: json['date_time'] ?? "",
      feelsLikeUnit: json['feels_like_unit'] ?? "",
      feelsLikeValue: json['feels_like_value']?.toDouble() ?? 0.0,
      humidityUnit: json['humidity_unit'] ?? "",
      humidityValue: json['humidity_value'] ?? 0,
      precipitationMode: json['precipitation_mode'] ?? "",
      pressureUnit: json['pressure_unit'] ?? "",
      pressureValue: json['pressure_value'] ?? 0,
      temperatureMax: json['temperature_max']?.toDouble() ?? 0.0,
      temperatureMin: json['temperature_min']?.toDouble() ?? 0.0,
      temperatureUnit: json['temperature_unit'] ?? "",
      temperatureValue: json['temperature_value']?.toDouble() ?? 0.0,
      visibilityValue: json['visibility_value'] ?? 0,
      weatherIcon: json['weather_icon'] ?? "",
      weatherNumber: json['weather_number'] ?? 0,
      weatherValue: json['weather_value'] ?? "",
      windDirectionCode: json['wind_direction_code'] ?? "",
      windDirectionName: json['wind_direction_name'] ?? "",
      windDirectionValue: json['wind_direction_value']?.toDouble() ?? 0.0,
      windSpeedName: json['wind_speed_name'] ?? "",
      windSpeedUnit: json['wind_speed_unit'] ?? "",
      windSpeedValue: json['wind_speed_value']?.toDouble() ?? 0.0,
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
      cloudsAll: json['clouds_all'],
      cloudsUnit: json['clouds_unit'],
      cloudsValue: json['clouds_value'],
      feelsLikeUnit: json['feels_like_unit'],
      feelsLikeValue: json['feels_like_value'].toDouble(),
      from: json['from'],
      humidityUnit: json['humidity_unit'],
      humidityValue: json['humidity_value'],
      precipitationProbability: json['precipitation_probability'].toDouble(),
      precipitationType: json['precipitation_type'],
      precipitationUnit: json['precipitation_unit'],
      precipitationValue: json['precipitation_value'].toDouble(),
      pressureUnit: json['pressure_unit'],
      pressureValue: json['pressure_value'],
      symbolName: json['symbol_name'],
      symbolNumber: json['symbol_number'],
      symbolVar: json['symbol_var'],
      tempMax: json['temperature_max'].toDouble(),
      tempMin: json['temperature_min'].toDouble(),
      tempUnit: json['temperature_unit'],
      tempValue: json['temperature_value'].toDouble(),
      to: json['to'],
      visibilityValue: json['visibility_value'],
      windDirectionCode: json['windDirection_code'],
      windDirectionDeg: json['windDirection_deg'],
      windDirectionName: json['windDirection_name'],
      windGustGust: json['windGust_gust'].toDouble(),
      windGustUnit: json['windGust_unit'],
      windSpeedMps: json['windSpeed_mps'].toDouble(),
      windSpeedName: json['windSpeed_name'],
      windSpeedUnit: json['windSpeed_unit'],
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
      return 0;
    } else {
      return 1;
    }
  }

  Future<int> setCityName(String _cityname) async {
    if (_cityname.toLowerCase() != cityName) {
      dataFetchedOnce = false;
    }
    cityName = _cityname;
    notifyListeners();
    print("Notified");
    print("cityName changed to : $cityName");
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
      final List<dynamic> parsedJson = jsonDecode(response.body.toString());
      weatherData =
          parsedJson.map((json) => WeatherData.fromJson(json)).toList();
      dataFetchedOnce = true;
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
      final List<dynamic> parsedJson = jsonDecode(response.body.toString());
      forecastData =
          parsedJson.map((json) => ForecastData.fromJson(json)).toList();
      dataFetchedOnce = true;
      notifyListeners();
      return 0;
    } else {
      forecastData = [];
      return 1;
    }
  }
}
