import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:histutor/Chatting.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/model/User.dart';
import 'package:histutor/state/Database.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Sessions extends StatefulWidget {
  List<Session> sessions;

  int idx;
  Sessions({this.sessions, this.idx});
  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  @override
  Widget build(BuildContext context) {

    User auth = Provider.of<User>(context);

    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate =
        outputFormat.format(widget.sessions[widget.idx].sessionStart.toDate());
    bool isAdmin = false;

    return Row(
      children: [
        Container(
          width: 100,
          child: Text(widget.idx.toString()),
        ),
        Container(
          width: 200,
          child: Text(widget.sessions[widget.idx].category),
        ),
        Container(
          width: 300,
          child: Text(widget.sessions[widget.idx].sessionName),
        ),
        Container(
          width: 100,
          child: Text(widget.sessions[widget.idx].tutorName),
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
                  await FirebaseFirestore.instance.collection('Sessions').doc(widget.sessions[widget.idx].sessionIndex.toString())
                  .collection('Participants').doc(auth.studentId.toString()).set({
                    'entrance': FieldValue.serverTimestamp(),
                    'name': auth.name,
                    'studentId': auth.studentId,
                    'uid': auth.Uid,
                  });

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return MultiProvider(
                            providers: [
                              StreamProvider<List<Chat>>.value(
                                  value: Database().getSessionChats(
                                      widget.sessions[widget.idx].sessionIndex)),
                              StreamProvider<Session>.value(
                                  value: Database().getSession(widget
                                      .sessions[widget.idx].sessionIndex)),
                              StreamProvider<List<Participant>>.value(
                                  value: Database().getSessionParticipants(widget
                                      .sessions[widget.idx].sessionIndex)),
                            ],
                        child: Chatting(
                            sessionIndex: widget
                                .sessions[widget.idx].sessionIndex),
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
