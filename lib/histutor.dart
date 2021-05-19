
import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';


class histutor extends StatelessWidget {
  const histutor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('hitutor')
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
    );
  }
}
