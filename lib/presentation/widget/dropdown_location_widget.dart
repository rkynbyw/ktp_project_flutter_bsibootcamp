import 'package:flutter/material.dart';
import 'package:project_form_ktp/datasource/location_datasource.dart';
import 'package:project_form_ktp/entities/location_entity.dart';

class DropdownWidget extends StatefulWidget {
  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late List<Province> provinces;
  late List<City> city;

  Province? selectedProvince;
  City? selectedCity;

  TextEditingController _provinceController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    provinces = [];
    city = [];

    loadProvinces().then((value) {
      // print('Loaded Provinces: $value'); //Notesss
      setState(() {
        provinces = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('Build: Provinces: $provinces, Districts: $districts');
    return Column(
      children: [
        DropdownButtonFormField<Province>(
          value: selectedProvince,
          items: provinces.map((province) {
            return DropdownMenuItem<Province>(
              value: province,
              child: Text(province.name),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedProvince = value;
              selectedCity = null;
              loadCity(value!.id).then((value) {
                setState(() {
                  city = value;
                });
              });
            });
            _provinceController.text = value!.name;
          },

          decoration: InputDecoration(
            labelText: 'Select Province',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_city)
          ),
        ),
        SizedBox(height: 20),
        // SizedBox(height: 20),
        DropdownButtonFormField<City>(
          value: selectedCity,
          items: city.map((city) {
            return DropdownMenuItem<City>(
              value: city,
              child: Text(city.name),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCity = value;
            });
            _cityController.text = value!.name;
          },
          decoration: InputDecoration(
            labelText: 'Select City',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on)
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

