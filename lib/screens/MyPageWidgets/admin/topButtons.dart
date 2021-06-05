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
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
          child: ElevatedButton(
              onPressed: () {
                applicationState.changeSelectedAdminPage(0);
              },
              style: ButtonStyle(
                backgroundColor: applicationState.selectedAdminPage == 0
                    ? MaterialStateProperty.all<Color>(Color(0xffe4c2c1))
                    : MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text(
                "튜터 목록",
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
          child: ElevatedButton(
              onPressed: () {
                applicationState.changeSelectedAdminPage(1);
              },
              style: ButtonStyle(
                backgroundColor: applicationState.selectedAdminPage == 1
                    ? MaterialStateProperty.all<Color>(Color(0xffe4c2c1))
                    : MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text(
                "튜티 현황",
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
          child: ElevatedButton(
            onPressed: () {
              applicationState.changeSelectedAdminPage(2);
            },
            style: ButtonStyle(
              backgroundColor: applicationState.selectedAdminPage == 2
                  ? MaterialStateProperty.all<Color>(Color(0xffe4c2c1))
                  : MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Text(
              "튜터 현황",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
          child: ElevatedButton(
            onPressed: () {
              applicationState.changeSelectedAdminPage(3);
            },
            style: ButtonStyle(
              backgroundColor: applicationState.selectedAdminPage == 3
                  ? MaterialStateProperty.all<Color>(Color(0xffe4c2c1))
                  : MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Text(
              "튜터 신청 목록",
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
