import 'package:flutter/material.dart';
import 'package:histutor/widgets/auth_dialog.dart';


class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xff9BC7DA),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthDialog(),
    );
  }
}
