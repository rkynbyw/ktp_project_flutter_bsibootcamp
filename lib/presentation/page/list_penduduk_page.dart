import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_form_ktp/presentation/page/form_penduduk_page.dart';
import 'package:project_form_ktp/datasource/penduduk.dart';
import 'package:project_form_ktp/hive_service.dart';

class ListPendudukPage extends StatefulWidget {
  const ListPendudukPage({super.key});

  @override
  State<ListPendudukPage> createState() => _ListPendudukPageState();
}

class _ListPendudukPageState extends State<ListPendudukPage> {

  late final Box pendudukBox;
  // late final Box pendudukBox = HiveService.getPendudukList();

  @override
  void initState() {
    super.initState();
    pendudukBox = Hive.box('penduduk_box');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Penduduk Page'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                context.go('/form');
              },
              icon: const Icon(Icons.add),
            ),
          ),

        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: pendudukBox.listenable(),
          builder: (context, value, child){
            if (value.isEmpty){
              return const Center(
                child: Text('Database is Empty'),
              );
            } else {
              return ListView.builder(
                  itemCount: pendudukBox.length,
                  itemBuilder: (context, index){
                    var box = value;
                    var getData = box.getAt(index);

                    // final getData = box.getAt(index) as Map<String, dynamic>;
                    // Map<String, dynamic>.from(getData as Map);

                    return ListTile(
                      leading: IconButton(
                        onPressed: (){
                          _editPenduduk(index);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      title: Text(getData['nama']),
                      subtitle: Text(getData['pekerjaan']),
                      trailing: IconButton(
                        onPressed: (){
                          _deletePenduduk(index);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  }
              );
            }
          }
      )
    );
  }

  Future<void> _deletePenduduk(int index) async {
    try {
      await HiveService.deletePenduduk(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data berhasil dihapus'),
        ),
      );
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  Future<void> _editPenduduk(int index) async {
    var box = Hive.box('penduduk_box');
    var getData = box.getAt(index) as Map<String, dynamic>;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPage(
          isEditMode: true,
          dataToEdit: getData,
          indexToEdit: index,
        ),
      ),
    );
  }

}
