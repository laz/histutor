import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:histutor/screens/MyPageWidgets/user/list/Chatting.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/model/User.dart';
import 'package:histutor/state/Database.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../controller/SessionController.dart';
import '../../../../model/Participant.dart';
import '../../../../state/Database.dart';

class Sessions extends StatelessWidget {
  const Sessions({Key key, @required this.idx, @required this.sessions}) : super(key: key);
  final int idx;
  final List<Session> sessions;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 30),
          width: 80,
          child: Text(sessions[idx].sessionIndex.toString(),
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 30),
          width: 120,
          child: Text(sessions[idx].category,
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        Expanded(
          // padding: EdgeInsets.only(left: 50),
          child: Text(sessions[idx].sessionName,
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        Container(
          alignment: Alignment.center,
          width: 100,
          // padding: EdgeInsets.only(left: 50),
          child: Text(sessions[idx].tutorName,
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        Container(
          alignment: Alignment.center,
          width: 100,
          child: Column(
            children: [
              Text(DateFormat('yyyy-MM-dd').format(sessions[idx].sessionStart.toDate()).toString()),
              Text(
                DateFormat('HH:mm').format(sessions[idx].sessionStart.toDate()).toString() +
                    '-' +
                    DateFormat('HH:mm').format(sessions[idx].sessionEnd.toDate()).toString(),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () async {

                  if(sessions[idx].participants.contains(user.id)) {
                    // if tutoring
                    if(sessions[idx].actualStudentBeingTutored == user.id) {
                      // do nothing
                    }
                    else {
                      SessionController().updateEntranceTime(user, sessions[idx].sessionIndex.toString());
                    }
                  }
                  else {

                    if(user.id != sessions[idx].tutorId) {
                      // 넣기
                      SessionController().addParticipant(user, sessions[idx].sessionIndex.toString());
                      SessionController().addSessionParticipant(user, sessions[idx].sessionIndex.toString());
                    }
                  }

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return MultiProvider(
                      providers: [
                        StreamProvider<List<Chat>>.value(value: Database().getSessionChats(sessions[idx].sessionIndex)),
                        StreamProvider<Session>.value(value: Database().getSession(sessions[idx].sessionIndex)),
                        StreamProvider<List<Participant>>.value(value: Database().getSessionParticipants(sessions[idx].sessionIndex)),
                      ],
                      child: Chatting(sessionIndex: sessions[idx].sessionIndex),
                    );
                  }));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff9BC7DA)),
                ),
                child: Text("입  장",
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
            )),
      ],
    );
  }
}
