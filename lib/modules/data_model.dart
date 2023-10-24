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
      cloudsAll: json['clouds_all'] ?? 0,
      cloudsUnit: json['clouds_unit'] ?? '',
      cloudsValue: json['clouds_value'] ?? '',
      feelsLikeUnit: json['feels_like_unit'] ?? '',
      feelsLikeValue: (json['feels_like_value'] as double?) ?? 0.0,
      from: json['from_'] ?? '',
      humidityUnit: json['humidity_unit'] ?? '',
      humidityValue: json['humidity_value'] ?? 0,
      precipitationProbability:
          (json['precipitation_probability'] as double?) ?? 0.0,
      precipitationType: json['precipitation_type'] ?? '',
      precipitationUnit: json['precipitation_unit'] ?? '',
      precipitationValue: (json['precipitation_value'] as double?) ?? 0.0,
      pressureUnit: json['pressure_unit'] ?? '',
      pressureValue: json['pressure_value'] ?? 0,
      symbolName: json['symbol_name'] ?? '',
      symbolNumber: json['symbol_number'] ?? 0,
      symbolVar: json['symbol_var'] ?? '',
      tempMax: (json['temperature_max'] as double?) ?? 0.0,
      tempMin: (json['temperature_min'] as double?) ?? 0.0,
      tempUnit: json['temperature_unit'] ?? '',
      tempValue: (json['temperature_value'] as double?) ?? 0.0,
      to: json['to_'] ?? '',
      visibilityValue: json['visibility_value'] ?? 0,
      windDirectionCode: json['windDirection_code'] ?? '',
      windDirectionDeg: json['windDirection_deg'] ?? 0,
      windDirectionName: json['windDirection_name'] ?? '',
      windGustGust: (json['windGust_gust'] as double?) ?? 0.0,
      windGustUnit: json['windGust_unit'] ?? '',
      windSpeedMps: (json['windSpeed_mps'] as double?) ?? 0.0,
      windSpeedName: json['windSpeed_name'] ?? '',
      windSpeedUnit: json['windSpeed_unit'] ?? '',
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

  Future<int> fetchBothData() async {
    try {
      await fetchWeatherData();
      await fetchForecastData();
      dataFetchedOnce = true;
      return 0;
    } catch (e) {
      print('Error : ${e}');
      return 1;
    }
  }
}
