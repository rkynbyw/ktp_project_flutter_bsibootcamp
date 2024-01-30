import 'package:hive/hive.dart';
part 'penduduk.g.dart';

@HiveType(typeId: 0)

class Penduduk extends HiveObject{
  @HiveField(0)
  final String nama;

  @HiveField(1)
  final String province;

  @HiveField(2)
  final String city;

  @HiveField(3)
  final String pendidikan;

  @HiveField(4)
  final String pekerjaan;

  Penduduk({
    required this.nama,
    required this.province,
    required this.city,
    required this.pendidikan,
    required this.pekerjaan,
  });
}