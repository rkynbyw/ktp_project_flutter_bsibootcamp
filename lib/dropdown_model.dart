import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_form_ktp/entities/location_entity.dart';

// class DropdownModel extends ChangeNotifier {
//   String _selectedProvince = '';
//   String _selectedCity = '';
//
//   String get selectedProvince => _selectedProvince;
//   String get selectedRegencie => _selectedCity;
//
//   void updateSelectedProvince(String newProvince) {
//     _selectedProvince = newProvince;
//     _selectedCity = '';
//     notifyListeners();
//   }
//
//   void updateSelectedCity(String newCity){
//     _selectedCity = newCity;
//     notifyListeners();
//   }
// }

class DropdownModel extends ChangeNotifier {
  List<Province> _provinces = [];
  List<City> _cities = [];
  Province? _selectedProvince;
  City? _selectedCity;

  List<Province> get provinces => _provinces;
  List<City> get cities => _cities;
  Province? get selectedProvince => _selectedProvince;
  City? get selectedCity => _selectedCity;

  void updateProvinces(List<Province> newProvinces) {
    _provinces = newProvinces;
    notifyListeners();
  }

  void updateCities(List<City> newCities) {
    _cities = newCities;
    notifyListeners();
  }

  void updateSelectedProvince(String newProvinceId) {
    _selectedProvince = _provinces.firstWhere((province) => province.id == newProvinceId, orElse: () => _provinces.first);
    notifyListeners();
  }

  void updateSelectedCity(String newCityId) {
    _selectedCity = _cities.firstWhere((city) => city.id == newCityId, orElse: () => _cities.first);
    notifyListeners();
  }
}

