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
      color: Colors.white,
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
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 30),
              width: 80,
              child: Text("NO.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 30),
              width: 120,
              child: Text("상태",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Expanded(
              // width: 300,
              child: Text("방 이름",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Container(
              alignment: Alignment.center,
              width: 100,
              child: Text("작성자",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Container(
              alignment: Alignment.center,
              width: 100,
              child: Text("세션 시간",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Container(
                width: 100,
                // child: ElevatedButton(
                //   child: Text('입장'),
                // ),
              ),
            )
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
