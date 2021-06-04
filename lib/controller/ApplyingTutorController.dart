
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:provider/provider.dart';

class TutorApplyingController extends ChangeNotifier {

  void acceptTutorApplying(String userId, bool isAccept) {
    if(isAccept){
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .update({
        "type": "tutor",
      });
    }
    FirebaseFirestore.instance
          .collection('ApplyingTutors')
          .doc(userId)
          .delete();
  }

  void applyingTutor(String userId, String name){
    FirebaseFirestore.instance
        .collection('ApplyingTutors')
        .doc(userId)
        .set({
      "name": name,
      "studentId" : userId,
    });
  }
}