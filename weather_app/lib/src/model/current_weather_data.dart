// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:weather_app/src/model/clouds.dart';
import 'package:weather_app/src/model/coord.dart';
import 'package:weather_app/src/model/main_weather.dart';
import 'package:weather_app/src/model/sys.dart';
import 'package:weather_app/src/model/weather.dart';
import 'package:weather_app/src/model/wind.dart';

class CurrentWeatherData {
  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final MainWeather? main;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  CurrentWeatherData(
      {this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  factory CurrentWeatherData.fromJson(dynamic json) {
    if (json == null) {
      return CurrentWeatherData();
    }

    return CurrentWeatherData(
      coord: Coord.fromJson(json['coord']),
      weather: (json['weather'] as List)
              .map((w) => Weather.fromJson(w))
              .toList(),
      base: json['base'],
      main: MainWeather.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }

  @override
  String toString() {
    return 'CurrentWeatherData(coord: $coord, weather: $weather, base: $base, main: $main, visibility: $visibility, wind: $wind, clouds: $clouds, dt: $dt, sys: $sys, timezone: $timezone, id: $id, name: $name, cod: $cod)';
  }

  @override
  bool operator ==(covariant CurrentWeatherData other) {
    if (identical(this, other)) return true;
  
    return 
      other.coord == coord &&
      listEquals(other.weather, weather) &&
      other.base == base &&
      other.main == main &&
      other.visibility == visibility &&
      other.wind == wind &&
      other.clouds == clouds &&
      other.dt == dt &&
      other.sys == sys &&
      other.timezone == timezone &&
      other.id == id &&
      other.name == name &&
      other.cod == cod;
  }

  @override
  int get hashCode {
    return coord.hashCode ^
      weather.hashCode ^
      base.hashCode ^
      main.hashCode ^
      visibility.hashCode ^
      wind.hashCode ^
      clouds.hashCode ^
      dt.hashCode ^
      sys.hashCode ^
      timezone.hashCode ^
      id.hashCode ^
      name.hashCode ^
      cod.hashCode;
  }

  toMap() {}
}
