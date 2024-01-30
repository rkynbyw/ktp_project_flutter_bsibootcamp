import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import 'package:project_form_ktp/main.dart';
// import 'package:project_form_ktp/presentation/widget/dropdown_location_widget.dart';
// import 'package:project_form_ktp/presentation/widget/dropdown_widget_new.dart';
import 'package:project_form_ktp/datasource/location_datasource.dart';
import 'package:project_form_ktp/entities/location_entity.dart';
import 'package:project_form_ktp/hive_service.dart';



class FormPage extends StatefulWidget {
  // const FormPage({Key? key, required this.isEditMode, required this.dataToEdit, required this.indexToEdit}) : super(key: key);
  // bool isEditMode = false;
  // Map<String, dynamic>? dataToEdit;
  // int? indexToEdit;

  final bool isEditMode;
  final Map<String, dynamic>? dataToEdit;
  final int? indexToEdit;

  FormPage({
    Key? key,
    this.isEditMode = false,
    this.dataToEdit,
    this.indexToEdit,
  }) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();

  static _FormPageState? of(BuildContext context) {
    return context.findAncestorStateOfType<_FormPageState>();
  }

  // @override
  // _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage>{

  late List<Province> provinces;
  late List<City> city;

  Province? selectedProvince;
  City? selectedCity;

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



  final _formKey = GlobalKey<FormState>();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _pendidikanController = TextEditingController();
  TextEditingController _pekerjaanController = TextEditingController();
  TextEditingController _provinceController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  // Province? selectedProvince;
  // City? selectedCity;

  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     final penduduk = {
  //       'nama': _namaController.text,
  //       'province': selectedProvince,
  //       'city': selectedCity,
  //       'pendidikan': _pendidikanController,
  //       'pekerjaan': _pekerjaanController,
  //     };
  //     final pendudukBox = Hive.box('penduduk_box');
  //     pendudukBox.add(penduduk);
  //   }
  // }

  void _submitForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        if (selectedProvince != null && selectedCity != null) {
          final penduduk = {
            'nama': _namaController.text,
            'province': selectedProvince!.name,
            'city': selectedCity!.name,
            'pendidikan': _pendidikanController.text,
            'pekerjaan': _pekerjaanController.text,
          };

          final pendudukBox = Hive.box('penduduk_box');
          await pendudukBox.add(penduduk);
          // await HiveService.addPenduduk(penduduk);

          print('Nama : ${_namaController.text}');
          print('Pendidikan : ${_pendidikanController.text}');
          print('Pekerjaan : ${_pekerjaanController.text}');
          print('City : ${selectedCity!.name}');
          print('Province : ${selectedProvince!.name}');
        } else {
          print('Error in _submitForm: selectedProvince or selectedCity is null');
        }
      }
    } catch (e, stackTrace) {
      print('Error in _submitForm: $e');
      print(stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Form Penduduk Page'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextField(
                      controller: _namaController,
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        hintText: 'Masukkan Nama Anda',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    // DropdownWidget(),
                    TextField(
                      controller: _pendidikanController,
                      decoration: InputDecoration(
                        labelText: 'Pendidikan',
                        hintText: 'Masukkan Pendidikan Anda',
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _pekerjaanController,
                      decoration: InputDecoration(
                        labelText: 'Pekerjaan',
                        hintText: 'Masukkan Pekerjaan Anda',
                        prefixIcon: Icon(Icons.laptop),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),

                    // DropDown
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
                    ElevatedButton(
                        onPressed: (){
                          _submitForm();
                          context.go('/list');
                        },
                        child: Text('Add Data')
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: (){
                          context.go('/list');
                        },
                        child: Text('View List')
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        )

    );
  }
}