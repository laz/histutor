import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tutee {
  final String name;
  final String id;
  final String email;
  final int tuteeTime;
  final String type;

  Tutee({
    @required this.name,
    @required this.id,
    @required this.email,
    @required this.tuteeTime,
    @required this.type,
  });

  factory Tutee.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return Tutee(
      name: data['nickname'],
      email: data['email'],
      id: data['id'],
      tuteeTime: data['tuteeTime'],
      type: data['type'],
    );
  }
}
