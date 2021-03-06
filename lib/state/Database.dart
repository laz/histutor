import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/model/Subsession.dart';
import 'package:histutor/model/User.dart';
import 'package:histutor/model/Tutor.dart';
import 'package:histutor/model/Tutee.dart';
import 'package:histutor/model/ApplyingTutor.dart';

class Database {
  CollectionReference sessionReference = FirebaseFirestore.instance.collection('Sessions');

  CollectionReference userReference = FirebaseFirestore.instance.collection('Users');

  Stream<Session> getSession(int sessionIndex) {
    return sessionReference.doc(sessionIndex.toString()).snapshots().map((session) => Session.fromFirebase(session));
  }

  // order by?
  Stream<List<Session>> getSessions() {
    return sessionReference
        .orderBy('sessionIndex', descending: true)
        .snapshots()
        .map((sessions) => sessions.docs.map((session) => Session.fromFirebase(session)).toList());
  }

  // dispose?
  Stream<List<Participant>> getSessionParticipants(int sessionIndex) {
    return sessionReference
        .doc(sessionIndex.toString())
        .collection('Participants')
        .orderBy('entrance')
        .snapshots()
        .map((participants) => participants.docs.map((participant) => Participant.fromFirebase(participant)).toList());
  }

  Stream<List<Chat>> getSessionChats(int sessionIndex) {
    return sessionReference
        .doc(sessionIndex.toString())
        .collection('Chats')
        .orderBy('time', descending: true)
        .snapshots()
        .map((chats) => chats.docs.map((chat) => Chat.fromFirebase(chat)).toList());
  }

  // Use when logged in as admin
  Stream<List<User>> getUsers() {
    return userReference.snapshots().map((users) => users.docs.map((user) => User.fromFirebase(user)).toList());
  }

  Stream<List<Tutor>> getTutors() {
    return userReference.where("type", isEqualTo: "tutor").snapshots().map((users) => users.docs.map((user) => Tutor.fromFirebase(user)).toList());
  }

  Stream<List<Tutee>> getTutees() {
    return userReference.snapshots().map((users) => users.docs.map((user) => Tutee.fromFirebase(user)).toList());
  }

  Stream<List<Subsession>> getUserSessions(String studentId) {
    return userReference
        .doc(studentId)
        .collection('Sessions')
        .snapshots()
        .map((sessions) => sessions.docs.map((session) => Subsession.fromFirebase(session)).toList());
  }

  Stream<List<ApplyingTutor>> getApplyingTutorList() {
    return FirebaseFirestore.instance
        .collection('ApplyingTutors')
        .snapshots()
        .map((applyingTutorList) => applyingTutorList.docs.map((applyingTutor) => ApplyingTutor.fromFirebase(applyingTutor)).toList());
  }
}
