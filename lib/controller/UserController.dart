
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:provider/provider.dart';

class UserController extends ChangeNotifier {

  void chageUserName(String userId, String name) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .update({
      "name": name,
    });
  }

  void changeUserType(String userId, String type){
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .update({
      "type": type,
    });
  }
}