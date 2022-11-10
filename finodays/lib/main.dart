import 'package:flutter/material.dart';
import 'package:finodays/pages.dart';


// import 'dart:convert';
// import 'dart:io';
// final inputFile = File('lib/data.txt');
// Stream<String> lines = inputFile
//     .openRead()
//     .transform(utf8.decoder)
//     .transform(const LineSplitter());


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Off Pay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
