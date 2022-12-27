import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControllerServices {
  Stream<DatabaseEvent> getChatPreviews(String userId) {
    DatabaseReference chatsPreviewRef = FirebaseDatabase.instance.ref('chatPreview/users/$userId');
    return chatsPreviewRef.onValue;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocument(String userId) {
    final collectionRef = FirebaseFirestore.instance.collection('users');
    return collectionRef.doc(userId).get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    final collectionRef = FirebaseFirestore.instance.collection('users');
    return collectionRef.snapshots();
  }

  Future<void> updateUsersDocument(String userId, String name) {
    final userDocRef = FirebaseFirestore.instance.collection("users").doc(userId);
    return userDocRef.update({"firstLogin": false, "name": name});
  }
}

final controllerProvider= Provider<ControllerServices>((ref)=>ControllerServices());