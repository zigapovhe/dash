import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash/dtos/chatDto/chatDto.dart';
import 'package:dash/dtos/chatPreviewDto/chatPreviewDto.dart';
import 'package:dash/dtos/memberDto/memberDto.dart';
import 'package:dash/services/authService.dart';
import 'package:dash/services/controllerService.dart';
import 'package:dash/state/userStateNotifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebaseState.g.dart';

@riverpod
AuthService authentication(AuthenticationRef ref) => AuthService();

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


@riverpod
Future<DataSnapshot> createChat(CreateChatRef ref, {required List<Member> selectedMembers}) async {
  final currentUserId = ref.read(currentUserProvider).value?.uid;
  return ref.watch(controllerProvider).createChat(selectedMembers, currentUserId!);
}

@riverpod
Future<void> sendMessage(SendMessageRef ref, {required String message, required ChatPreview chatPreview}) async {
  final currentUserId = ref.read(currentUserProvider).value?.uid;
  final userName = ref.read(memberProvider)?.name;
  
  ref.read(controllerProvider).sendMessage(message, chatPreview, currentUserId!, userName!);
}

@riverpod
Future<void> deleteChat(DeleteChatRef ref, {required String chatId}) async {
  final currentUserId = ref.read(currentUserProvider).value?.uid;
  ref.read(controllerProvider).deleteChat(chatId, currentUserId!);
}

@riverpod
Future<void> updateReadStatus(UpdateReadStatusRef ref, {required ChatPreview chatPreview}) async {
  final currentUserId = ref.read(currentUserProvider).value?.uid;
  ref.read(controllerProvider).updateReadStatus(chatPreview, currentUserId!);
}

@riverpod
Future<Member> getCurrentUserDocument(GetCurrentUserDocumentRef ref) async {
  final userId = ref.read(currentUserProvider).value?.uid;
  final member = ref.read(memberProvider);
  if(member == null || userId != member.uid){
    DocumentSnapshot userDocument = await ref.watch(controllerProvider).getUserDocument(userId!);
    ref.read(memberProvider.notifier).newMember(Member.fromJson(userDocument.data() as Map<String, dynamic>));
    return Member.fromJson(userDocument.data() as Map<String, dynamic>);
  }
  return member;
}

@riverpod
Future<void> updateUserDocument(UpdateUserDocumentRef ref, {required String name, String? uid}) async {
  final userId = ref.read(currentUserProvider).value?.uid ?? uid;
  return await ref.read(controllerProvider).updateUsersDocument(userId!, name);
}

final getAllUsersProvider = StreamProvider.autoDispose((ref){
  Stream<QuerySnapshot<Map<String, dynamic>>> stream = ref.watch(controllerProvider).getAllUsers();
  return stream.map((list) => list.docs.map((doc) => Member.fromJson(doc.data())).toList());
});

@riverpod
FirebaseFirestore firestore(FirestoreRef ref) => FirebaseFirestore.instance;
