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
    var outputDate_s = outputFormat_s.format(sessions[idx].sessionStart.toDate());

    var dateToTimeStamp_s = DateTime.fromMillisecondsSinceEpoch(sessions[idx].sessionStart.millisecondsSinceEpoch * 1000);
    var output_hh_mm_s =  DateFormat('HH:mm').format(dateToTimeStamp_s);


    var outputFormat_e = DateFormat('yyyy-MM-dd');
    var outputDate_e = outputFormat_e.format(sessions[idx].sessionEnd.toDate());

    var dateToTimeStamp_e = DateTime.fromMillisecondsSinceEpoch(sessions[idx].sessionEnd.millisecondsSinceEpoch * 1000);
    var output_hh_mm_e =  DateFormat('HH:mm').format(dateToTimeStamp_e);

    return Row(
      children: [
        Container(
          width: 100,
          child: Text(idx.toString()),
        ),
        Container(
          width: 200,
          child: Text(sessions[idx].category),
        ),
        Container(
          width: 300,
          child: Text(sessions[idx].sessionName),
        ),
        Container(
          width: 100,
          child: Text(sessions[idx].tutorName),
        ),
        Container(
          width: 200,
          child: Text(outputDate_s+" "+output_hh_mm_s+" ~ "+output_hh_mm_e),
        ),
        Padding(
            padding: EdgeInsets.only(right: 100),
            child: Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () async {
                  if (auth.Uid != sessions[idx].tutorUid)
                    SessionController().addParticipant(auth, sessions[idx].sessionIndex.toString());

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
                child: Text(
                  "입장",
                ),
              ),
            )),
      ],
    );
  }
}
