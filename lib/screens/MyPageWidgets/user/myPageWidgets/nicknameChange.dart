import 'package:flutter/material.dart';
import 'package:histutor/model/User.dart';
import 'package:provider/provider.dart';
import 'package:histutor/controller/UserController.dart';

class NicknameChangePage extends StatelessWidget {
  const NicknameChangePage({Key key}) : super(key: key);

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
                SizedBox(
                  width:100,
                ),
                Text("닉네임: ",
                    style: TextStyle(
                      fontSize: 18,
                    )
                ),
                Container(
                  width: 200,
                  child: TextField(
                    controller: nicknameController,
                  ),
                ),
                FloatingActionButton(
                    child: Text("변경하기"),
                    onPressed: () {
                      UserController().chageUserName(
                          user.studentId.toString(), nicknameController.text);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            content: Text(
                                "닉네임이 변경되었습니다:)"),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Text("확인"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    })
              ],

            ),

          ],
        ));
  }
}
