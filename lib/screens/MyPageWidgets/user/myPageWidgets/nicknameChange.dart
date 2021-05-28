import 'package:flutter/material.dart';

class nicknameChangePage extends StatefulWidget {
  @override
  _nicknameChangePageState createState() => _nicknameChangePageState();
}

class _nicknameChangePageState extends State<nicknameChangePage> {

  @override
  Widget build(BuildContext context) {
    var nicknameController = TextEditingController();
    return Padding(
        padding: EdgeInsets.fromLTRB(50, 70, 0, 0),
        child: Column(
          children: [
            Row(
              children: [
                Text("닉네임: "),
              ] ,
            ),
                /*Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                  child: Container(
                      margin: EdgeInsets.all(8),
                      child:TextField(
                        controller: nicknameController,
                      )
                  ),
                )

            ),
            FloatingActionButton(
              child: Text("변경하기"),
              //onPressed: ()
            )*/
          ],
        )
    );
  }
}
