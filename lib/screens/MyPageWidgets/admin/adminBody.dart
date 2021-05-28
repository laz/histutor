import 'package:flutter/material.dart';
import 'topButtons.dart';
import 'listPage.dart';

class AdminBody extends StatefulWidget {
  @override
  _AdminBodyState createState() => _AdminBodyState();
}

class _AdminBodyState extends State<AdminBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(125, 0, 145, 0),
        child:  Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
              child : TopButton(),
            ),
            bodyPage(),
          ],
        ),
      ),
    );
  }
}
Widget bodyPage(){
  return Container(
    width: 1167,
    height: 534,
    alignment: Alignment.topLeft,
    color: Color(0xffFFFFFF),
    child: ListPage(),
  );
}
