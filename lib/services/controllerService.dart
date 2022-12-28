import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash/dtos/chatPreviewDto/chatPreviewDto.dart';
import 'package:dash/dtos/memberDto/memberDto.dart';
import 'package:firebase_database/firebase_database.dart' as RTDB;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControllerServices {
  Stream<RTDB.DatabaseEvent> getChatPreviews(String userId) {
    RTDB.DatabaseReference chatsPreviewRef = RTDB.FirebaseDatabase.instance.ref('chatPreview/users/$userId');
    return chatsPreviewRef.onValue;
  }

  Stream<RTDB.DatabaseEvent> getFullChat(String chatId) {
    RTDB.Query fullChatRef = RTDB.FirebaseDatabase.instance.ref('full_chats/$chatId').orderByChild("timestamp");
    return fullChatRef.onValue;
  }

  Future<RTDB.DataSnapshot> createChat(List<Member> selectedMembers, String currentUserId) async {
    String chatId = RTDB.FirebaseDatabase.instance.ref('full_chats').push().key!;

    await Future.wait([
      for (int i=0; i<selectedMembers.length; i++)
        _createPreviewChatsAsynchronously(selectedMembers, selectedMembers[i], chatId),
    ]);

    return RTDB.FirebaseDatabase.instance.ref('chatPreview/users/$currentUserId/$chatId').get();
  }

  Future<void> _createPreviewChatsAsynchronously(List<Member> selectedMembers, Member member, String chatId) async {
    RTDB.DatabaseReference chatsPreviewRef = RTDB.FirebaseDatabase.instance.ref('chatPreview/users/${member.uid}/$chatId');
    chatsPreviewRef.set({
      'chatId': chatId,
      'lastMessage': '',
      'readStatus': 3,
      'timestamp': RTDB.ServerValue.timestamp,
      'title': selectedMembers.where((e) => e.uid != member.uid).map((e) => e.name).toList().join(', '),
    });
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