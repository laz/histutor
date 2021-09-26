import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/model/User.dart';
import 'package:provider/provider.dart';


class SessionEditDialog extends StatefulWidget {
  final Session session;
  const SessionEditDialog({Key key, @required this.session}) : super(key: key);

  @override
  _SessionEditDialogState createState() => _SessionEditDialogState();
}

class _SessionEditDialogState extends State<SessionEditDialog> {
  @override
  Widget build(BuildContext context) {
    List<Session> sessions = Provider.of<List<Session>>(context);
    User user = Provider.of<User>(context);
    final Session session = widget.session;

    final _sessionName = TextEditingController(text: session.sessionName);
    final _offsession = TextEditingController(text: session.offline);
    final _zoomlink = TextEditingController(text: session.zoomLink);
    DateTime _starttime = session.sessionStart.toDate();
    DateTime _endtime = session.sessionEnd.toDate();

    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(13.0))),
        child: Container(
            height: 700,
            width: 405,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffD1E5EE),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13.0),
                      topRight: Radius.circular(13.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("TA 세션 수정"),
                    ],
                  ),
                  width: 405,
                  height: 66,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
                Flexible(
                  child: SingleChildScrollView(
                      child: Container(
                        height: 1000,
                        width: 405,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                width: 363,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _sessionName,
                                      decoration: InputDecoration(
                                        labelText: '방이름',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value.length < 1) return '필수 항목입니다.';
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _offsession,
                                      decoration: InputDecoration(
                                        labelText: '오프라인장소',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _zoomlink,
                                      decoration: InputDecoration(
                                        labelText: '줌링크',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("시작 시각을 선택하세요."),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 150,
                                      width: 363,
                                      child: CupertinoDatePicker(
                                          initialDateTime: _starttime,
                                          minimumDate: session.createdTime.toDate(),
                                          mode: CupertinoDatePickerMode.dateAndTime,
                                          onDateTimeChanged: (datetime) {
                                            setState(() {
                                              _starttime = datetime;
                                            });
                                          }),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("끝나는 시각을 선택하세요."),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 150,
                                      width: 300,
                                      child: CupertinoDatePicker(
                                          initialDateTime: _endtime,
                                          minimumDate: session.createdTime.toDate(),
                                          mode: CupertinoDatePickerMode.dateAndTime,
                                          onDateTimeChanged: (datetime) {
                                            setState(() {
                                              _endtime = datetime;
                                            });
                                          }),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    RaisedButton(
                                      child: Text("수 정"),
                                      onPressed: () async {
                                        if (_sessionName.text != "") {
                                          Timestamp t_start =
                                          Timestamp.fromDate(_starttime);
                                          Timestamp t_end =
                                          Timestamp.fromDate(_endtime);
                                          FirebaseFirestore firestore =
                                              FirebaseFirestore.instance;
                                          firestore
                                              .collection('Sessions')
                                              .doc(session.sessionIndex.toString())
                                              .update({
                                            'sessionStart': t_start,
                                            'sessionEnd': t_end,
                                            'sessionName': _sessionName.text,
                                            'zoomLink': _zoomlink.text,
                                            'offline': _offsession.text,
                                          });
                                        }
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                )),
                          ],
                        ),
                      )),
                )
              ],
            )));
  }
}
