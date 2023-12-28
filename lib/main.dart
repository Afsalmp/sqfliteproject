
import 'package:flutter/material.dart';
import 'package:sqfliteproject/db_helper.dart';

import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initilizeDatabse();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: pageone(),
      debugShowCheckedModeBanner: false,
    );
  }
}
