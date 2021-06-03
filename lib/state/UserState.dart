
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histutor/model/User.dart';

class UserState {
  User _user;
  User get user => _user;

  Stream<User> getUser(int studentId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(studentId.toString())
        .snapshots()
        .map((user) => User.fromFirebase(user));
  }
  
  Future<void> setUserById(String id) {
    // _user = FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(id)

  }
}