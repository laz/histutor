
import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'screens/page.dart';

class histutor extends StatelessWidget {
  const histutor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        backgroundColor: Color(0xff9BC7DA),
        primaryColor: Color(0xff9BC7DA),
      ),
    );/*
      home: Scaffold(
        appBar: AppBar(
            title: Text('histutor')
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('body')
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.wb_sunny),
          onPressed: () {
            ApplicationState applicationState = ApplicationState();
            applicationState.addParticipant();
          },
        ),
      ),
    */
  }
}
