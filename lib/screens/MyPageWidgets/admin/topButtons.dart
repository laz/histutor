import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:provider/provider.dart';

class TopButton extends StatefulWidget {
  const TopButton({Key key}) : super(key: key);

  @override
  _TopButtonState createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
  DateTime start;
  DateTime end;

  @override
  Widget build(BuildContext context) {
    ApplicationState applicationState = Provider.of<ApplicationState>(context);

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
          child: ElevatedButton(
              onPressed: () {
                applicationState.changeSelectedAdminPage(0);
              },
              style: ButtonStyle(
                backgroundColor: applicationState.selectedAdminPage == 0
                    ? MaterialStateProperty.all<Color>(Color(0xffe4c2c1))
                    : MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text(
                "튜터 목록",
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
          child: ElevatedButton(
              onPressed: () {
                applicationState.changeSelectedAdminPage(1);
                applicationState.changeSelectedTime(start, end);
              },
              style: ButtonStyle(
                backgroundColor: applicationState.selectedAdminPage == 1
                    ? MaterialStateProperty.all<Color>(Color(0xffe4c2c1))
                    : MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text(
                "튜티 현황",
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
          child: ElevatedButton(
            onPressed: () {
              applicationState.changeSelectedAdminPage(2);
              applicationState.changeSelectedTime(start, end);
            },
            style: ButtonStyle(
              backgroundColor: applicationState.selectedAdminPage == 2
                  ? MaterialStateProperty.all<Color>(Color(0xffe4c2c1))
                  : MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Text(
              "튜터 현황",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
          child: ElevatedButton(
            onPressed: () {
              applicationState.changeSelectedAdminPage(3);
            },
            style: ButtonStyle(
              backgroundColor: applicationState.selectedAdminPage == 3
                  ? MaterialStateProperty.all<Color>(Color(0xffe4c2c1))
                  : MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Text(
              "튜터 신청 목록",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 10.0, 0),
          child: TextButton(
            onPressed: () => _selectDate(context, true),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined),
                SizedBox(width: 5.0),
                Text(
                  start == null ? "Start Time" : DateFormat('yyyy-MM-dd').format(start),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(' ~ '),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 15.0, 0),
          child: TextButton(
            onPressed: () => _selectDate(context, false),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined),
                SizedBox(width: 5.0),
                Text(
                  end == null ? "End Time" : DateFormat('yyyy-MM-dd').format(end),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, bool startOrEnd) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null)
      setState(() {
        if(startOrEnd) start = pickedDate;
        else end = pickedDate;
      });
  }
}
