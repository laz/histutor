import 'package:flutter/material.dart';
import 'package:histutor/screens/MyPageWidgets/admin/list/tutorStatus.dart';
import 'list/tutorList.dart';
import 'list/tuteeStatus.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/state/Authentication.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Consumer<ApplicationState>(
        builder: (context, applicationState, _){
          return selectAdminPageType(applicationState.selectedAdminPage);
        },
      )
    );
  }
}
Widget selectAdminPageType(int selectedNum){
  switch(selectedNum){
    case 0: // tutor status
      return ListView.separated(
          itemBuilder: ( _, int index){
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: TutorList(idx: index),
            );
          },
          separatorBuilder: (_, int index) => const Divider(),
          itemCount: 11
      );
    case 1: // tutee status
      return ListView.separated(
          itemBuilder: ( _, int index){
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: TuteeStatus(idx: index),
            );
          },
          separatorBuilder: (_, int index) => const Divider(),
          itemCount: 11
      );
    case 2: // tutor list
      return ListView.separated(
          itemBuilder: ( _, int index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: TutorStatus(idx: index),
            );
          },
          separatorBuilder: (_, int index) => const Divider(),
          itemCount: 11
      );
  }
}
