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

  Chatting({Key key, @required this.sessionIndex}) : super(key: key);

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
    Session session = Provider.of<Session>(context);
    User auth = Provider.of<User>(context);

    if (auth != null) studentId = auth.studentId.toString();
    if (auth != null) name = auth.name;

    return session != null
        ? session.category.compareTo('종료') == 1
            ? Scaffold(
                appBar: AppBar(
                  title: Text('Chats'),
                  leading: IconButton(
                    onPressed: () async {
                      if (auth.Uid != session.tutorUid)
                        await FirebaseFirestore.instance
                            .collection('Sessions')
                            .doc(sessionIndex.toString())
                            .collection('Participants')
                            .doc(auth.studentId.toString())
                            .delete();

                      if(auth.Uid != session.tutorUid)
                        await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(auth.studentId.toString())
                        .collection('Sessions')
                        .add({
                          'date': FieldValue.serverTimestamp(),
                          'sessionName': session.sessionName,
                          'time': 0,
                          'tutorName': session.tutorName,
                        });

                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
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
                                if (session != null)
                                  _buildTutorButton(participants, session),
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
              )
        : CircularProgressIndicator();
  }

  Widget _buildTutorButton(List<Participant> ps, Session session) {
    return Column(
      children: [
        Container(
          width: 100,
          child: ElevatedButton(
            onPressed: () {
              if (ps != null) if (ps.length > 0)
                addChatMessage(ps[0].name + '님 차례입니다:)');
              else
                addChatMessage('현재 진행할 튜티가 없습니다:(');
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
              onSubmitted: _isComposing ? _handleSubmitted : null,
              onChanged: (String text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              decoration: InputDecoration.collapsed(hintText: 'Send a message'),
              focusNode: _focusNode,
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: CupertinoButton(
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : null,
                child: Icon(Icons.send),
              ))
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
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
      addChatMessage(text);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }

  Future<DocumentReference> addChatMessage(String text) {
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
