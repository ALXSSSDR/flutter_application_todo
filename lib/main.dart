import 'package:flutter/material.dart';
import './screens/CategoriesPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 101, 221, 205),
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1)),
        ),
      ),
      home: const CategoriesPage(title: 'ToDo'),
    );
  }
}