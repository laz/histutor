import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:provider/provider.dart';

class TopButton extends StatelessWidget {
  const TopButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationState applicationState = Provider.of<ApplicationState>(context);
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
          child: ElevatedButton(
              onPressed: () {
                applicationState.changeSelectedAdminPage(0);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
              ),
              child: Text(
                "튜터 현황",
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
          child: ElevatedButton(
              onPressed: () {
                applicationState.changeSelectedAdminPage(1);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
              ),
              child: Text(
                "튜티 현황",
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
          child: ElevatedButton(
            onPressed: () {
              applicationState.changeSelectedAdminPage(2);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
            ),
            child: Text(
              "튜터 목록",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
