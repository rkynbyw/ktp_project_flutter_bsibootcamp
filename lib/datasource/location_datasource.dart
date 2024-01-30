import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:project_form_ktp/entities/location_entity.dart';

Future<List<Province>> loadProvinces() async {
  final String data = await rootBundle.loadString('assets/provinces.json');
  final List<dynamic> jsonList = json.decode(data);
  return jsonList.map((json) => Province(id: json['id'], name: json['name'])).toList();
}

Future<List<City>> loadCity(String provinceId) async {
  final String data = await rootBundle.loadString('assets/regencies.json');
  final List<dynamic> jsonList = json.decode(data);
  return jsonList
      .where((json) => json['province_id'] == provinceId)
      .map((json) => City(id: json['id'], provinceId: json['province_id'], name: json['name']))
      .toList();
}
