import 'package:flutter/material.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Subsession.dart';
import 'package:provider/provider.dart';

import 'model/User.dart';

class Mypage extends StatelessWidget {
  const Mypage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Subsession> sessions = Provider.of<List<Subsession>>(context);
    User user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(user.email),
      ),
      body: sessions != null
          ? ListView.builder(
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sessions[index].sessionName),
                  subtitle: Text(sessions[index].tutorName),
                );
              },
            )
          : CircularProgressIndicator(),
      // body: Text(user.name),
    );
  }
}
