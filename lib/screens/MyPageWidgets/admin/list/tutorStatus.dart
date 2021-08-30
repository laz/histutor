import 'package:flutter/material.dart';
import 'package:histutor/model/Tutor.dart';

class TutorStatus extends StatelessWidget {
  const TutorStatus({Key key, @required this.idx, @required this.tutorList})
      : super(key: key);
  final int idx;
  final List<Tutor> tutorList;

  @override
  Widget build(BuildContext context) {
    if (idx == 0) {
      return Row(
        children: [
          Container(
            width: 100,
            child: Text("NO.",
                style: TextStyle(
                  fontSize: 18,
                )),
          ),
          Container(
            width: 800,
            child: Text("튜터",
                style: TextStyle(
                  fontSize: 18,
                )),
          ),
          Container(
            width: 100,
            child: Text("시간(분)",
                style: TextStyle(
                  fontSize: 18,
                )),
          )
        ],
      );
    }
    return Row(
      children: tutorList[idx - 1].tutorTime > 0
          ? [
              Container(
                width: 100,
                child: Text(idx.toString()),
              ),
              Container(
                width: 800,
                child: Text(tutorList[idx - 1].name),
              ),
              Container(
                width: 100,
                child: Text(tutorList[idx - 1].tutorTime.toString()),
              ),
            ]
          : [],
    );
  }
}
