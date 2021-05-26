import 'package:flutter/material.dart';

class TopButton extends StatefulWidget {
  @override
  _TopButtonState createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
  @override
  Widget build(BuildContext context) {
    bool isTutee = false;
    return (isTutee) ? tuteeButton() : tutorButton();
  }
}
Widget tuteeButton(){
  return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child :Row(
        children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
          child: ElevatedButton(
            //onPressed: (),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
            ),
            child: Text(
                  "참여한_세션",
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
          child: ElevatedButton(
            //onPressed: (),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
            ),
            child: Text(
              "닉네임 변경",
            ),
          ),
        ),
      ],
    )
  );
}
Widget tutorButton(){
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
        child: ElevatedButton(
          //onPressed: (),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
          ),
          child: Text(
            "생성한_세션",
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
        child: ElevatedButton(
          //onPressed: (),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xffFFFFFF)),
          ),
          child: Text(
            "닉네임 변경",
          ),
        ),
      ),
    ],
  );
}
