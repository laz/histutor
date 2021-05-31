import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:provider/provider.dart';
import 'package:histutor/model/Subsession.dart';

class TutorSessionList extends StatefulWidget {
  int idx;
  List<Subsession> sessionList;
  TutorSessionList({
    this.idx,
    this.sessionList,
  });
  @override
  _TutorSessionListState createState() => _TutorSessionListState();
}

class _TutorSessionListState extends State<TutorSessionList> {
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
          child: Text(widget.idx.toString()),
        ),
        Container(
          width: 800,
          child: Text(widget.sessionList[widget.idx-1].sessionName),
        ),
        Container(
          width: 100,
          child: Text(widget.sessionList[widget.idx-1].date.toDate().toString()),
        ),
      ],
    );
  }
}
