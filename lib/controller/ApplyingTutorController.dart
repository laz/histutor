
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:provider/provider.dart';

class ApplyingTutorController extends ChangeNotifier {

  void acceptTutorApplying(String id, bool isAccept) {
    if(isAccept){
      FirebaseFirestore.instance
          .collection('Users')
          .doc(id)
          .update({
        "type": "tutor",
      });
    }
    FirebaseFirestore.instance
          .collection('ApplyingTutors')
          .doc(id)
          .delete();
  }

  void applyingTutor(String id, String nickname, int studentId){
    FirebaseFirestore.instance
        .collection('ApplyingTutors')
        .doc(id)
        .set({
      "nickname": nickname,
      "studentId" : studentId,
      'id': id,
    });
  }
}