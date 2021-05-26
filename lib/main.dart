import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:histutor/histutor.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/model/Subsession.dart';
import 'package:histutor/state/Authentication.dart';
import 'package:histutor/state/Database.dart';
import 'package:provider/provider.dart';
import 'package:histutor/model/User.dart' as model;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
            StreamProvider<model.User>.value(
              value: Authentication().getUser(studentId),
              catchError: (context, _) => null,
            ),
            StreamProvider<List<Subsession>>.value(
              value: Database().getUserSessions(studentId),
              catchError: (context, _) => null,
            ),
          ],
          child: MaterialApp(home: histutor()),
        );
      } else
        return CircularProgressIndicator();
    }
  }
}
