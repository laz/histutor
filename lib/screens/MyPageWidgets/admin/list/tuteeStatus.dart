import 'package:flutter/material.dart';
import 'package:histutor/model/Tutee.dart';
import 'package:histutor/screens/MyPageWidgets/admin/list/excelFile.dart';

class TuteeStatus extends StatelessWidget {
  const TuteeStatus({Key key, @required this.idx, @required this.tuteeList})
      : super(key: key);

  final List<Tutee> tuteeList;
  final int idx;

  @override
  Widget build(BuildContext context) {
    if (idx == 0) {
      return Row(
        children: [
          Container(
            width: 100,
            child: Text("NO.",
                style: TextStyle(
                  fontSize: 18,
                )),
          ),
          Container(
            width: 800,
            child: Text("튜티",
                style: TextStyle(
                  fontSize: 18,
                )),
          ),
          Container(
            width: 100,
            child: Text("시간(분)",
                style: TextStyle(
                  fontSize: 18,
                )),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                color: Colors.grey,
                width: 2,
            )),
            width: 100,
            child: TextButton(
              onPressed: (){
                makeExcelFile().createExcelTutee(tuteeList);
              },
                child: Text("Make File",
                    style: TextStyle(
                      fontSize: 18,
                    ))),
          )
        ],
      );
    } else
      return Row(
          children: tuteeList[idx - 1].tuteeTime > 0
              ? [
                  Container(
                    width: 100,
                    child: Text(idx.toString()),
                  ),
                  Container(
                    width: 800,
                    child: Text(tuteeList[idx - 1].name),
                  ),
                  Container(
                    width: 100,
                    child: Text(tuteeList[idx - 1].tuteeTime.toString()),
                  ),
                ]
              : []);
  }
}
