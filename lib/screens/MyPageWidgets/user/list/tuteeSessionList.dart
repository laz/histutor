import 'package:flutter/material.dart';
import 'package:histutor/model/Subsession.dart';
import 'package:intl/intl.dart';

class TuteeSessionList extends StatelessWidget {
  const TuteeSessionList(
      {Key key, @required this.idx, @required this.sessionList})
      : super(key: key);
  final int idx;
  final List<Subsession> sessionList;

  @override
  Widget build(BuildContext context) {
    if (idx == 0) {
      return Row(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            width: 110,
            // child: Text("NO."),
          ),
          Expanded(
            // width: 800,
            child: Text("세션 이름"),
          ),
          // Container(
          //   alignment: Alignment.center,
          //   width: 100,
          //   child: Text("튜터"),
          // ),
          Container(
            padding: EdgeInsets.only(right: 30),
            alignment: Alignment.center,
            width: 130,
            child: Text("참여일"),
          )
        ],
      );
    }
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          width: 110,
          child: Text(idx.toString()),
        ),
        Expanded(
          // width: 800,
          child: Text(sessionList[idx - 1].sessionName),
        ),
        // Container(
        //   width: 100,
        //   child: Text(sessionList[idx - 1].tutorName),
        // ),
        Container(
          padding: EdgeInsets.only(right: 15),
          alignment: Alignment.center,
          width: 130,
          child: Text(DateFormat('yyyy-MM-dd')
              .format(sessionList[idx - 1].date.toDate())
              .toString()),
        ),
      ],
    );
  }
}
