import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project_form_ktp/dropdown_model.dart';
import 'package:project_form_ktp/datasource/location_datasource.dart';
import 'package:project_form_ktp/entities/location_entity.dart';


class DropdownWidget extends StatelessWidget {
  const DropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<DropdownModel>(
            builder: (context, dropdownModel, child){
              return DropdownButtonFormField<Province>(
                value: dropdownModel.selectedProvince,
                items: dropdownModel.provinces.map((province){
                  return DropdownMenuItem<Province>(
                    value: province,
                    child: Text(province.name),
                  );
                }).toList(),
                onChanged: (value){
                  dropdownModel.updateSelectedProvince(value!.id);
                  dropdownModel.updateSelectedCity('');
                },
                decoration: InputDecoration(
                    labelText: 'Select Province',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_city)
                ),
              );
            }
        ),
        SizedBox(height: 20),
        Consumer<DropdownModel>(
          builder: (context, dropdownModel, child) {
            return DropdownButtonFormField<City>(
              value: dropdownModel.selectedCity,
              items: dropdownModel.cities.map((city) {
                return DropdownMenuItem<City>(
                  value: city,
                  child: Text(city.name),
                );
              }).toList(),
              onChanged: (value) {
                dropdownModel.updateSelectedCity(value!.id);
              },
              decoration: InputDecoration(
                labelText: 'Select City',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
            );
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
