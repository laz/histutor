
import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';


class makeRoom extends StatelessWidget {
  const makeRoom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.orange),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('makeRoom')
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
