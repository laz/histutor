import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TutorApplying {
  final String name;
  final int studentId;


  TutorApplying({
    @required this.name,
    @required this.studentId,
  });

  factory TutorApplying.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    print("tutee" + data['email']);
    return TutorApplying(
      name: data['name'],
      studentId: data['studentId'],
    );
  }
}
