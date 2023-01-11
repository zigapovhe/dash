import 'package:dash/state/firebaseState/firebaseState.dart';
import 'package:dash/state/userStateNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileSettingsModal extends ConsumerWidget {
  const ProfileSettingsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final nameController = TextEditingController();
    //Bottom modal sheet appbar with cancel, title and save button
    return Column(
      children: [
        //AppBar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: () {
                  context.pop();
                },
                child: const Text('Cancel')),
            const Text(
              'Profile Settings',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
                onPressed: () async {
                  ref.read(memberProvider.notifier).updateName(name: nameController.text);
                  await ref.read(updateUserDocumentProvider(name: nameController.text).future);
                },
                child: const Text('Save')),
          ],
        ),

        //Body
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text("Change account name"),
            const SizedBox(height: 10),
            //Field for name
            SizedBox(
              width: screenWidth * 0.8,
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
