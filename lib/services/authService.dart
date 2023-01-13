import 'package:dash/state/firebaseState/firebaseState.dart';
import 'package:dash/state/userStateNotifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AuthService {
  // For Authentication related functions you need an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //  This getter will be returning a Stream of User object.
  //  It will be used to check if the user is logged in or not.
  Stream<User?> get authStateChange => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  //  SignIn the user using Email and Password
  Future<void> signInWithEmailAndPassword(String email, String password,
      BuildContext context, WidgetRef ref) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => ref.read(getCurrentUserDocumentProvider));
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    }
  }

  // SignUp the user using Email and Password
  Future<void> signUpWithEmailAndPassword({required String email, required String password, required String name, required BuildContext context, required WidgetRef ref}) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password,).then((value) async {
        ref.read(updateUserDocumentProvider(name: name, uid: value.user!.uid));
        _auth.signOut();
        showTopSnackBar(
          Overlay.of(context)!,
          const CustomSnackBar.success(
            message:
            "Račun je bil uspešno ustvarjen",
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: Text('Error Occured'),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("OK"))
                  ]));
    } catch (e) {
      if (e == 'email-already-in-use') {
        print('Email already in use.');
      } else {
        print('Error: $e');
      }
    }
  }

  //  SignOut the current user
  Future<void> signOut(WidgetRef ref) async {
    ref.read(memberProvider.notifier).clearMember();
    await _auth.signOut();
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      String userEmail = _auth.currentUser?.email ?? email;
      _auth
          .sendPasswordResetEmail(email: userEmail)
          .then((value) => _auth.signOut());
    } on FirebaseAuthException catch (e) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: Text('Error Occured'),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("OK"))
                  ]));
    }
  }
}
