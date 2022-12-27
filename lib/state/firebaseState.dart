
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash/dtos/chatDto/chatDto.dart';
import 'package:dash/dtos/chatPreviewDto/chatPreviewDto.dart';
import 'package:dash/dtos/memberDto/memberDto.dart';
import 'package:dash/helpers/constants.dart';
import 'package:dash/services/authService.dart';
import 'package:dash/services/controllerService.dart';
import 'package:dash/state/localStorageState.dart';
import 'package:dash/state/userStateNotifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticationProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final currentUserProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authStateChange;
});

final chatPreviewsProvider = StreamProvider.autoDispose((ref){
  final userId = ref.read(currentUserProvider).value?.uid;
  Stream<DatabaseEvent> stream = ref.watch(controllerProvider).getChatPreviews(userId!);
  return stream.map((list) => list.snapshot.children.map((e) => ChatPreview.fromJson(Map<String, dynamic>.from(e.value as Map))).toList());
});

final fullChatProvider = StreamProvider.autoDispose.family<List<Chat>, String>((ref, chatId) {
  Stream<DatabaseEvent> stream = ref.watch(controllerProvider).getFullChat(chatId);
  return stream.map((list) => list.snapshot.children.map((e) => Chat.fromJson(Map<String, dynamic>.from(e.value as Map))).toList());
});

final getUserDocumentProvider = FutureProvider((ref) async {
  final userId = ref.read(currentUserProvider).value?.uid;
  final member = ref.read(memberProvider);
  if(member == null || userId != member.uid){
    DocumentSnapshot userDocument = await ref.watch(controllerProvider).getUserDocument(userId!);
    ref.read(memberProvider.notifier).newMember(Member.fromJson(userDocument.data() as Map<String, dynamic>));
    return Member.fromJson(userDocument.data() as Map<String, dynamic>);
  }
  return member;
});

final updateUserDocumentProvider = FutureProvider.family<void, String>((ref, name) async {
  final userId = ref.read(currentUserProvider).value?.uid;
  return await ref.read(controllerProvider).updateUsersDocument(userId!, name);
});

final getAllUsersProvider = StreamProvider.autoDispose((ref){
  Stream<QuerySnapshot<Map<String, dynamic>>> stream = ref.watch(controllerProvider).getAllUsers();
  return stream.map((list) => list.docs.map((doc) => Member.fromJson(doc.data())).toList());
});


final firestoreProvider = Provider.autoDispose<FirebaseFirestore>((ref){
  return FirebaseFirestore.instance;
});
