import 'package:flutter/material.dart';
import 'screens/homePage.dart';
import 'package:histutor/Chatting.dart';
import 'package:histutor/Mypage.dart';
import 'package:histutor/controller/SessionController.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/state/Authentication.dart';
import 'package:histutor/state/Database.dart';
import 'package:histutor/Participants.dart';
import 'package:provider/provider.dart';


import 'model/User.dart';

class histutor extends StatefulWidget {
  const histutor({Key key}) : super(key: key);

  @override
  _histutorState createState() => _histutorState();
}

class _histutorState extends State<histutor> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        backgroundColor: Color(0xffede2df),
        primaryColor: Color(0xffede2df),
/*
    List<Session> sessions = Provider.of<List<Session>>(context);
    User user = Provider.of<User>(context);
    print('histutor rebuild');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => Authentication().signOut(),
        ),
        title: Text('hitutor'),
        actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Mypage()));
              })
        ],
      ),
      // catchError?
      body: sessions != null && user != null
          ? ListView.builder(
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sessions[index].sessionName),
                  subtitle: Text(sessions[index].sessionIndex.toString()),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        // order by
                        builder: (context) =>
                            StreamProvider<List<Participant>>.value(
                                value: Database().getSessionParticipants(
                                    sessions[index].sessionIndex),
                                child: Participants(
                                    sessionIndex:
                                        sessions[index].sessionIndex))));
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              StreamProvider<List<Chat>>.value(
                                  value: Database().getSessionChats(
                                      sessions[index].sessionIndex),
                                  child: Chatting(
                                      sessionIndex:
                                          sessions[index].sessionIndex))));
                    },
                  ),
                );
              },
            )
          : CircularProgressIndicator(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print(sessions.length);
          SessionController().addSession(sessions.length);
        },*/
      ),
    );
  }
}
