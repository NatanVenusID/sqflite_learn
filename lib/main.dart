import 'package:flutter/material.dart';
import 'package:sqlite_app/model/list_pegawai.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListPegawai(),
    );
  }
}