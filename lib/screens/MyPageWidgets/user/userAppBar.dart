import 'package:flutter/material.dart';

class UserAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 35.0, 0.0, 0.0),
        child: TextButton(
          child: Text(
              "HISTUTOR",
              style: TextStyle(
              fontSize: 30,
              color: Colors.black
              ),
          ),
          //onPressed: (),
        ),
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}

