// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/foundation.dart';

import 'package:weather_app/src/model/current_weather_data.dart';
import 'package:weather_app/src/model/five_days_data.dart';
import 'package:weather_app/src/service/weather_service.dart';

class HomeController extends GetxController {
  String city;
  String searchText;

  CurrentWeatherData currentWeatherData = CurrentWeatherData();
  List<CurrentWeatherData> dataList = [];
  List<FiveDayData> fiveDaysData = [];

  HomeController({
    required this.city,
    required this.searchText,
    required this.dataList,
    required this.fiveDaysData,
  });

  @override
  void onInit() {
    initState();
    getTopFiveCities();
    super.onInit();
  }

  void updateWeather() {
    initState();
  }

  void initState() {
    getCurrentWeatherData();
    getFiveDaysData();
  }

  void getCurrentWeatherData() {
    WeatherService(city: '$city').getCurrentWeatherData(
        onSuccess: (data) {
          currentWeatherData = data;
          update();
        },
        onError: (error) => {
              print(error),
              update(),
            });
  }

  void getTopFiveCities() {
    List<String> cities = ['London', 'New York', 'Paris', 'Moscow', 'Tokyo'];
    cities.forEach((c) {
      WeatherService(city: '$c').getCurrentWeatherData(onSuccess: (data) {
        dataList.add(data);
        update();
      }, onError: (error) {
        print(error);
        update();
      });
    });
  }

  void getFiveDaysData() {
    WeatherService(city: '$city').getFiveDaysThreeHoursForcastData(
        onSuccess: (data) {
      fiveDaysData = data;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  HomeController copyWith({
    String? city,
    String? searchText,
    List<CurrentWeatherData>? dataList,
    List<FiveDayData>? fiveDaysData,
  }) {
    return HomeController(
      city: city ?? this.city,
      searchText: searchText ?? this.searchText,
      dataList: dataList ?? this.dataList,
      fiveDaysData: fiveDaysData ?? this.fiveDaysData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city,
      'searchText': searchText,
      'dataList': dataList.map((x) => x.toMap()).toList(),
      'fiveDaysData': fiveDaysData.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeController.fromMap(Map<String, dynamic> map) {
    return HomeController(
      city: map['city'] as String,
      searchText: map['searchText'] as String,
      dataList: List<CurrentWeatherData>.from(
        (map['dataList'] as List<int>).map<CurrentWeatherData>(
          (x) => CurrentWeatherData.fromJson(x as Map<String, dynamic>),
        ),
      ),
      fiveDaysData: List<FiveDayData>.from(
        (map['fiveDaysData'] as List<int>).map<FiveDayData>(
          (x) => FiveDayData.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeController.fromJson(String source) =>
      HomeController.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomeController(city: $city, searchText: $searchText, dataList: $dataList, fiveDaysData: $fiveDaysData)';
  }

  @override
  bool operator ==(covariant HomeController other) {
    if (identical(this, other)) return true;

    return other.city == city &&
        other.searchText == searchText &&
        listEquals(other.dataList, dataList) &&
        listEquals(other.fiveDaysData, fiveDaysData);
  }

  @override
  int get hashCode {
    return city.hashCode ^
        searchText.hashCode ^
        dataList.hashCode ^
        fiveDaysData.hashCode;
  }
}
