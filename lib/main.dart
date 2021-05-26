import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:histutor/controller/SessionController.dart';
import 'package:histutor/histutor.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/state/Authentication.dart';

import 'package:provider/provider.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider<Authentication>(
    create: (context) => Authentication(),
    child: ChangeNotifierProvider<ApplicationState>(
      create: (context) => ApplicationState(),
      child: histutor(),
    ),
  ));
}
