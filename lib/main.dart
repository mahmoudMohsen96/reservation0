import 'package:flutter/material.dart';
import 'package:reservation/screens/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Reservation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Lalezar',
      ),
      home: Directionality(
        child: Home(),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
