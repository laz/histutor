import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/model/User.dart';
import 'package:provider/provider.dart';

import '../../../../controller/SessionController.dart';
import '../../../../model/Chat.dart';
import '../../../../model/Participant.dart';
import '../../../../model/Participant.dart';
import '../../../../model/Session.dart';
import 'package:intl/intl.dart';

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
  Participant cur;

  ScrollController _scrollController = ScrollController();

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
                    backgroundColor: Color(0xffffffff),
                    body: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(50, 20, 30, 0),
                        color: Color(0xffffffff),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.8,
                              color: Color(0xffebebeb),
                              child: Column(
                                children: [
                                  SizedBox(height: 15.0),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height: 50.0,
                                      color: Colors.grey,
                                      child: Center(
                                        child: Text(
                                            '세션 이름 : ' + session.sessionName,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      )),
                                  SizedBox(height: 20.0),
                                  Container(
                                    color: Colors.white,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                135.0) *
                                            0.75,
                                    child: Column(
                                      children: [
                                        Flexible(
                                          child: chats != null
                                              ? ListView.builder(
                                                  controller: _scrollController,
                                                  itemCount: chats.length + 1,
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (index == chats.length)
                                                      return Container(
                                                          height: 60.0);
                                                    return ListTile(
                                                      title: Text(
                                                          chats[index].from),
                                                      subtitle: Text(
                                                          chats[index].text),
                                                    );
                                                  },
                                                )
                                              : CircularProgressIndicator(),
                                        ),
                                        Divider(height: 1.0),
                                        _buildTextComposer(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 50.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(top: 20.0),
                                    color: Color(0xffebebeb),
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: 50.0,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Text('ZOOM LINK: ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              )),
                                        ],
                                      ),
                                    )),
                                SizedBox(height: 20.0),
                                Flexible(
                                  child: Container(
                                    color: Color(0xffebebeb),
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                70.0) *
                                            0.6,
                                    child: session != null
                                        ? Column(
                                            children: [
                                              Text('튜터: ' + session.tutorName),
                                              Text('오프라인 장소: ' +
                                                  session.offline),
                                              Text('시작 시간: ' +
                                                  DateFormat('yyyy-MM-dd HH:mm')
                                                      .format(session
                                                          .sessionStart
                                                          .toDate())
                                                      .toString()),
                                              Text('종료 시간: ' +
                                                  DateFormat('yyyy-MM-dd HH:mm')
                                                      .format(session.sessionEnd
                                                          .toDate())
                                                      .toString()),
                                              Row(
                                                children: [
                                                  Text('튜티: '),
                                                  participants != null
                                                      ? Column(
                                                          children: [
                                                            for (var p
                                                                in participants)
                                                              Text(p.name)
                                                          ],
                                                        )
                                                      : CircularProgressIndicator(),
                                                ],
                                              ),
                                              // SizedBox(height: 50.0),
                                            ],
                                          )
                                        : CircularProgressIndicator(),
                                  ),
                                ),
                                if (auth.Uid == session.tutorUid)
                                  _buildTutorButton(
                                      participants, session, auth),
                              ],
                            ),
                          ],
                        ),
                      ),
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
    return Container(
      child: Column(
        children: [
          SizedBox(height: 15.0),
          if (cur != null) Text(cur.name + '님이 현재 튜터링 진행중입니다:)'),
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
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff9BC7DA)),
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
                      SessionController()
                          .deleteParticipant(ps[0], session, auth);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff9BC7DA)),
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
                ps.isEmpty
                    ? await FirebaseFirestore.instance
                        .collection('Sessions')
                        .doc(sessionIndex.toString())
                        .update({
                        'category': "종료",
                      })
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            content: Text(
                                "아직 종료되지 않은 튜티가 남아있습니다.\n모든 튜티의 튜터링이 종료된 후 세션을 종료해주세요:)"),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Text("확인"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
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
      ),
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
    cur = p;
  }

  bool checkParticipantsList(
      List<Participant> participants, User auth, Session session) {
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

    setState(() {
      addChatMessage(text);
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 5),
        curve: Curves.easeOut,
      );
    });
    _focusNode.requestFocus();
  }

  Future<DocumentReference> addChatMessage(String text) async {
    return await FirebaseFirestore.instance
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
