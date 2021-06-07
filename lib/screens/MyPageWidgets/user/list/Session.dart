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

class Sessions extends StatelessWidget {
  const Sessions({Key key, @required this.idx, @required this.sessions})
      : super(key: key);
  final int idx;
  final List<Session> sessions;

  @override
  Widget build(BuildContext context) {
    User auth = Provider.of<User>(context);

    var outputFormat_s = DateFormat('yyyy-MM-dd');
    var outputDate_s =
        outputFormat_s.format(sessions[idx].sessionStart.toDate());

    var dateToTimeStamp_s = DateTime.fromMillisecondsSinceEpoch(
        sessions[idx].sessionStart.millisecondsSinceEpoch * 1000);
    var output_hh_mm_s = DateFormat('HH:mm').format(dateToTimeStamp_s);

    var outputFormat_e = DateFormat('yyyy-MM-dd');
    var outputDate_e = outputFormat_e.format(sessions[idx].sessionEnd.toDate());

    var dateToTimeStamp_e = DateTime.fromMillisecondsSinceEpoch(
        sessions[idx].sessionEnd.millisecondsSinceEpoch * 1000);
    var output_hh_mm_e = DateFormat('HH:mm').format(dateToTimeStamp_e);

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
              Text(DateFormat('yyyy-MM-dd')
                  .format(sessions[idx].sessionStart.toDate())
                  .toString()),
              Text(
                DateFormat('HH:mm')
                        .format(sessions[idx].sessionStart.toDate())
                        .toString() +
                    '-' +
                    DateFormat('HH:mm')
                        .format(sessions[idx].sessionEnd.toDate())
                        .toString(),
                style: TextStyle(color: Colors.grey),
              ),
              // Text(outputDate_s),
              // Text(output_hh_mm_s + '-' + output_hh_mm_e, style: TextStyle(color: Colors.grey),)
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () async {
                  if (auth.Uid != sessions[idx].tutorUid)
                    SessionController().addParticipant(
                        auth, sessions[idx].sessionIndex.toString());

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return MultiProvider(
                      providers: [
                        StreamProvider<List<Chat>>.value(
                            value: Database()
                                .getSessionChats(sessions[idx].sessionIndex)),
                        StreamProvider<Session>.value(
                            value: Database()
                                .getSession(sessions[idx].sessionIndex)),
                        StreamProvider<List<Participant>>.value(
                            value: Database().getSessionParticipants(
                                sessions[idx].sessionIndex)),
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
