import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/model/User.dart';
import 'package:provider/provider.dart';
=======
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f

class TopButton extends StatefulWidget {
  @override
  _TopButtonState createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
<<<<<<< HEAD

  @override
  Widget build(BuildContext context) {
    final applicationState = Provider.of<ApplicationState>(context);
    final user = Provider.of<User>(context);
    return (user.type == "tutee") ? tuteeButton(applicationState) : tutorButton(applicationState);
  }
}
Widget tuteeButton(ApplicationState applicationState){
=======
  @override
  Widget build(BuildContext context) {
    bool isTutee = false;
    return (isTutee) ? tuteeButton() : tutorButton();
  }
}
Widget tuteeButton(){
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
  return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child :Row(
        children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
          child: ElevatedButton(
<<<<<<< HEAD
            onPressed: (){
              applicationState.changeSelectedMyPage(0);
            },
=======
            //onPressed: (),
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
            ),
            child: Text(
                  "참여한_세션",
<<<<<<< HEAD
              style: TextStyle(
                color: Colors.black,
              ),
=======
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
          child: ElevatedButton(
<<<<<<< HEAD
            onPressed: (){
              applicationState.changeSelectedMyPage(1);
            },
=======
            //onPressed: (),
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
            ),
            child: Text(
              "닉네임 변경",
<<<<<<< HEAD
              style: TextStyle(
                color: Colors.black,
              ),
=======
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
            ),
          ),
        ),
      ],
    )
  );
}
<<<<<<< HEAD
Widget tutorButton(ApplicationState applicationState){
=======

Widget tutorButton(){
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
        child: ElevatedButton(
<<<<<<< HEAD
          onPressed: (){
            applicationState.changeSelectedMyPage(0);
          },
=======
          //onPressed: (),
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
          ),
          child: Text(
            "생성한_세션",
<<<<<<< HEAD
            style: TextStyle(
              color: Colors.black,
            ),
=======
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
        child: ElevatedButton(
<<<<<<< HEAD
          onPressed: (){
            applicationState.changeSelectedMyPage(1);
          },
=======
          //onPressed: (),
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
          ),
          child: Text(
            "닉네임 변경",
<<<<<<< HEAD
            style: TextStyle(
              color: Colors.black,
            ),
=======
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
          ),
        ),
      ),
    ],
  );
}
