
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat {
  final String text;
  final String from;
  Timestamp time;

  Chat({
    @required this.text,
    @required this.from,
  });
}