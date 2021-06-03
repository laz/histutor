import 'package:flutter/material.dart';
import 'package:histutor/model/Subsession.dart';

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
            width: 100,
            child: Text("NO."),
          ),
          Container(
            width: 800,
            child: Text("방_이름"),
          ),
          Container(
            width: 100,
            child: Text("참여일"),
          )
        ],
      );
    }
    return Row(
      children: [
        Container(
          width: 100,
          child: Text(idx.toString()),
        ),
        Container(
          width: 800,
          child: Text(sessionList[idx - 1].sessionName),
        ),
        Container(
          width: 100,
          child:
              Text(sessionList[idx - 1].date.toDate().toString()),
        ),
      ],
    );
  }
}
