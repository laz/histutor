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
    //List<Session> sessions = Provider.of<List<Session>>(context);
    print('done');
    //그냥 provider가 지금 안되는구나,,
    return Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Consumer<ApplicationState>(
          builder: (context, applicationState, _){
            return selectSessionPage();
          },
        )
    );
  }
}
Widget selectSessionPage(){
      return ListView.separated(
          itemBuilder: ( _, int index){
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Sessions(idx: index),
            );
          },
          separatorBuilder: (_, int index) => const Divider(),
          itemCount: 11
      );
}
