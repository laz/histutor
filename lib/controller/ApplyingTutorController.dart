
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ApplyingTutorController extends ChangeNotifier {

  void acceptTutorApplying(String id, bool isAccept) {
    if(isAccept){
      FirebaseFirestore.instance
          .collection('Users')
          .doc(id)
          .update({
        "tutorTime": 0,
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