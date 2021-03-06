import 'package:flutter/material.dart';
import 'package:histutor/controller/ApplyingTutorController.dart';
import 'package:histutor/model/ApplyingTutor.dart';

class ApplyingTutorList extends StatelessWidget {
  const ApplyingTutorList({Key key, @required this.idx, @required this.applyingTutorList})
      : super(key: key);
  final int idx;
  final List<ApplyingTutor> applyingTutorList;

  @override
  Widget build(BuildContext context) {
    if (idx == 0) {
      return Row(
        children: [
          Container(
            width: 100,
            child: Text("NO.",
                style:TextStyle(
                  fontSize: 18,
                )),
          ),
          Container(
            width: 200,
            child: Text("튜터",
                style:TextStyle(
                  fontSize: 18,
                )),
          ),
          Container(
            width: 400,
            child: Text("학번",
                style:TextStyle(
                  fontSize: 18,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(right: 100),
            child: Container(
              width: 100,
              child: Text("튜터 허락",
                  style:TextStyle(
                    fontSize: 18,
                  )),
            ),
          ),
          Container(
            width: 100,
            child: Text("튜터 불허",
                style:TextStyle(
                  fontSize: 18,
                )),
          )
        ],
      );
    }
    return Row(
      children: [
        Container(
          width: 100,
          child: Text(idx.toString()),
        ),
        Container(
          width: 200,
          child: Text(applyingTutorList[idx - 1].nickname.toString()),
        ),
        Container(
          width: 400,
          child: Text(applyingTutorList[idx - 1].studentId.toString()),
        ),
        Padding(
            padding: EdgeInsets.only(right: 100),
            child: Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  ApplyingTutorController().acceptTutorApplying(
                      applyingTutorList[idx - 1].id, true);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xffe4c2c1)),
                ),
                child: Text(
                  "허  락",
                ),
              ),
            )),
        Container(
            width: 100,
            child: ElevatedButton(
              onPressed: ()  {
                ApplyingTutorController().acceptTutorApplying(
                    applyingTutorList[idx - 1].id, false);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffe4c2c1)),
              ),
              child: Text(
                "불  허",
              ),
            )),
      ],
    );
  }
}
