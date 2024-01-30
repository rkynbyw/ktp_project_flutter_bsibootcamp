import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static late Box pendudukBox;

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PendudukAdapter());
    pendudukBox = await Hive.openBox('penduduk_box');
  }

  static Future<void> addPenduduk(Map<String, dynamic> pendudukData) async {
    await pendudukBox.add(pendudukData);
  }

  // static Future<void> editPenduduk(int index, Map<String, dynamic> updatedData) async {
  //   await pendudukBox.putAt(index, updatedData);
  // }

  static Future<void> editPenduduk(int index, Map<String, dynamic> newData) async {
    final pendudukBox = await Hive.openBox('penduduk_box');
    await pendudukBox.putAt(index, newData);
  }

  static List<Map<String, dynamic>> getPendudukList() {
    return pendudukBox.values.toList().cast<Map<String, dynamic>>();
  }

  static Future<void> deletePenduduk(int index) async {
    final pendudukBox = await Hive.openBox('penduduk_box');
    await pendudukBox.deleteAt(index);
  }
}

class PendudukAdapter extends TypeAdapter<Penduduk> {
  @override
  final int typeId = 0;

  @override
  Penduduk read(BinaryReader reader) {
    return Penduduk()
      ..nama = reader.read()
      ..province = reader.read()
      ..city = reader.read()
      ..pendidikan = reader.read()
      ..pekerjaan = reader.read();
  }

  @override
  void write(BinaryWriter writer, Penduduk obj) {
    writer
      ..write(obj.nama)
      ..write(obj.province)
      ..write(obj.city)
      ..write(obj.pendidikan)
      ..write(obj.pekerjaan);
  }
}

class Penduduk {
  String nama = '';
  String province = '';
  String city = '';
  String pendidikan = '';
  String pekerjaan = '';
}
