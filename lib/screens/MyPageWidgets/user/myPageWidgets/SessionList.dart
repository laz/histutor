import 'package:flutter/material.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/screens/MyPageWidgets/user/list/Session.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:provider/provider.dart';

class SessionListPage extends StatelessWidget {
  const SessionListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Session> sessions = Provider.of<List<Session>>(context);
    return Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: sessions != null
            ? Consumer<ApplicationState>(
                builder: (context, applicationState, _) {
                  return selectSessionPage(sessions);
                },
              )
            : CircularProgressIndicator());
  }
}

Widget selectSessionPage(List<Session> sessions) {
  return Column(
    children: [
      Container(
          child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Row(
        children: [
        Container(
        width: 100,
        child: Text("NO."),
        ),
        Container(
        width: 200,
        child: Text("상태"),
        ),
        Container(
        width: 300,
        child: Text("방 이름"),
        ),
        Container(
        width: 100,
        child: Text("작성자"),
        ),
        Container(
        width: 200,
        child: Text("세션 시간"),
        ),
        ],
        ),
      )),
      Divider(),
      Expanded(
          child: SizedBox(
        height: 485,
        child: ListView.separated(
            itemBuilder: (context, int index) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: sessions[index].category.compareTo("종료") == 1
                      ? Sessions(sessions: sessions, idx: index)
                      : null);
            },
            separatorBuilder: (context, int index) =>
                sessions[index].category.compareTo("종료") == 1
                    ? const Divider()
                    : Container(),
            itemCount: sessions.length),
      ))
    ],
  );
}
