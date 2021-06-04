import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/model/User.dart';
import 'package:provider/provider.dart';

import '../../../../controller/SessionController.dart';
import '../../../../controller/SessionController.dart';
import '../../../../controller/SessionController.dart';
import '../../../../model/Participant.dart';
import '../../../../model/Session.dart';

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
            ? !checkParticipantsList(participants, auth, session)
                ? Dialog(
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('튜터링이 종료되었습니다:)'),
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
                : Scaffold(
                    appBar: AppBar(
                      title: Text('Chats'),
                      leading: IconButton(
                        onPressed: () async {
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
                                    Text('세션 이름: ' + session.sessionName),
                                    Text('튜터: ' + session.tutorName),
                                    Text('오프라인 장소: ' + session.offline),
                                    Text('시작 시간: ' +
                                        '${session.sessionStart.toDate().toString()}'),
                                    Text('줌링크: ' + session.zoomLink),
                                    Row(
                                      children: [
                                        Text('튜티: '),
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
                                      _buildTutorButton(
                                          participants, session, auth),
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

  // 튜터 시작 & 종료 버튼으로 시간 재기
  // 종료 버튼 누르면 튜티 참가자 목록에서 삭제 & 방에서 강퇴
  Widget _buildTutorButton(List<Participant> ps, Session session, User auth) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  if (ps != null) if (ps.length > 0)
                    startSession(ps[0], session.sessionIndex.toString());
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
            SizedBox(width: 20.0),
            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  if (ps != null) if (ps.length > 0)
                    SessionController().deleteParticipant(ps[0], session, auth);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff9BC7DA)),
                ),
                child: Text(
                  "종료",
                ),
              ),
            ),
          ],
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
              // 나가지 않은 튜티가 있을 경우 세션 종료 불가
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

  void startSession(Participant p, String session) {
    addChatMessage(p.name + '님 차례입니다:)');
    SessionController().updateStartTime(p, session);
  }

  bool checkParticipantsList(List<Participant> participants, User auth, Session session) {
    bool exist = false;

    if (auth.Uid == session.tutorUid) return true;

    Participant me;
    if (participants != null)
      for (Participant participant in participants) {
        if (participant.studentId == auth.studentId) {
          me = participant;
          break;
        }
      }

    exist = participants.contains(me);

    return exist;
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
