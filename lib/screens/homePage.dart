import 'package:flutter/material.dart';
import 'package:histutor/controller/UserController.dart';
import 'package:histutor/screens/MyPageWidgets/userAppBar.dart';
import 'MyPageWidgets/admin/adminBody.dart';
import 'MyPageWidgets/user/userBody.dart';
import 'MyPageWidgets/user/topRightButtons.dart';
import 'package:provider/provider.dart';
import 'package:histutor/model/User.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    double appWidth = MediaQuery.of(context).size.width;
    double appHeight = MediaQuery.of(context).size.height;
    final nameController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: user != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: (user.type == "admin")
                  ? UserAppBar(isAdmin: true, user: user)
                  : UserAppBar(
                      isAdmin: false,
                      user: user,
                    ),
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Align(child: Text("Loading Page")),
            ),
      body: user != null
          ? user.isNew
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('학번 이름 형태로 닉네임을 입력해주세요!'),
                    Text('예시: 21 김개똥'),
                    Padding(
                      padding: EdgeInsets.fromLTRB((appWidth - 200) * 0.5, 0, (appWidth - 200) * 0.5, (appHeight - 130) * 0.05),
                      child: Container(
                        width: 200,
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(labelText: '닉네임'),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Text('등록'),
                      onPressed: () {
                        UserController().changeUserName(user.studentId.toString(), nameController.text);
                      },
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 20, appWidth * 0.1, 0),
                      child: (user.type == "admin")
                          ? SizedBox(
                              height: 30,
                            )
                          : TopRightButton(),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(appWidth * 0.02, 0, appWidth * 0.02, (appHeight - 130) * 0.05),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.grey.shade200,
                          width: appWidth * 0.9,
                          height: (appHeight - 130) * 0.95,
                          child: (user.type == "admin") ? AdminBody() : UserBody(),
                          //   ),
                          // ),
                        ))
                  ],
                )
          : Align(alignment: Alignment.center, child: CircularProgressIndicator()),
    );
  }
}
