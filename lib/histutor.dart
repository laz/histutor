import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:histutor/Chatting.dart';
import 'package:histutor/controller/SessionController.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/state/Database.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/Participants.dart';
import 'package:provider/provider.dart';

import 'makeRoom.dart';

class histutor extends StatefulWidget {
  const histutor({Key key}) : super(key: key);

  @override
  _histutorState createState() => _histutorState();
}

class _histutorState extends State<histutor> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    List<Session> sessions = Provider.of<List<Session>>(context);
  print('done');
    return Scaffold(
      appBar: AppBar(title: Text('hitutor')),
      // catchError?
      body: sessions != null
          ? ListView.builder(
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sessions[index].sessionName),
                  subtitle: Text(sessions[index].sessionIndex.toString()),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        // order by
                        builder: (context) => StreamProvider<List<Participant>>.value(
                          value: Database().getSessionParticipants(sessions[index].sessionIndex),
                            child: Participants(sessionIndex: sessions[index].sessionIndex)
                        )
                      )
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => StreamProvider<List<Chat>>.value(
                                value: Database().getSessionChats(sessions[index].sessionIndex),
                                  child: Chatting(sessionIndex: sessions[index].sessionIndex)
                              )
                          )
                      );
                    },
                  ),
                );
              },
            )
          : CircularProgressIndicator(),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: Database().getSessions(),
      //   builder: (context, sessions) {
      //     if(sessions.hasError)
      //       return Text('Oops, something went wrong...');
      //     else if(sessions.hasData) {
      //       if(sessions.data.docs.isEmpty)
      //         return Text('No Sessions...');
      //       else
      //         return ListView.builder(
      //           itemCount: sessions.data.docs.length,
      //           itemBuilder: (context, index) {
      //             return ListTile(
      //               title: Text(sessions.data.docs[index].id),
      //               onTap: () {
      //                 Navigator.of(context).push(
      //                   MaterialPageRoute(
      //                     builder: (context) => TestPage(sessionIndex: sessions.data.docs[index].id.toString(),)
      //                   )
      //                 );
      //                 // print(sessions.data.docs[index].data().toString());
      //               },
      //             );
      //           },
      //         );
      //     }
      //     else
      //       return CircularProgressIndicator();
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: () =>
              Navigator.push(context,
                MaterialPageRoute(
                  // fullscreenDialog: true,
                  builder: (context) => new makeRoom(),
                ),
              )
      ),
      // floatingActionButton: Consumer<SessionController>(
      //   builder: (context, sessionController, _) => FloatingActionButton(
      //     child: Icon(Icons.wb_sunny),
      //     onPressed: () {
      //       print(sessions.length);
      //       sessionController.addSession(sessions.length);
      //     },
      //   ),
      // ),
    );
  }
}
