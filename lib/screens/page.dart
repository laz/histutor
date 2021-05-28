import 'package:flutter/material.dart';

import 'MyPageWidgets/admin/adminAppBar.dart';
import 'MyPageWidgets/admin/adminBody.dart';

import 'MyPageWidgets/user/userAppBar.dart';
import 'MyPageWidgets/user/userBody.dart';
import 'MyPageWidgets/user/topRightButtons.dart';

import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/state/Authentication.dart';
import 'package:provider/provider.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //bool isTutor = false;
    return Consumer<ApplicationState>(
      builder: (context, applicationState, _){
        return Scaffold(
            backgroundColor: Color(0xff9BC7DA),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
              child: (applicationState.isAdmin) ? AdminAppBar() : UserAppBar(),
            ),
            body:Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(1141, 20, 0, 0),
                  child: (applicationState.isAdmin) ? SizedBox(height: 25,) :TopRightButton(),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(26, 0, 29, 0),
                    child: Container(
                      color: Color(0xffEBEBEB),
                      width: 1385,
                      height: 672,
                      child: (applicationState.isAdmin) ? AdminBody() : UserBody(),
                    )
                )
              ],
            )
        );
      },
    );

  }
}
