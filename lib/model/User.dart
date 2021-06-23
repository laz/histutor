import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String nickname;
  final int studentId;
  final String id;
  final String email;
  final int time;
  final String type;
  final String uid;
  final bool isNew;

  User({
    @required this.nickname,
    @required this.studentId,
    @required this.id,
    @required this.email,
    @required this.time,
    @required this.type,
    @required this.uid,
    @required this.isNew,
  });

  factory User.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return User(
      nickname: data['nickname'],
      email: data['email'],
      studentId: data['studentId'],
      id: data['id'],
      time: data['time'],
      type: data['type'],
      uid: data['uid'],
      isNew: data['isNew'],
    );
  }
}
