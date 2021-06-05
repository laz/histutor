import 'package:flutter/material.dart';
import 'package:histutor/model/User.dart';

class UserAppBar extends StatelessWidget with PreferredSizeWidget {
  const UserAppBar({Key key, @required this.isAdmin, @required this.user}) : super(key: key);
  final bool isAdmin;
  final User user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isAdmin ? Color(0xffe4c2c1) : Color(0xECBEE0FF),
      centerTitle: false,
      actions: [
        Row(

          children: [
            Container(
                padding: EdgeInsets.fromLTRB(5, 27, 10, 0),
                child: Text(user.type,
                style: TextStyle(fontSize: 20),)),
            Container(
              padding: EdgeInsets.fromLTRB(5, 17, 30, 0),
                child: Text(user.name, style: TextStyle(fontSize: 32),)
            ),
          ],
        )
      ],
      title: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 13.0, 0.0, 0.0),
        child: Row(children: [
          Padding(
           padding: EdgeInsets.only(right: 10.0),
            child:
            Container(
              padding: EdgeInsets.all(4.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.white, width: 2.0)),
              child: Text(
                'HISTUTOR',
                style: TextStyle(fontSize: 32, color: Colors.black),
              ),
            ),
          ),
          if (isAdmin)
            Container(
              child: Row(
                children: [
                  Text(
                    ' admin ',
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(
                    Icons.admin_panel_settings_outlined,
                    color: Colors.black,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xffe4c2c1),
              ),
            )
        ]),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
