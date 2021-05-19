import 'package:flutter/material.dart';
import 'package:histutor/histutor.dart';
import 'package:histutor/state/ApplicationState.dart';
import 'package:histutor/state/Authentication.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<Authentication>(
      create: (context) => Authentication(),
      child: ChangeNotifierProvider<ApplicationState>(
        create: (context) => ApplicationState(),
        child: histutor(),
      ),
    )
  );
}

