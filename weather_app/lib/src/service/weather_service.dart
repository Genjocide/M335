import 'package:flutter/material.dart';
import 'package:weather_app/src/api/api_repository.dart';
import 'package:weather_app/src/model/current_weather_data.dart';
import 'package:weather_app/src/model/five_days_data.dart';

class WeatherService {
  final String? city;

  String baseUrl = 'https://api.openweathermap.org/data/2.5/weather?';
  String apiKey = 'appid=da744b08724f1a7328aeada146826797';

  WeatherService({@required this.city});

  void getCurrentWeatherData({
    Function()? beforSend,
    Function(CurrentWeatherData currentWeatherData)? onSuccess,
    required Function(dynamic error) onError,
  }) {
    final url = '$baseUrl/weather?q=$city&lang=en&$apiKey';
    //print(url);
    ApiRepository(url: '$url', payload: null).get(
        beforeSend: () => {
              if (beforSend != null)
                {
                  beforSend(),
                },
            },
        onSuccess: (data) => {
              onSuccess!(CurrentWeatherData.fromJson(data)),
            },
        onError: (error) => {
              if (onError != null)
                {
                  print(error),
                  onError(error),
                }
            });
  }

  void getFiveDaysThreeHoursForcastData({
    Function()? beforSend,
    Function(List<FiveDayData> fiveDayData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = '$baseUrl/forecast?q=$city&lang=en&$apiKey';
    print(url);
    ApiRepository(url: '$url', payload: null).get(
        beforeSend: () => {},
        onSuccess: (data) => {
              onSuccess!((data['list'] as List)
                      .map((t) => FiveDayData.fromJson(t))
                      .toList()),
            },
        onError: (error) => {
              print(error),
              onError!(error),
            });
  }
}
