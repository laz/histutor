import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/state/Authentication.dart';
import 'package:provider/provider.dart';

class TopRightButton extends StatelessWidget {
  const TopRightButton({Key key}) : super(key: key);

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
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextButton(
              onPressed: () {
                applicationState.changeSelectedPage(1);
              },
              child: Text("To Session"),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextButton(
              onPressed: () {
                applicationState.changeSelectedPage(0);
              },
              child: Text("My Page"),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextButton(
              child: Text("Logout"),
              onPressed: () {
                Authentication().signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
