import 'package:flutter/material.dart';

class TuteeStatus extends StatefulWidget {
  int idx;
  TuteeStatus({
    this.idx
  });
  @override
  _TuteeStatusState createState() => _TuteeStatusState();
}

class _TuteeStatusState extends State<TuteeStatus> {
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
