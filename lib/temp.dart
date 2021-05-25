import 'package:flutter/material.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/utils/authentication.dart';
import 'package:histutor/widgets/auth_dialog.dart';


class temp extends StatelessWidget {
  const temp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthDialog(),
    );
  }
}
