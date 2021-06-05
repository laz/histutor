import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';
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
      builder: (context, applicationState, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
            child: selectBody(applicationState.selectedPage));
      },
    );
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
