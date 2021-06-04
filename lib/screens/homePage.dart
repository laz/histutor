import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Color(0xfffef2f2),
      appBar: user != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(appHeight*0.1),
              child: (user.type == "admin") ? UserAppBar(isAdmin: true) : UserAppBar(isAdmin: false),
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(60.0),
              child: Align(child: Text("Loading Page")),
            ),
      body: user != null
          ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, appWidth*0.1, 0),
                  child: (user.type == "admin")
                      ? SizedBox(
                          height: 25,
                        )
                      : TopRightButton(),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(appWidth*0.1, 0, appWidth*0.1, 0),
                    child: Container(
                      color: Color(0xffEBEBEB),
                      width: appWidth * 0.8,
                      height: appHeight * 0.8,
                      child: (user.type == "admin") ? AdminBody() : UserBody(),
                    ))
              ],
            )
          : Align(
              alignment: Alignment.center, child: CircularProgressIndicator()),
    );
  }
}
