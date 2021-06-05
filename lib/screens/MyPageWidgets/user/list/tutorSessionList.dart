import 'package:flutter/material.dart';
import 'package:histutor/model/Subsession.dart';
import 'package:intl/intl.dart';

class TutorSessionList extends StatelessWidget {
  const TutorSessionList(
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
            child: Text("NO.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Expanded(
            // width: 800,
            child: Text("세션 이름",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            padding: EdgeInsets.only(right: 30),
            alignment: Alignment.center,
            width: 130,
            child: Text("참여일",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
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
          child: Text(idx.toString(),
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        Expanded(
          // width: 800,
          child: Text(sessionList[idx - 1].sessionName,
              style: TextStyle(
                fontSize: 15,
              )),
        ),
        Container(
          padding: EdgeInsets.only(right: 15),
          alignment: Alignment.center,
          width: 130,
          child: Text(DateFormat('yyyy-MM-dd')
              .format(sessionList[idx - 1].date.toDate())
              .toString(),
              style: TextStyle(
                fontSize: 15,
              )),
        ),
      ],
    );
  }
}
