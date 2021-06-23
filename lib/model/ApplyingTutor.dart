import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApplyingTutor {
  final String nickname;
  final int studentId;
  final String id;

  ApplyingTutor({
    @required this.nickname,
    @required this.studentId,
    @required this.id,
  });

  factory ApplyingTutor.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return ApplyingTutor(
      nickname: data['nickname'],
      studentId: data['studentId'],
      id: data['id'],
    );
  }
}
