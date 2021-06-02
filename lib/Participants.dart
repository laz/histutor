import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:histutor/controller/SessionController.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/state/Database.dart';
import 'package:provider/provider.dart';

class Participants extends StatelessWidget {
  final int sessionIndex;

  const Participants({Key key, @required this.sessionIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(sessionIndex);
    List<Participant> participants = Provider.of<List<Participant>>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pariticpants'),
      ),
      body: participants != null
          ? ListView.builder(
              itemCount: participants.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(participants[index].studentId.toString()),
                  // ternary op to ensure not null for every field value?????
                  subtitle: participants[index].entrance != null
                      ? Text('${participants[index].entrance.toDate().toString()}')
                      : Text(''),
                );
              },
            )
          : CircularProgressIndicator(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          SessionController().addParticipant(sessionIndex);
        },
      ),
    );
  }
}
