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
      height: 30,
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: applicationState.selectedPage == 1
                    ? MaterialStateProperty.all<Color>(Colors.pink)
                    : MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                applicationState.changeSelectedPage(1);
              },
              child: Text("세션 목록"),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: applicationState.selectedPage == 0
                    ? MaterialStateProperty.all<Color>(Colors.pink)
                    : MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                applicationState.changeSelectedPage(0);
              },
              child: Text("마이페이지"),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextButton(
              child: Text("로그아웃"),
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
