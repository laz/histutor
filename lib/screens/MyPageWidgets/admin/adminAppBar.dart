import 'package:flutter/material.dart';
class AdminAppBar extends StatelessWidget with PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 35.0, 0.0, 0.0),
        child: Row(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
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
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    " admin ",
                    style: TextStyle(
                        color: Colors.black
                    ),
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
          ],
        ),
      )
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
