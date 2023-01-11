import 'package:dash/state/firebaseState/firebaseState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SecuritySettingsModal extends ConsumerWidget {
  const SecuritySettingsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authenticationProvider);
    //Bottom modal sheet appbar with cancel, title and save button
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //AppBar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Cancel')),
            const Text(
              'Reset your password',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
                onPressed: () async {
                  auth.resetPassword('', context);
                },
                child: const Text('Send')),
          ],
        ),

        //Body
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [],
        )
      ],
    );
  }
}
