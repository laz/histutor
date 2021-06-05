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
      //alignment: Alignment.topRight,
      width: 400,
      //height: 30,
      //color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: applicationState.selectedPage == 1
                    ? MaterialStateProperty.all<Color>(Color(0xF07CBDF6))
                    : MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                applicationState.changeSelectedPage(1);
              },
              child: Container(
                color: Colors.white,
                  width: 85.0,
                  child :Text("세션 목록",
                textAlign: TextAlign.center,
                style:TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color : Colors.black38,
                ))),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: applicationState.selectedPage == 0
                    ? MaterialStateProperty.all<Color>(Color(0xF07CBDF6))
                    : MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                applicationState.changeSelectedPage(0);
              },
              child: Container(
                color: Colors.white,
                  width:90.0,
                  child :Text("마이페이지",
                  textAlign: TextAlign.center,
                  style:TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color : Colors.black38,
                  ))),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Container(
                color: Colors.white,
                  width: 80.0,
                  child: Text("로그아웃",
                  textAlign: TextAlign.center,
                  style:TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color : Colors.black38,
                  ))),
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
