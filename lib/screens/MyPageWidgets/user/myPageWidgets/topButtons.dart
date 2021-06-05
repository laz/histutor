import 'package:flutter/material.dart';
import 'package:histutor/model/ApplyingTutor.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/model/User.dart';
import 'package:provider/provider.dart';
import 'package:histutor/controller/ApplyingTutorController.dart';
import 'package:histutor/model/ApplyingTutor.dart';

class TopButton extends StatelessWidget {
  const TopButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final applicationState = Provider.of<ApplicationState>(context);
    final user = Provider.of<User>(context);
    return (user.type == "tutee")
        // ? tutorButton(applicationState)
        ? tuteeButton(applicationState, user, context)
        : tutorButton(applicationState);
  }
}

Widget tuteeButton(
    ApplicationState applicationState, User user, BuildContext context) {
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
        child: ElevatedButton(
          onPressed: () {
            applicationState.changeSelectedMyPage(0);
          },
          style: ButtonStyle(
            backgroundColor: applicationState.selectedMyPage == 0
                ? MaterialStateProperty.all<Color>(Colors.pink)
                : MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Text(
            "참여한 세션",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
        child: ElevatedButton(
          onPressed: () {
            applicationState.changeSelectedMyPage(1);
          },
          style: ButtonStyle(
            backgroundColor: applicationState.selectedMyPage == 1
                ? MaterialStateProperty.all<Color>(Colors.pink)
                : MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Text(
            "닉네임 변경",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      Container(
        // alignment: Alignment.topRight,
        child: ElevatedButton(
          onPressed: () {
            ApplyingTutorController().applyingTutor(user.studentId, user.name);
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('튜터 신청 완료'),
                      content: Text('튜터 신청을 완료했습니다.'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text("나가기"))
                      ],
                    ));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
          ),
          child: Text(
            "튜터 신청",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget tutorButton(ApplicationState applicationState) {
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
        child: ElevatedButton(
          onPressed: () {
            applicationState.changeSelectedMyPage(0);
          },
          style: ButtonStyle(
            backgroundColor: applicationState.selectedMyPage == 0
                ? MaterialStateProperty.all<Color>(Colors.pink)
                : MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Text(
            "생성한 세션",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
        child: ElevatedButton(
          onPressed: () {
            applicationState.changeSelectedMyPage(1);
          },
          style: ButtonStyle(
            backgroundColor: applicationState.selectedMyPage == 1
                ? MaterialStateProperty.all<Color>(Colors.pink)
                : MaterialStateProperty.all<Color>(Colors.white),
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
