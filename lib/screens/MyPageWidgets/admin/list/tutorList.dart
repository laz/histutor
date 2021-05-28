import 'package:flutter/material.dart';

class TutorList extends StatefulWidget {
  int idx;
  TutorList({
    this.idx
  });
  @override
  _TutorListState createState() => _TutorListState();
}

class _TutorListState extends State<TutorList> {
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
          child: Text("33"),
        ),
        Container(
          width: 200,
          child: Text("16박주원"),
        ),
        Container(
          width: 400,
          child: Text("21600293@handong.edu"),
        ),
        Padding(
            padding: EdgeInsets.only(right: 100),
            child: Container(
              width: 100,
              child: ElevatedButton(
                //onPressed: (),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xffe4c2c1)),
                ),
                child: Text(
                  "강등",
                ),
              ),
            )
        ),
        Container(
            width: 100,
            child: (isAdmin) ? Container() :ElevatedButton(
              //onPressed: (),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffe4c2c1)),
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
