import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserController extends ChangeNotifier {
  void changeUserName(String userId, String name) {
    FirebaseFirestore.instance.collection('Users').doc(userId).update({
      "name": name,
      'isNew': false,
    });
  }

  void changeUserType(String userId, String type) {
    FirebaseFirestore.instance.collection('Users').doc(userId).update({
      "type": type,
    });
  }
}
