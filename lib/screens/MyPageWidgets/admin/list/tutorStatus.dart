import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:provider/provider.dart';
import 'package:histutor/model/Tutor.dart';

class TutorStatus extends StatefulWidget {
  int idx;
  List<Tutor> tutorList;
  TutorStatus({
    this.idx,
    this.tutorList,
  });
  @override
  _TutorStatusState createState() => _TutorStatusState();
}

class _TutorStatusState extends State<TutorStatus> {
  @override
  Widget build(BuildContext context) {
    if(widget.idx == 0){
      return Row(
        children: [
          Container(
            width: 100,
            child: Text("NO."),
          ),
          Container(
            width: 800,
            child: Text("튜터"),
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
          child: Text(widget.idx.toString()),
        ),
        Container(
          width: 800,
          child: Text(widget.tutorList[widget.idx-1].name),
        ),
        Container(
          width: 100,
          child: Text(widget.tutorList[widget.idx-1].time.toString()),
        ),
      ],
    );
  }
}
