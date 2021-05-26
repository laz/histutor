import 'package:flutter/material.dart';
import 'screens/page.dart';



class histutor extends StatefulWidget {
  const histutor({Key key}) : super(key: key);

  @override
  _histutorState createState() => _histutorState();
}

class _histutorState extends State<histutor> {
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
