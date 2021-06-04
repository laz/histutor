
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/model/User.dart';
import 'package:histutor/model/User.dart' as model;
import 'package:histutor/state/Database.dart';

class ApplicationState extends ChangeNotifier {
  bool isAdmin = false;
  int selectedPage = 1;
  int selectedAdminPage = 0;
  int selectedMyPage = 0;

  // function prototypes
  void changeSelectedPage(int num){
    selectedPage = num;
    notifyListeners();
  }
  void changeSelectedAdminPage(int num){
    selectedAdminPage = num;
    notifyListeners();
  }
  void changeSelectedMyPage(int num){
    selectedMyPage = num;
    notifyListeners();
  }
}
