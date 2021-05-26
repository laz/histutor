
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';

import 'makeRoom.dart';

class mainboard extends StatelessWidget {
  const mainboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.orange),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('mainboard')
        ),
        body: See_Board(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () =>
              Navigator.push(context,
            MaterialPageRoute(
              // fullscreenDialog: true,
              builder: (context) => new makeRoom(),
            ),
          )
        ),
      ),
    );
  }
}

//적당하게 불러와서 보이게 하기
class See_Board extends StatefulWidget {
  const See_Board({Key key}) : super(key: key);

  @override
  _See_BoardState createState() => _See_BoardState();
}

class _See_BoardState extends State<See_Board> {
  @override
  int room_n = 0;


  Widget build(BuildContext context) {
    return Container(
      height: 1000.0,
      width: 1000.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(room_n.toString()),
        ],
      ),
    );
  }

void get_room_number() async {
    int count = 0;
    await FirebaseFirestore.instance.collection('Sessions').get().then((snapshot) => {
      count = snapshot.size.toInt(),
      print(count.toString()),
    });
    print("after");
    print(count.toString());
    room_n = count;
  }
}




void get_room(){




  // FirebaseFirestore.instance.collection('Users').snapshots().listen((snapshot) {
  // snapshot.docs.forEach((document){
  // if(document.id == stdId){
  // //print(stdId);
  // type = document.data()['type'];
  // }
  // });
  // });
}
