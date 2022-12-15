
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash/services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticationProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final currentUserProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authStateChange;
});

final firestoreProvider = Provider.autoDispose<FirebaseFirestore>((ref){
  return FirebaseFirestore.instance;
});
