// province_model.dart
class Province {
  final String id;
  final String name;

  Province({required this.id, required this.name});
}

// City_model.dart
class City {
  final String id;
  final String provinceId;
  final String name;

  City({required this.id, required this.provinceId, required this.name});
}
