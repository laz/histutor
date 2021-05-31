import 'package:flutter/material.dart';
import 'package:histutor/model/User.dart';
import 'package:provider/provider.dart';
import 'package:histutor/controller/UserController.dart';

class NicknameChangePage extends StatefulWidget {
  @override
  _NicknameChangePageState createState() => _NicknameChangePageState();
}

class _NicknameChangePageState extends State<NicknameChangePage> {

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    var nicknameController = TextEditingController(text: user.name);
    return Padding(
        padding: EdgeInsets.fromLTRB(50, 70, 0, 0),
        child: Column(
          children: [
            Row(
              children: [
                Text("닉네임: "),
                Container(
                  width: 200,
                    child: TextField(
                      controller: nicknameController,
                    ),
                ),
              ] ,
            ),
            FloatingActionButton(
              child: Text("변경하기"),
              onPressed: (){
                UserController().chageUserName(user.studentId.toString(), nicknameController.text);
              }
            )
          ],
        )
    );
  }
}
