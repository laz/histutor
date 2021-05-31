import 'package:flutter/material.dart';
<<<<<<< HEAD
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
=======

class nicknameChangePage extends StatefulWidget {
  @override
  _nicknameChangePageState createState() => _nicknameChangePageState();
}

class _nicknameChangePageState extends State<nicknameChangePage> {

  @override
  Widget build(BuildContext context) {
    var nicknameController = TextEditingController();
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
    return Padding(
        padding: EdgeInsets.fromLTRB(50, 70, 0, 0),
        child: Column(
          children: [
            Row(
              children: [
                Text("닉네임: "),
<<<<<<< HEAD
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
=======
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
>>>>>>> 9fba2dda9e8fc772f45301575cb52ddc555bb08f
          ],
        )
    );
  }
}
