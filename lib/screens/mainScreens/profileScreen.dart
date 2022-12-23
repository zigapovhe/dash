import 'package:dash/helpers/colors.dart';
import 'package:dash/state/firebaseState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final auth = ref.read(authenticationProvider);
    return Material(
      child: Container(
          color: ColorsHelper.background,
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Profile", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
              TextButton(onPressed: (){auth.signOut();}, child: const Text("Sign out"))
            ],
          )
      ),
    );
  }
}