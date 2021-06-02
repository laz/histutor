import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/model/User.dart';
import 'package:provider/provider.dart';

import 'model/Session.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({this.name, this.text, this.animationController});
  final String name;
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Chatting extends StatefulWidget {
  final int sessionIndex;
  final String fromName;

  Chatting({Key key, @required this.sessionIndex, @required this.fromName})
      : super(key: key);

  @override
  _ChattingState createState() => _ChattingState(this.sessionIndex);
}

class _ChattingState extends State<Chatting> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;
  int sessionIndex;
  String studentId;
  String name;

  _ChattingState(int sessionIndex) {
    this.sessionIndex = sessionIndex;
  }

  @override
  Widget build(BuildContext context) {
    List<Chat> chats = Provider.of<List<Chat>>(context);
    List<Participant> participants = Provider.of<List<Participant>>(context);
    List<Session> sessions = Provider.of<List<Session>>(context);
    Session session = Provider.of<Session>(context);
    User auth = Provider.of<User>(context);

    studentId = auth.studentId.toString();
    name = auth.name;

    return session.category.compareTo('종료') == 1
        ? Scaffold(
            appBar: AppBar(
              title: Text('Chats'),
            ),
            body: Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(150.0, 50.0, 0.0, 50.0),
                  width: 500.0,
                  height: 700.0,
                  child: Column(
                    children: [
                      Flexible(
                        child: chats != null
                            ? ListView.builder(
                                itemCount: chats.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(chats[index].from),
                                    subtitle: Text(chats[index].text),
                                  );
                                },
                              )
                            : CircularProgressIndicator(),
                      ),
                      Divider(height: 1.0),
                      Container(child: _buildTextComposer()),
                    ],
                  ),
                ),
                SizedBox(width: 20.0),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 50.0, 100.0, 50.0),
                  width: 400.0,
                  height: MediaQuery.of(context).size.height,
                  child: session != null
                      ? Column(
                          children: [
                            Text('SESSION NAME: ' + session.sessionName),
                            Text('TUTOR: ' + session.tutorName),
                            Text('OFFLINE: ' + session.offline),
                            Text('START TIME: ' +
                                '${session.sessionStart.toDate().toString()}'),
                            Text('ZOOM LINK: ' + session.zoomLink),
                            Row(
                              children: [
                                Text('TUTEES: '),
                                participants != null
                                    ? Column(
                                        children: [
                                          for (var p in participants)
                                              Text(p.name)
                                        ],
                                      )
                                    : CircularProgressIndicator(),
                              ],
                            ),
                            SizedBox(height: 50.0),
                            if (auth.Uid == session.tutorUid)
                              _buildTutorButton(participants[0], session),

                            Container(
                              width: 300,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance.collection('Sessions')
                                  .doc(sessionIndex.toString()).collection('Participants')
                                  .doc(auth.studentId.toString()).delete();
                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Color(0xff9BC7DA)),
                                ),
                                child: Text(
                                  "나가기",
                                ),
                              ),
                            ),
                          ],
                        )
                      : CircularProgressIndicator(),
                )
              ],
            ),
          )
        : Dialog(
            child: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('해당 세션은 종료되었습니다:('),
                SizedBox(height: 30.0),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff9BC7DA)),
                    ),
                    child: Text(
                      "세션 목록으로 돌아가기",
                    ),
                  ),
                ),
              ],
            )),
          );
  }

  Widget _buildTutorButton(Participant p, Session session) {
    return Column(
      children: [
        Container(
          width: 100,
          child: ElevatedButton(
            onPressed: () {
              if (p.uid != session.tutorUid)
                addChatMessage(p.name + '님 차례입니다:)', p.name);
              else
                addChatMessage('현재 진행할 튜티가 없습니다:(', p.name);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff9BC7DA)),
            ),
            child: Text(
              "시작",
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          width: 100,
          child: ElevatedButton(
            onPressed: () {
              // Navigator.push(context,
              //   MaterialPageRoute(
              //     // fullscreenDialog: true,
              //     builder: (context) => new timePage(),
              //   ),
              // );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff9BC7DA)),
            ),
            child: Text(
              "시간 기록",
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          width: 100,
          child: ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('Sessions')
                  .doc(sessionIndex.toString())
                  .update({
                'category': "종료",
              });
              Navigator.of(context).pop();
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //       builder: (context) => SessionPage()),
              // );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff9BC7DA)),
            ),
            child: Text(
              "세션 종료",
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onChanged: (String text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              // onSubmitted: _isComposing ? _handleSubmitted : null,
              decoration: InputDecoration.collapsed(hintText: 'Send a message'),
              focusNode: _focusNode,
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: CupertinoButton(
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text, name)
                    : null,
                child: Icon(Icons.send),
              ))
        ],
      ),
    );
  }

  void _handleSubmitted(String text, String name) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    var message = ChatMessage(
      name: name,
      text: text,
      animationController: AnimationController(
        duration: const Duration(milliseconds: 30),
        vsync: this,
      ),
    );
    setState(() {
      addChatMessage(text, name);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }

  Future<DocumentReference> addChatMessage(String text, String name) {
    return FirebaseFirestore.instance
        .collection('Sessions')
        .doc(sessionIndex.toString())
        .collection('Chats')
        .add({
      'from': name,
      'text': text,
      'time': FieldValue.serverTimestamp(),
    });
  }
}
