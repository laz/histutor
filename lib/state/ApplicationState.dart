import 'package:flutter/material.dart';

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
