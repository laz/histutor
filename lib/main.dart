import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:histutor/model/Session.dart';
import 'package:histutor/model/Subsession.dart';
import 'package:histutor/model/Tutor.dart';
import 'package:histutor/model/Tutee.dart';
import 'package:histutor/model/User.dart' as model;

import 'package:histutor/state/Authentication.dart';
import 'package:histutor/state/Database.dart';

import 'package:provider/provider.dart';


import 'package:histutor/screens/homePage.dart';
import 'package:histutor/state/ApplicationState.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  /*
  runApp(ChangeNotifierProvider<Authentication>(
    create: (context) => Authentication(),
    child: ChangeNotifierProvider<ApplicationState>(
      create: (context) => ApplicationState(),
      child: histutor(),
    ),*/

  runApp(MultiProvider(
    providers: [
      StreamProvider<List<Session>>.value(
        value: Database().getSessions(),
        catchError: (context, _) => null,
      ),
      StreamProvider<User>.value(
        value: Authentication().getAuth(),
        catchError: (context, _) => null,
      ),
    ],
    // child: MaterialApp(
    //   home: LoginPage(),
    // ),
    child: LoginPage(),
  ));
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User auth = Provider.of<User>(context);

    if (auth == null) {
      return MaterialApp(
        home: Container(
            alignment: Alignment.center,
            child: TextButton(
                child: Text('Google signin'),
                onPressed: () async {
                  await Authentication().signInWithGoogle();
                })),
      );
    } else {
      if (auth != null) {
        String studentId = auth.email.split('@')[0];
        return MultiProvider(
          providers: [
            StreamProvider<List<Tutor>>.value(
              value: Database().getTutors(),
              catchError: (context, _) => null,
            ),
            StreamProvider<List<Tutee>>.value(
              value: Database().getTutees(),
              catchError: (context, _) => null,
            ),
            StreamProvider<model.User>.value(
              value: Authentication().getUser(studentId),
              catchError: (context, _) => null,
            ),
            StreamProvider<List<Subsession>>.value(
              value: Database().getUserSessions(studentId),
              catchError: (context, _) => null,
            ),
            ChangeNotifierProvider<ApplicationState>(
              create: (context) => ApplicationState(),
            )
          ],
          child: MaterialApp(home: HomePage()),
        );
      } else
        return Align(child: CircularProgressIndicator());
    }
  }
}
