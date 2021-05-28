import 'package:flutter/material.dart';

class TutorStatus extends StatefulWidget {
  int idx;
  TutorStatus({
    this.idx
  });
  @override
  _TutorStatusState createState() => _TutorStatusState();
}

class _TutorStatusState extends State<TutorStatus> {
  @override
  Widget build(BuildContext context) {
    bool isAdmin = false;
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
          child: Text("33"),
        ),
        Container(
          width: 800,
          child: Text("16박주원"),
        ),
        Container(
          width: 100,
          child: Text("222"),
        ),
      ],
    );
  }
}
