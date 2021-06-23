import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserController extends ChangeNotifier {
  void changeUserName(String id, String nickname) {
    FirebaseFirestore.instance.collection('Users').doc(id).update({
      'nickname': nickname,
    });
  }

  void updateNewUser(String id, String nickname, int studentId) {
    FirebaseFirestore.instance.collection('Users').doc(id).update({
      'nickname': nickname,
      'studentId': studentId,
      'isNew': false,
    });
  }

  void changeUserType(String id, String type) {
    FirebaseFirestore.instance.collection('Users').doc(id).update({
      'type': type,
    });
  }
}
