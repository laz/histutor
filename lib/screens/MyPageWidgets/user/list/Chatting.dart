import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/model/User.dart';
import 'package:histutor/screens/MyPageWidgets/user/myPageWidgets/SessionButton.dart';
import 'package:histutor/screens/MyPageWidgets/user/myPageWidgets/SessionEditDialog.dart';
import 'package:histutor/screens/MyPageWidgets/userAppBar.dart';
import 'package:provider/provider.dart';

import '../../../../controller/SessionController.dart';
import '../../../../model/Chat.dart';
import '../../../../model/Participant.dart';
import '../../../../model/Session.dart';
import 'package:intl/intl.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class Chatting extends StatefulWidget {
  final int sessionIndex;

  Chatting({Key key, @required this.sessionIndex}) : super(key: key);

  @override
  _ChattingState createState() => _ChattingState(this.sessionIndex);
}

class _ChattingState extends State<Chatting> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final player = AssetsAudioPlayer();
  bool _isComposing = false;
  int sessionIndex;
  String studentId;
  String name;
  bool alert = false;

  Participant studentBeingTutored = null;
  Participant actualStudentBeingTutored = null;

  ScrollController _scrollController = ScrollController();

  _ChattingState(int sessionIndex) {
    this.sessionIndex = sessionIndex;
  }

  @override
  Widget build(BuildContext context) {
    List<Chat> chats = Provider.of<List<Chat>>(context);
    List<Participant> participants = Provider.of<List<Participant>>(context);
    Session session = Provider.of<Session>(context);
    User user = Provider.of<User>(context);

    Participant currentParticipant;

    if (participants != null) {
      for (Participant participant in participants) {
        if (participant.id == user.id) {
          currentParticipant = participant;
          if (participant.alert == true) {
            alert = true;
            player.open(Audio("assets/notification.mp3"));
          } else
            alert = false;
          break;
        }
      }
    }

    if (user != null) studentId = user.studentId.toString();
    if (user != null) name = user.nickname;

    if (participants != null && session.actualStudentBeingTutored != null) {
      for (Participant participant in participants) {
        if (participant.id == session.actualStudentBeingTutored) {
          studentBeingTutored = participant;
          actualStudentBeingTutored = participant;
        }
      }
    }

    return session != null
        ? session.category.compareTo('종료') == 1
            ? session.tutorId != user.id &&
                    session.participants.contains(user.id) == false
                ? Dialog(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('튜터링이 종료되었습니다:)',
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            SizedBox(height: 30.0),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xff9BC7DA)),
                                ),
                                child: Text("세션 목록으로 돌아가기",
                                    style: TextStyle(
                                      fontSize: 18,
                                    )),
                              ),
                            ),
                          ],
                        )),
                  )
                : Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(80),
                      child: UserAppBar(
                        isAdmin: false,
                        user: user,
                      ),
                    ),
                    backgroundColor: Color(0xffffffff),
                    body: Stack(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(50, 20, 30, 0),
                            color: Color(0xffffffff),
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  color: Color(0xffebebeb),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 15.0),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          height: 50.0,
                                          color: Colors.grey,
                                          child: Center(
                                            child: Text(
                                                '세션 이름 : ' +
                                                    session.sessionName,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18)),
                                          )),
                                      SizedBox(height: 20.0),
                                      Container(
                                        color: Colors.white,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: (MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                135.0) *
                                            0.75,
                                        child: Column(
                                          children: [
                                            Flexible(
                                              child: chats != null
                                                  ? ListView.builder(
                                                      reverse: true,
                                                      controller:
                                                          _scrollController,
                                                      itemCount:
                                                          chats.length + 1,
                                                      itemBuilder:
                                                          (context, index) {
                                                        if (index ==
                                                            chats.length)
                                                          return Container(
                                                              height: 60.0);
                                                        return ListTile(
                                                          title: Text(
                                                            chats[index].from,
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                          subtitle: Text(
                                                            chats[index].text,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
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
                                SizedBox(width: 150.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/zoomicon.png',
                                          width: 50,
                                          height: 50,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            window.open(
                                                session.zoomLink, 'new tab');
                                          },
                                          child: Text('Zoom Link',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.0),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          40.0, 30.0, 40.0, 30.0),
                                      color: Color(0xffebebeb),
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          (MediaQuery.of(context).size.height -
                                                  70.0) *
                                              0.5,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: session != null
                                            ? Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(bottom: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                showDialog(
                                                                  context: context,
                                                                  builder:
                                                                      (BuildContext
                                                                  context) {
                                                                    return SessionEditDialog(
                                                                      session:
                                                                      session,
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              style: ButtonStyle(
                                                                backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors.grey),
                                                              ),
                                                              child: Text(
                                                                "수 정",
                                                                style: TextStyle(
                                                                  fontSize: 18,
                                                                ),
                                                              )),
                                                        ],

                                                      )),
                                                  Text(
                                                      '튜터: ' +
                                                          session.tutorName,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 21,
                                                      )),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                      '진행중인 튜티: ' +
                                                          (session.actualStudentBeingTutored ==
                                                                  null
                                                              ? '없음'
                                                              : session
                                                                  .actualStudentBeingTutored),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 21,
                                                      )),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                      '오프라인 장소: ' +
                                                          session.offline,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                      '시작 시간: ' +
                                                          DateFormat(
                                                                  'yyyy-MM-dd HH:mm')
                                                              .format(session
                                                                  .sessionStart
                                                                  .toDate())
                                                              .toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                      '종료 시간: ' +
                                                          DateFormat(
                                                                  'yyyy-MM-dd HH:mm')
                                                              .format(session
                                                                  .sessionEnd
                                                                  .toDate())
                                                              .toString(),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text('대기중인 튜티: ',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      participants != null
                                                          ? Column(
                                                              children: [
                                                                for (var p
                                                                    in participants)
                                                                  user.id ==
                                                                          session
                                                                              .tutorId
                                                                      ? _buildTuteesList(
                                                                          p,
                                                                          session)
                                                                      : _buildForTuteeList(
                                                                          p),
                                                              ],
                                                            )
                                                          : CircularProgressIndicator(),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : CircularProgressIndicator(),
                                      ),
                                    ),
                                    //TODO: tutor id로 하기
                                    if (user.id == session.tutorId)
                                      _buildTutorButton(
                                          participants, session, user),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (alert == true)
                          AlertDialog(
                            content: Text(
                                "${user.nickname}님 차례입니다. 지금 튜터링을 받으시려면 채팅을 남겨주세요."),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Text("확인"),
                                onPressed: () {
                                  setState(() {
                                    alert = false;
                                    SessionController().alertParticipant(
                                        currentParticipant,
                                        session.sessionIndex.toString(),
                                        false);
                                  });
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  )
            : Dialog(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('해당 세션은 종료되었습니다:(',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        SizedBox(height: 30.0),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff9BC7DA)),
                            ),
                            child: Text("세션 목록으로 돌아가기",
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                          ),
                        ),
                      ],
                    )),
              )
        : CircularProgressIndicator();
  }

  Widget _buildForTuteeList(Participant p) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                p.nickname,
                style: TextStyle(fontSize: 15.0),
              ),
            ],
          ),
          SizedBox(height: 3.0),
        ],
      ),
    );
  }

  Widget _buildTuteesList(Participant p, Session s) {
    bool noOneBeingTutored = studentBeingTutored == null ? true : false;

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                p.nickname,
                style: TextStyle(fontSize: 15.0),
              ),
              Checkbox(
                  value: noOneBeingTutored
                      ? false
                      : studentBeingTutored.id == p.id
                          ? true
                          : false,
                  onChanged: (value) {
                    setState(() {
                      if (studentBeingTutored == null)
                        studentBeingTutored = p;
                      else {
                        if (actualStudentBeingTutored == null) {
                          if (studentBeingTutored.id == p.id)
                            studentBeingTutored = null;
                          else
                            studentBeingTutored = p;
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                content: Text("튜터링이 진행중일 때는 체크박스를 변경할 수 없습니다."),
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
                        }
                      }
                    });
                  }),
              IconButton(
                icon: Icon(Icons.notifications_none),
                onPressed: () {
                  SessionController()
                      .alertParticipant(p, s.sessionIndex.toString(), true);
                  Future.delayed(const Duration(seconds: 15), () {
                    SessionController()
                        .alertParticipant(p, s.sessionIndex.toString(), false);
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  if (studentBeingTutored == null ||
                      studentBeingTutored.id != p.id) {
                    SessionController().deleteParticipant(p, s, null);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          content: Text("튜티를 목록에서 제거하려면 체크박스를 해제해주세요."),
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
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 3.0),
        ],
      ),
    );
  }

  // 튜터 시작 & 종료 버튼으로 시간 재기
  // 종료 버튼 누르면 튜티 참가자 목록에서 삭제 & 방에서 강퇴
  Widget _buildTutorButton(List<Participant> ps, Session session, User user) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 15.0),
          Text(actualStudentBeingTutored == null
              ? ""
              : actualStudentBeingTutored.nickname + '님이 현재 튜터링 진행중입니다:)'),
          SizedBox(height: 15.0),
          Row(
            children: [
              Container(
                width: 100,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    // firebase에 studentBeingTutored 정보 update
                    if (studentBeingTutored != null) {
                      startSession(
                          studentBeingTutored, session.sessionIndex.toString());
                    } else
                      addChatMessage('현재 진행할 튜티가 없습니다:(');
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff9BC7DA)),
                  ),
                  child: Text("시  작",
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
              ),
              SizedBox(width: 20.0),
              // delete top of tutee list
              Container(
                width: 100,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    // session.studentBeingTutored가 있으면 종료하고
                    // 없으면 시작 안하고 체크만 누른거니까 아무것도 안해
                    print(actualStudentBeingTutored.id);
                    if (actualStudentBeingTutored != null) {
                      SessionController().deleteParticipant(
                          actualStudentBeingTutored, session, user);
                      studentBeingTutored = null;
                      actualStudentBeingTutored = null;
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff9BC7DA)),
                  ),
                  child: Text("종  료",
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Container(
            width: 100,
            height: 50.0,
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
              child: Text("세션 종료",
                  style: TextStyle(
                    fontSize: 18,
                  )),
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
              style: TextStyle(fontSize: 24),
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
    addChatMessage(p.nickname + '님 차례입니다:)');
    SessionController().updateStartTime(p, session);
    SessionController().updateActualStudentBeingTutored(p.id, session);
    actualStudentBeingTutored = p;
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
