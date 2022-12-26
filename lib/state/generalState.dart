
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash/dtos/chatPreviewDto/chatPreviewDto.dart';
import 'package:dash/dtos/memberDto/memberDto.dart';
import 'package:dash/services/authService.dart';
import 'package:dash/services/controllerService.dart';
import 'package:dash/services/localStorageService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticationProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final localStorageProvider = Provider<LocalStorage>((ref){
  return LocalStorage();
});

final currentUserProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authStateChange;
});

final chatRoomsProvider = StreamProvider.autoDispose((ref){
  Stream<DatabaseEvent> stream = ref.watch(controllerProvider).getChatRooms();
  return stream.map((list) => list.snapshot.children.map((e) => ChatPreview.fromJson(Map<String, dynamic>.from(e.value as Map))).toList());
});

final getUserDocumentProvider = FutureProvider.family<Member, String>((ref, uid) async {
  Future<DocumentSnapshot> userDocument = ref.watch(controllerProvider).getUserDocument(uid);
  return userDocument.then((doc) {
    return Member.fromJson(doc.data() as Map<String, dynamic>);
  });
});

final getAllUsersProvider = StreamProvider.autoDispose((ref){
  Stream<QuerySnapshot<Map<String, dynamic>>> stream = ref.watch(controllerProvider).getAllUsers();
  return stream.map((list) => list.docs.map((doc) => Member.fromJson(doc.data())).toList());
});


final firestoreProvider = Provider.autoDispose<FirebaseFirestore>((ref){
  return FirebaseFirestore.instance;
});
