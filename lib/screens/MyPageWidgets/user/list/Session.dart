import 'package:flutter/material.dart';

class Sessions extends StatefulWidget {
  int idx;
  Sessions({
    this.idx
  });
  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
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
            child: Text("STATUS"),
          ),
          Container(
            width: 300,
            child: Text("방 이름"),
          ),
          Container(
              width: 100,
              child: Text("작성"),
            ),
          Container(
            width: 200,
            child: Text("작성일"),
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
          child: Text("종료"),
        ),
        Container(
          width: 300,
          child: Text("소프트웨어 공학 티에이세션"),
        ),
        Container(
          width: 100,
          child: Text("18김유영"),
        ),
        Container(
          width: 200,
          child: Text("2022-02-02"),
        ),
        Padding(
            padding: EdgeInsets.only(right: 100),
            child: Container(
              width: 100,
              child: ElevatedButton(
                //onPressed: (),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff9BC7DA)),
                ),
                child: Text(
                  "입장",
                ),
              ),
            )
        ),
      ],
    );
  }
}
