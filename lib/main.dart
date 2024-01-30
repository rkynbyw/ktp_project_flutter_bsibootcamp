// package
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';

// page
import 'package:project_form_ktp/presentation/page/form_penduduk_page.dart';
import 'package:project_form_ktp/presentation/page/list_penduduk_page.dart';
import 'package:project_form_ktp/presentation/page/view_penduduk_page.dart';

// model
import 'package:project_form_ktp/dropdown_model.dart';
import 'package:project_form_ktp/datasource/penduduk.dart';

void main() async {
  // Hive Init
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PendudukAdapter());
  await Hive.openBox('penduduk_box');
  runApp(ChangeNotifierProvider(
      create: (context) => DropdownModel(),
      child : const MyApp()
  ));
}

final _router = GoRouter(
  initialLocation: '/form',
    routes: [
      GoRoute(
        name: 'form',
        path: '/form',
        builder: (context, state) => FormPage(),
      ),
      GoRoute(
        name: 'list',
        path: '/list',
        builder: (context, state) => ListPendudukPage(),
      ),


    ]
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KTP Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      routerConfig: _router,
      // home: FormPage(),
    );
  }
}



