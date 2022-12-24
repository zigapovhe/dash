import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControllerServices {
  Stream<DatabaseEvent> getChatRooms() {
    DatabaseReference chatsPreviewRef = FirebaseDatabase.instance.ref('chats/');
    return chatsPreviewRef.onValue;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocument(String userId) async {
    final collectionRef = FirebaseFirestore.instance.collection('users');
    return await collectionRef.doc(userId).get();
  }
}

final controllerProvider= Provider<ControllerServices>((ref)=>ControllerServices());