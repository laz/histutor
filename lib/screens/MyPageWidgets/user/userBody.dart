import 'package:flutter/material.dart';

import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/state/Authentication.dart';
import 'package:provider/provider.dart';

import 'myPage.dart';
import 'sessionPage.dart';

class UserBody extends StatefulWidget {
  @override
  _UserBodyState createState() => _UserBodyState();
}

class _UserBodyState extends State<UserBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
        builder: (context, applicationState, _){
          return selectBody(applicationState.selectedPage);
        },
      );/*Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(125, 0, 145, 0),
        child:  Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
              child : TopButton(),
            ),

          ],
        ),
      ),
    );*/
  }
}
Widget selectBody(int selectedNum) {
  switch (selectedNum) {
    case 0: // to session
      return MyPage();
      break;
    case 1: // my page
      return SessionPage();
      break;
  }
}
/*
Widget selectBody(int selectedNum){
  switch(selectedNum){
    case 0: // to session
      return Container(
        width: 1167,
        height: 534,
        alignment: Alignment.topLeft,
        color: Color(0xffFFFFFF),
        child: nicknameChangePage(),
      );
    case 1: // my page
      return Container(
        width: 1167,
        height: 534,
        alignment: Alignment.topLeft,
        color: Color(0xffFFFFFF),
        child: nicknameChangePage(),
      );
    case 2: // log out
      return Container(
        width: 1167,
        height: 534,
        alignment: Alignment.topLeft,
        color: Color(0xffFFFFFF),
        child: nicknameChangePage(),
      );
  }
}
*/