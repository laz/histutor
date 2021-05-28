import 'package:flutter/material.dart';

import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/state/Authentication.dart';
import 'package:provider/provider.dart';

import 'myPageWidgets/nicknameChange.dart';
import 'myPageWidgets/topButtons.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(125, 0, 145, 0),
        child:  Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
              child : TopButton(),
            ),
            Consumer<ApplicationState>(
              builder: (context, applicationState, _){
                return selectMyPage(applicationState.selectedMyPage);
              },
            )

          ],
        ),
      ),
    );
  }
}
Widget selectMyPage(int selectedNum) {
  switch (selectedNum) {
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
  }
}
