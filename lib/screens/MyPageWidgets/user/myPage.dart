import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:provider/provider.dart';
import 'myPageWidgets/nicknameChange.dart';
import 'myPageWidgets/topButtons.dart';
import 'package:histutor/screens/MyPageWidgets/user/myPageWidgets/listPage.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TopButton(),
              ),
            ),
            Consumer<ApplicationState>(
              builder: (context, applicationState, _) {
                return selectMyPage(applicationState.selectedMyPage, context);
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget selectMyPage(int selectedNum, BuildContext context) {
  switch (selectedNum) {
    case 0: // to session
      return Container(
        width: 1167,
        height: (MediaQuery.of(context).size.height - 180) * 0.9,
        alignment: Alignment.topLeft,
        color: Color(0xffFFFFFF),
        child: ListPage(),
      );
    case 1: // my page
      return Container(
        width: 1167,
        height: (MediaQuery.of(context).size.height - 180) * 0.9,
        alignment: Alignment.topLeft,
        color: Color(0xffFFFFFF),
        child: NicknameChangePage(),
      );
  }
}
