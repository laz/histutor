import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:histutor/screens/MyPageWidgets/admin/list/tutorStatus.dart';
import 'list/tutorList.dart';
import 'list/tuteeStatus.dart';

import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/state/Authentication.dart';
import 'package:histutor/state/Database.dart';

import 'package:histutor/model/Tutor.dart';
import 'package:histutor/model/Tutee.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  Widget build(BuildContext context) {
    List<Tutee> tuteeList = Provider.of<List<Tutee>>(context);
    List<Tutor> tutorList = Provider.of<List<Tutor>>(context);


    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child:
      Consumer<ApplicationState>(
        builder: (context, applicationState, _){
           return selectAdminPageType(applicationState.selectedAdminPage, context, tutorList, tuteeList);
        },
      )
    );
  }
}

Widget selectAdminPageType(int selectedNum, BuildContext context, List<Tutor> tutorList, List<Tutee> tuteeList){
  switch(selectedNum){
    case 0: // tutor status
      return (tutorList != null) ?
        ListView.separated(
          itemBuilder: ( _, int index){
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: TutorList(idx: index, tutorList: tutorList,),
            );},
          separatorBuilder: (_, int index) => const Divider(),
          itemCount: tutorList.length + 1,
        ) : Align(child: CircularProgressIndicator(),);
    case 1: // tutee status
      return (tuteeList != null) ?
        ListView.separated(
          itemBuilder: (_, int index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: TuteeStatus(idx: index, tuteeList: tuteeList,),
            );},
          separatorBuilder: (_, int index) => const Divider(),
          itemCount: tuteeList.length + 1,
        ) : Align(child: CircularProgressIndicator(),);
    case 2: // tutor list
      return (tutorList != null) ?
        ListView.separated(
          itemBuilder: ( _, int index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: TutorStatus(idx: index, tutorList: tutorList,),
            );},
          separatorBuilder: (_, int index) => const Divider(),
          itemCount: tutorList.length + 1,
        ) : Align(child: CircularProgressIndicator(),);
  }
}
