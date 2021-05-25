import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:histutor/utils/authentication.dart';

import 'mainboard.dart';



class makeRoom extends StatelessWidget {
  const makeRoom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Make Tutor Session Room',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.orange),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('세션 만들기')
        ),
        body: roomMaker(),
      )
    );
  }
}






class roomMaker extends StatefulWidget {
  const roomMaker({Key key}) : super(key: key);

  @override
  _roomMakerState createState() => _roomMakerState();
}

class _roomMakerState extends State<roomMaker> {
  final _sessionName = TextEditingController();
  final _offsession = TextEditingController();
  final _zoomlink = TextEditingController();
  String tutor_name = get_name();
  String stuId = get_stdId();
  DateTime _datetime = DateTime.now();
  DateTime _starttime = DateTime.now();
  DateTime _endtime = DateTime.now();
  String session_name = "";
  String type = "";
  //int count = 1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
          child: Container(
            height: 1000.0,
            width: 1000.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 400,
                  child: Column(

                children: [
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _sessionName,
                    decoration: InputDecoration(
                      labelText: '방이름',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value.length < 1) return '필수 항목입니다.';
                      return null;
                    },
                  ),
                   SizedBox(height: 10,),
                  TextFormField(
                    controller: _offsession,
                    decoration: InputDecoration(
                      labelText: '오프라인장소',
                      border: OutlineInputBorder(),
                    ),
                  ),
                   SizedBox(height: 10,),
                  TextFormField(
                    controller: _zoomlink,
                    decoration: InputDecoration(
                      labelText: '줌링크',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10,),
                        Text("시작 시각을 선택하세요."),
                      ],
                    )
                  ),

                  SizedBox(
                    height: 200,
                    width: 300,
                    child: CupertinoDatePicker(
                        initialDateTime:_starttime,
                        minimumDate: _datetime,
                        mode: CupertinoDatePickerMode.dateAndTime,
                        onDateTimeChanged: (datetime){
                          //print(_starttime);
                          setState(() {
                            _starttime = datetime;
                          });
                        }),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10,),
                          Text("끝나는 시각을 선택하세요."),
                        ],
                      )
                  ),
                  SizedBox(
                    height: 200,
                    width: 300,
                    child: CupertinoDatePicker(
                        initialDateTime: _endtime,
                        minimumDate: _datetime,
                        mode: CupertinoDatePickerMode.dateAndTime,
                        onDateTimeChanged: (datetime){
                          //print( _endtime);
                          setState(() {
                            _endtime = datetime;
                          });
                        }),
                  ),
                  RaisedButton(
                    child: Text("만들기"),
                    onPressed: () async {
                      //print("GET USR!");
                      FirebaseFirestore.instance.collection('Users').snapshots().listen((snapshot) {
                        snapshot.docs.forEach((document){
                          if(document.id == stdId){
                            //print(stdId);
                            type = document.data()['type'];
                          }
                      });
                      });

                      //디비에서 튜터인지 아닌지 확인
                      //if(tutee) alert() -> pop

                      if(type == "tutee"){
                        //print("TUTEE");
                        tutee_cannot_make_room(context);
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(
                            // fullscreenDialog: true,
                            builder: (context) => mainboard(),
                      ));
                      }
                      else{
                        //print("TUTOR");

                        Timestamp t_start = Timestamp.fromDate(_starttime);
                        Timestamp t_end = Timestamp.fromDate(_endtime);
                        FirebaseFirestore firestore = FirebaseFirestore.instance;
                        //print("COUNT!!!!");
                        int count = 0;
                        FirebaseFirestore.instance.collection('Sessions').get().then((snapshot) => {
                          count = snapshot.size.toInt(),
                        firestore.collection('Sessions').doc(count.toString()).set({
                        'category': "?",
                        'createTime' : Timestamp.fromDate(_datetime),
                        'sessionStart' : t_start,
                        'sessionEnd' : t_end,
                        'sessionIndex' : count,
                        'sessionName' : _sessionName.text,
                        'tutorName' : tutor_name,
                        'zoomLink' : _zoomlink.text,
                        'offline' : _offsession.text,
                        }),
                        });

                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(
                              // fullscreenDialog: true,
                              builder: (context) => mainboard(),
                            ));
                      }
                    },
                  )
              ],
                    
            )
                ),
              ],
            ),
          )
      ),
    );


    //   Container(
    //
    // );
  }
  @override
  void dispose(){
    _sessionName.dispose();
    _offsession.dispose();
    _zoomlink.dispose();
    super.dispose();
  }
}

void tutee_cannot_make_room(BuildContext context){
  var alert = AlertDialog(
    title: Text('오류'),
    content: Text('튜티는 튜터세션을 열 수 없습니다.'),
  );

  showDialog(context: context,builder: (BuildContext context){
    return alert;
  }
  );
}
