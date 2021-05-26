import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';

class Database {
  CollectionReference sessionReference =
      FirebaseFirestore.instance.collection('Sessions');

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
            .map((participant) => Participant.fromFirebase(participant)).toList());
  }

  Stream<List<Chat>> getSessionChats(int sessionIndex) {
    return sessionReference
        .doc(sessionIndex.toString())
        .collection('Chats')
        .snapshots()
        .map((chats) => chats.docs
          .map((chat) => Chat.fromFirebase(chat)).toList());
  }

  // Stream<QuerySnapshot> getSessions() {
  //   return sessionReference.snapshots();
  // }

  // Stream<QuerySnapshot> getSessionParticipantss(String sessionIndex) {
  //   return sessionReference
  //       .doc(sessionIndex)
  //       .collection('Participants')
  //       .snapshots();
  // }

  // Stream<QuerySnapshot> getSessionChats(String sessionIndex) {
  //   return sessionReference.doc(sessionIndex).collection('Chats').snapshots();
  // }

  // TODO: User

}
