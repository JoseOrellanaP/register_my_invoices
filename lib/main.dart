import 'package:flutter/material.dart';
import 'package:register_my_invoices/scream/list_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: list_data(),
    );
  }
}

