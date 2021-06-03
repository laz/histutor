import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:provider/provider.dart';
import 'myPageWidgets/SessionButton.dart';
import 'myPageWidgets/SessionList.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(125, 0, 145, 0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
              child: SessionButton(),
            ),
            Consumer<ApplicationState>(
              builder: (context, applicationState, _) {
                return selectMyPage();
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget selectMyPage() {
  // to session
  return Container(
    width: 1167,
    height: 534,
    alignment: Alignment.topLeft,
    color: Color(0xffFFFFFF),
    child: SessionListPage(), //Session list 넣기
  );
}
