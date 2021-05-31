import 'package:flutter/material.dart';
import 'package:histutor/controller/SessionController.dart';
import 'package:histutor/model/Chat.dart';
import 'package:provider/provider.dart';

class Chatting extends StatelessWidget {
  final int sessionIndex;

  const Chatting({Key key, @required this.sessionIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(sessionIndex);
    List<Chat> chats = Provider.of<List<Chat>>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: chats != null
          ? ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chats[index].from),
                  subtitle: Text(chats[index].text),
                );
              },
            )
          : CircularProgressIndicator(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          SessionController().addChat(sessionIndex);
        },
      ),
    );
  }
}
