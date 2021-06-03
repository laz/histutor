import 'package:flutter/material.dart';
import 'package:histutor/model/Tutee.dart';

class TuteeStatus extends StatelessWidget {
  const TuteeStatus({Key key, @required this.idx, @required this.tuteeList})
      : super(key: key);
  final int idx;
  final List<Tutee> tuteeList;

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
            child: Text("튜티"),
          ),
          Container(
            width: 100,
            child: Text("시간"),
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
          child: Text(tuteeList[idx - 1].name),
        ),
        Container(
          width: 100,
          child: Text(tuteeList[idx - 1].time.toString()),
        ),
      ],
    );
  }
}
