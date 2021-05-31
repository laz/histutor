import 'package:flutter/material.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/screens/MyPageWidgets/admin/list/tutorList.dart';
import 'package:histutor/screens/MyPageWidgets/user/list/Session.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:provider/provider.dart';



class SessionListPage extends StatefulWidget {
  const SessionListPage({Key key}) : super(key: key);
  @override
  _SessionListPageState createState() => _SessionListPageState();
}

class _SessionListPageState extends State<SessionListPage> {
  @override
  Widget build(BuildContext context) {
    List<Session> sessions = Provider.of<List<Session>>(context);
    return Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Consumer<ApplicationState>(
          builder: (context, applicationState, _){
            return selectSessionPage(sessions);
          },
        )
    );
  }
}
Widget selectSessionPage(List<Session> sessions){
  print(sessions);
      return ListView.separated(
          itemBuilder: (context, int index){
            print(sessions[index].category.compareTo("종료")==1);
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child:
              sessions[index].category.compareTo("종료")==1?
             // sessions[index].category.compareTo("종료")==true?
              Sessions(sessions: sessions,idx: index)
                  : null
            );
          },
          separatorBuilder: (context, int index) => sessions[index].category.compareTo("종료")==1? const Divider(): Container(),
          itemCount: sessions.length
      );
}
