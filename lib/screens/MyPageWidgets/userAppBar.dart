import 'package:flutter/material.dart';

class UserAppBar extends StatelessWidget with PreferredSizeWidget {
  const UserAppBar({Key key, @required this.isAdmin}) : super(key: key);
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 35.0, 0.0, 0.0),
        child: Row(children: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Text(
              'HISTUTOR',
              style: TextStyle(fontSize: 30, color: Colors.black),
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
                color: Color(0xffEFF4CC),
              ),
            )
        ]),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
