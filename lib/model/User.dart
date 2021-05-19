
import 'package:flutter/material.dart';

class User {
  final String name;
  final int studentId;
  final String email;
  final int time;
  final String type;

  User({
    @required this.name,
    @required this.studentId,
    @required this.email,
    @required this.time,
    @required this.type,
  });
}