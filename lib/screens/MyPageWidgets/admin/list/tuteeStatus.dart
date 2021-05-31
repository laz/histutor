import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:histutor/state/ApplicationState.dart';
import 'package:provider/provider.dart';
import 'package:histutor/model/Tutee.dart' ;

class TuteeStatus extends StatefulWidget {
  int idx;
  List<Tutee> tuteeList;
  TuteeStatus({
    this.idx,
    this.tuteeList,
=======

class TuteeStatus extends StatefulWidget {
  int idx;
  TuteeStatus({
    this.idx
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
  });
  @override
  _TuteeStatusState createState() => _TuteeStatusState();
}

class _TuteeStatusState extends State<TuteeStatus> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
    bool isAdmin = false;
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
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
<<<<<<< HEAD
          child: Text(widget.idx.toString()),
        ),
        Container(
          width: 800,
          child: Text(widget.tuteeList[widget.idx-1].name),
        ),
        Container(
          width: 100,
          child: Text(widget.tuteeList[widget.idx-1].time.toString()),
=======
          child: Text("33"),
        ),
        Container(
          width: 800,
          child: Text("16박주원"),
        ),
        Container(
          width: 100,
          child: Text("222"),
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
        ),
      ],
    );
  }
}
