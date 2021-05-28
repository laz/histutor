import 'package:flutter/material.dart';
import 'screens/page.dart';



class HISTUTOR extends StatefulWidget {
  const HISTUTOR({Key key}) : super(key: key);

  @override
  _HISTUTORState createState() => _HISTUTORState();
}

class _HISTUTORState extends State<HISTUTOR> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        backgroundColor: Color(0xff9BC7DA),
        primaryColor: Color(0xff9BC7DA),
      ),
    );
  }
}
