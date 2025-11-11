import 'dart:io' show Platform; 

import 'package:flutter/material.dart';
import 'Screens/UserFormPage.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  runApp(const MainApp());
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS){
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserFormPage()
    );
  }
}
