import 'package:flutter/material.dart';
import 'package:histutor/controller/UserController.dart';
import 'package:histutor/model/Tutor.dart';

class TutorList extends StatelessWidget {
  const TutorList({Key key, @required this.idx, @required this.tutorList})
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
          child: Text(idx.toString()),
        ),
        Container(
          width: 200,
          child: Text(tutorList[idx - 1].name.toString()),
        ),
        Container(
          width: 400,
          child: Text(tutorList[idx - 1].email.toString()),
        ),
        Padding(
            padding: EdgeInsets.only(right: 100),
            child: Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  UserController().changeUserType(
                      tutorList[idx - 1].studentId.toString(), "tutee");
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xffe4c2c1)),
                ),
                child: Text(
                  "강등",
                ),
              ),
            )),
        Container(
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                UserController().changeUserType(
                    tutorList[idx - 1].studentId.toString(), "admin");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffe4c2c1)),
              ),
              child: Text(
                "관리자 지정",
              ),
            )),
      ],
    );
  }
}