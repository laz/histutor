import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:histutor/model/Session.dart';
import 'package:histutor/model/Subsession.dart';
import 'package:histutor/model/Tutor.dart';
import 'package:histutor/model/Tutee.dart';
import 'package:histutor/model/User.dart' as model;
import 'package:histutor/model/ApplyingTutor.dart';

import 'package:histutor/state/Authentication.dart';
import 'package:histutor/state/Database.dart';

import 'package:provider/provider.dart';

import 'package:histutor/screens/homePage.dart';
import 'package:histutor/state/ApplicationState.dart';

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
        theme: ThemeData(
          fontFamily: 'BMJUA'
        ),
        home: Scaffold(
          backgroundColor: Color(0xff9BC7DA),
          body: LoginDialog(),
        ),
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
            StreamProvider<List<ApplyingTutor>>.value(
              value: Database().getApplyingTutorList(),
              catchError: (context, _) => null,
            ),
            ChangeNotifierProvider<ApplicationState>(
              create: (context) => ApplicationState(),
            )
          ],
          child: MaterialApp(
            theme: ThemeData(
              fontFamily: 'BMJUA'
            ),
              home: HomePage()
          ),
        );
      } else
        return Align(child: CircularProgressIndicator());
    }
  }
}

class LoginDialog extends StatelessWidget {
  const LoginDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: SingleChildScrollView(
          child: Container(
              height: 558.0,
              width: 385.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 540.0,
                    width: 368.0,
                    decoration: BoxDecoration(
                      color: Color(0xffEBEBEB),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment(0.0, 0.0),
                          width: 223,
                          height: 92,
                          child: Text(
                            "HISTUTOR",
                            textAlign: TextAlign.center,

                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 11)),
                        Container(
                          alignment: Alignment(0.0, 0.0),
                          height: 74,
                          width: 311,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/g.png',
                                width: 32,
                                height: 31,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(right: 15)),
                              DecoratedBox(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20),
                                    side: BorderSide(
                                        color: Color(0xffF4CACA),
                                        width: 45),
                                  ),
                                  color: Color(0xffF4CACA),
                                ),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: Color(0xffF4CACA),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20),
                                      side: BorderSide(
                                          color: Color(0xffF4CACA),
                                          width: 45),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () async {
                                    await Authentication()
                                        .signInWithGoogle(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 10, 0, 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 20),
                                          child: Text(
                                              'Sign in with Google',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontFamily:
                                                      'Quicksand')),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.only(
                                              bottomLeft:
                                                  Radius.circular(10.0),
                                              bottomRight:
                                                  Radius.circular(10.0),
                                              topLeft:
                                                  Radius.circular(10.0),
                                              topRight:
                                                  Radius.circular(10.0),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //padding: EdgeInsets.only(bottom: 50)
                          decoration: BoxDecoration(
                            color: const Color(0xffF4CACA),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
