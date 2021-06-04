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

    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(sessions[idx].sessionStart.toDate());

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
          child: Text(outputDate),
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
