import 'package:dash/helpers/colors.dart';
import 'package:dash/screens/mainScreens/profileScreen/modals/accountSettingsModal.dart';
import 'package:dash/screens/mainScreens/profileScreen/modals/profileSettingsModal.dart';
import 'package:dash/screens/mainScreens/profileScreen/modals/securitySettingsModal.dart';
import 'package:dash/screens/widgets/settingsButton.dart';
import 'package:dash/state/firebaseState/firebaseState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecuritySettingsModal extends ConsumerWidget {
  const SecuritySettingsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authenticationProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final emailController = TextEditingController();
    //Bottom modal sheet appbar with cancel, title and save button
    return Column(
      children: [
        //AppBar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  // context.pop()
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
          children: [
            const SizedBox(height: 10),
            const Text(""),
            const SizedBox(height: 10),
            //Field for name
            SizedBox(
              width: screenWidth * 0.8,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email address',
                  hintText: 'Enter your email for the recovery password',
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
