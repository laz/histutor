import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/model/User.dart';
import 'package:provider/provider.dart';
import 'package:histutor/controller/ApplyingTutorController.dart';

class TopButton extends StatelessWidget {
  const TopButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final applicationState = Provider.of<ApplicationState>(context);
    final user = Provider.of<User>(context);
    return (user.type == "tutee")
        ? tuteeButton(applicationState, user)
        : tutorButton(applicationState);
  }
}

Widget tuteeButton(ApplicationState applicationState, User user) {
  return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
            child: ElevatedButton(
              onPressed: () {
                applicationState.changeSelectedMyPage(0);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
              ),
              child: Text(
                "참여한_세션",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
            child: ElevatedButton(
              onPressed: () {
                applicationState.changeSelectedMyPage(1);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
              ),
              child: Text(
                "닉네임 변경",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  ApplyingTutorController().applyingTutor(user.studentId, user.name);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
                ),
                child: Text(
                  "튜터 신청하기",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )
        ],
      ));
}

Widget tutorButton(ApplicationState applicationState) {
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
        child: ElevatedButton(
          onPressed: () {
            applicationState.changeSelectedMyPage(0);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
          ),
          child: Text(
            "생성한_세션",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
        child: ElevatedButton(
          onPressed: () {
            applicationState.changeSelectedMyPage(1);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
          ),
          child: Text(
            "닉네임 변경",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    ],
  );
}
