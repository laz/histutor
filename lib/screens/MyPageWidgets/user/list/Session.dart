import 'package:flutter/material.dart';
import 'package:histutor/Chatting.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/state/Database.dart';
import 'package:provider/provider.dart';

class Sessions extends StatefulWidget {
  List<Session> sessions;

  int idx;
  Sessions({
    this.sessions,
    this.idx
  });
  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  @override
  Widget build(BuildContext context) {
    bool isAdmin = false;
    if(widget.idx == 0){
      return Row(
        children: [
          Container(
            width: 100,
            child: Text("NO."),
          ),
          Container(
            width: 200,
            child: Text("STATUS"),
          ),
          Container(
            width: 300,
            child: Text("방 이름"),
          ),
          Container(
              width: 100,
              child: Text("작성"),
            ),
          Container(
            width: 200,
            child: Text("작성일"),
          )
        ],
      );
    }
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
          child: Text(widget.sessions[widget.idx].sessionStart.toDate().day.toString()),
        ),
        Padding(
            padding: EdgeInsets.only(right: 100),
            child: Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => StreamProvider<List<Chat>>.value(
                              value: Database().getSessionChats(widget.sessions[widget.idx].sessionIndex),
                              child: Chatting(sessionIndex: widget.sessions[widget.idx].sessionIndex)
                          )
                      )
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff9BC7DA)),
                ),
                child: Text(
                  "입장",
                ),
              ),
            )
        ),
      ],
    );
  }
}
