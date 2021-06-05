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
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: SessionButton(),
                ),
              ),
              Consumer<ApplicationState>(
                builder: (context, applicationState, _) {
                  return selectMyPage(context);
                },
              )
            ],
          ),
        ),
      );
    // );
  }
}

Widget selectMyPage(BuildContext context) {
  // to session
  return Container(
    width: 1167,
    height: (MediaQuery.of(context).size.height-180)*0.9,
    // alignment: Alignment.center,
    color: Color(0xff7cee5a),
    child: SessionListPage(), //Session list 넣기
  );
}
