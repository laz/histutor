import 'package:flutter/material.dart';
import 'package:histutor/model/ApplyingTutor.dart';
import 'package:provider/provider.dart';

import 'package:histutor/screens/MyPageWidgets/admin/list/tutorStatus.dart';
import 'package:histutor/screens/MyPageWidgets/admin/list/tutorList.dart';
import 'package:histutor/screens/MyPageWidgets/admin/list/tuteeStatus.dart';
import 'package:histutor/screens/MyPageWidgets/admin/list/applyingTutorList.dart';


import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/model/Tutor.dart';
import 'package:histutor/model/Tutee.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Tutee> tuteeList = Provider.of<List<Tutee>>(context);
    List<Tutor> tutorList = Provider.of<List<Tutor>>(context);
    List<ApplyingTutor> applyingTutorList = Provider.of<List<ApplyingTutor>>(context);

    return Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Consumer<ApplicationState>(
          builder: (context, applicationState, _) {
            return selectAdminPageType(applicationState.selectedAdminPage,
                context, tutorList, tuteeList, applyingTutorList);
          },
        ));
  }
}

Widget selectAdminPageType(int selectedNum, BuildContext context,
    List<Tutor> tutorList, List<Tutee> tuteeList, List<ApplyingTutor> applyingTutorList) {
  switch (selectedNum) {
    case 0: // tutor status
      return (tutorList != null)
          ? ListView.separated(
              itemBuilder: (_, int index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: TutorList(
                    idx: index,
                    tutorList: tutorList,
                  ),
                );
              },
              separatorBuilder: (_, int index) => const Divider(),
              itemCount: tutorList.length + 1,
            )
          : Align(
              child: CircularProgressIndicator(),
            );
    case 1: // tutee status
      return (tuteeList != null)
          ? ListView.separated(
              itemBuilder: (_, int index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: TuteeStatus(
                    idx: index,
                    tuteeList: tuteeList,
                  ),
                );
              },
              separatorBuilder: (_, int index) => const Divider(),
              itemCount: tuteeList.length + 1,
            )
          : Align(
              child: CircularProgressIndicator(),
            );
    case 2: // tutor list
      return (tutorList != null)
          ? ListView.separated(
              itemBuilder: (_, int index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: TutorStatus(
                    idx: index,
                    tutorList: tutorList,
                  ),
                );
              },
              separatorBuilder: (_, int index) => const Divider(),
              itemCount: tutorList.length + 1,
            )
          : Align(
              child: CircularProgressIndicator(),
            );
    case 3: // tutor list
      return (tutorList != null)
          ? ListView.separated(
        itemBuilder: (_, int index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: ApplyingTutorList(
              idx: index,
              applyingTutorList: applyingTutorList,
            ),
          );
        },
        separatorBuilder: (_, int index) => const Divider(),
        itemCount: applyingTutorList.length + 1,
      )
          : Align(
        child: CircularProgressIndicator(),
      );
  }
}
