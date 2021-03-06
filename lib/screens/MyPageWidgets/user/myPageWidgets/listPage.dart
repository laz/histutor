import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:histutor/screens/MyPageWidgets/user/list/tuteeSessionList.dart';
import 'package:histutor/screens/MyPageWidgets/user/list/tutorSessionList.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/model/User.dart';
import 'package:histutor/model/Subsession.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Subsession> sessions = Provider.of<List<Subsession>>(context);
    User user = Provider.of<User>(context);

    return Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: (sessions != null)
            ? Consumer<ApplicationState>(
                builder: (context, applicationState, _) {
                  return myPageSessionList(applicationState.selectedAdminPage,
                      context, sessions, user);
                },
              )
            : CircularProgressIndicator());
  }
}

Widget myPageSessionList(int selectedNum, BuildContext context,
    List<Subsession> sessions, User user) {
  if (user.type == "tutor") {
    return (sessions != null)
        ? (sessions.isEmpty)
            ? (Text("생성한 세션이 없습니다"))
            : ListView.separated(
                itemBuilder: (_, int index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TutorSessionList(
                      idx: index,
                      sessionList: sessions,
                    ),
                  );
                },
                separatorBuilder: (_, int index) => const Divider(),
                itemCount: sessions.length + 1,
              )
        : Align(child: CircularProgressIndicator());
  } else {
    return (sessions != null)
        ? (sessions.isEmpty)
            ? (Text("참여한 세션이 없습니다"))
            : ListView.separated(
                itemBuilder: (_, int index) {
                  print(sessions[0].sessionName);
                  return Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TuteeSessionList(idx: index, sessionList: sessions),
                  );
                },
                separatorBuilder: (_, int index) => const Divider(),
                itemCount: sessions.length + 1,
              )
        : Align(child: CircularProgressIndicator());
  }
}
