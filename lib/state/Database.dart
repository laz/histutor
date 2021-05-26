import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/model/Subsession.dart';
import 'package:histutor/model/User.dart';

class Database {
  CollectionReference sessionReference =
      FirebaseFirestore.instance.collection('Sessions');

  CollectionReference userReference =
      FirebaseFirestore.instance.collection('Users');

  // order by?
  Stream<List<Session>> getSessions() {
    return sessionReference.snapshots().map((sessions) =>
        sessions.docs.map((session) => Session.fromFirebase(session)).toList());
  }

  // dispose?
  Stream<List<Participant>> getSessionParticipants(int sessionIndex) {
    return sessionReference
        .doc(sessionIndex.toString())
        .collection('Participants')
        .snapshots()
        .map((participants) => participants.docs
            .map((participant) => Participant.fromFirebase(participant))
            .toList());
  }

  Stream<List<Chat>> getSessionChats(int sessionIndex) {
    return sessionReference
        .doc(sessionIndex.toString())
        .collection('Chats')
        .snapshots()
        .map((chats) =>
            chats.docs.map((chat) => Chat.fromFirebase(chat)).toList());
  }

  // Use when logged in as admin
  Stream<List<User>> getUsers(int studentId) {
    return userReference.snapshots().map(
        (users) => users.docs.map((user) => User.fromFirebase(user)).toList());
  }

  Stream<List<Subsession>> getUserSessions(String studentId) {
    return userReference.doc(studentId).collection('Sessions').snapshots().map(
        (sessions) => sessions.docs
            .map((session) => Subsession.fromFirebase(session))
            .toList());
  }

  // TODO: User

}
