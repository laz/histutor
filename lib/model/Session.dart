
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Session {
  final int sessionIndex;
  final String tutorName;
  final String sessionName;
  final String category;
  final DateTime sessionStart;
  final DateTime sessionEnd;
  Timestamp createdTime;

  Session({
    @required this.sessionIndex,
    @required this.tutorName,
    @required this.sessionName,
    @required this.sessionStart,
    @required this.sessionEnd,
    @required this.category,
    @required this.createdTime,
  });
}