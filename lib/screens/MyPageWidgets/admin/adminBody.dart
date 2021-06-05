import 'package:flutter/material.dart';
import 'topButtons.dart';
import 'listPage.dart';

class AdminBody extends StatelessWidget {
  const AdminBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TopButton(),
                ),
              ),
              bodyPage(context),
            ],
          ),
      ),
    );
  }
}

Widget bodyPage(BuildContext context) {
  return Container(
    width: 1167,
    height: (MediaQuery.of(context).size.height-180)*0.9,
    alignment: Alignment.topLeft,
    color: Color(0xffFFFFFF),
    child: ListPage(),
  );
}
