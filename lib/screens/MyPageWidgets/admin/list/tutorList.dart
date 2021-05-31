import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:histutor/controller/UserController.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:provider/provider.dart';

import 'package:histutor/controller/UserController.dart';
import 'package:histutor/model/Tutor.dart';
import 'package:histutor/model/User.dart';

class TutorList extends StatefulWidget {
  int idx;
  List<Tutor> tutorList;
  TutorList({
    this.idx,
    this.tutorList,
=======

class TutorList extends StatefulWidget {
  int idx;
  TutorList({
    this.idx
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
  });
  @override
  _TutorListState createState() => _TutorListState();
}

class _TutorListState extends State<TutorList> {
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
            width: 200,
            child: Text("튜터"),
          ),
          Container(
            width: 400,
            child: Text("이메일"),
          ),
          Padding(
            padding: EdgeInsets.only(right: 100),
            child: Container(
              width: 100,
              child: Text("튜터 강등"),
            ),
          ),
          Container(
            width: 100,
            child: Text("관리자 지정"),
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
          width: 200,
          child: Text(widget.tutorList[widget.idx-1].name.toString()),
        ),
        Container(
          width: 400,
          child: Text(widget.tutorList[widget.idx-1].email.toString()),
=======
          child: Text("33"),
        ),
        Container(
          width: 200,
          child: Text("16박주원"),
        ),
        Container(
          width: 400,
          child: Text("21600293@handong.edu"),
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
        ),
        Padding(
            padding: EdgeInsets.only(right: 100),
            child: Container(
              width: 100,
              child: ElevatedButton(
<<<<<<< HEAD
                onPressed: (){
                  UserController().changeUserType(widget.tutorList[widget.idx-1].studentId.toString(), "tutee");
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xffe4c2c1)),
=======
                //onPressed: (),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff9BC7DA)),
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
                ),
                child: Text(
                  "강등",
                ),
              ),
            )
        ),
        Container(
            width: 100,
<<<<<<< HEAD
            child: ElevatedButton(
              onPressed: (){
                UserController().changeUserType(widget.tutorList[widget.idx-1].studentId.toString(), "admin");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffe4c2c1)),
=======
            child: (isAdmin) ? Container() :ElevatedButton(
              //onPressed: (),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff9BC7DA)),
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
              ),
              child: Text(
                "관리자 지정",
              ),
            )
        ),
      ],
    );
  }
}
