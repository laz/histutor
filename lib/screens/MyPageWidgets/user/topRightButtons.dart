import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/state/Authentication.dart';
import 'package:provider/provider.dart';

class TopRightButton extends StatefulWidget {
  @override
  _TopButtonRightState createState() => _TopButtonRightState();
}

class _TopButtonRightState extends State<TopRightButton> {
  @override
  Widget build(BuildContext context) {
    final applicationState = Provider.of<ApplicationState>(context);
    return Container(
      alignment: Alignment.topRight,
      width: 240,
      //height: 100,
      color: Colors.grey,
      child: Row(
        children: [
          Padding(
            padding:EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextButton(
              onPressed: (){
                applicationState.changeSelectedPage(1);
              },
              child: Text(
                  "To Session"
              ),
            ),
          ),
          Padding(
              padding:EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextButton(
                onPressed: (){
                  applicationState.changeSelectedPage(0);
                },
                child: Text(
                    "My Page"
                ),
              ),
          ),
          Padding(
            padding:EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextButton(
              child: Text(
                  "Logout"
              ),
            ),
          ),

        ],
      ),
    );
  }
}
