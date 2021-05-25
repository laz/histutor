
import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';

import 'makeRoom.dart';



class mainboard extends StatelessWidget {
  const mainboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.orange),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('mainboard')
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
          child: Icon(Icons.add),
          onPressed: () =>

              Navigator.push(context,
            MaterialPageRoute(
              // fullscreenDialog: true,
              builder: (context) => new makeRoom(),
            ),
          )
        ),

        // FloatingActionButton(
        //   child: Icon(Icons.wb_sunny),
        //   onPressed: () {
        //     ApplicationState applicationState = ApplicationState();
        //     applicationState.addParticipant();
        //   },
        // ),
      ),
    );
  }
}

