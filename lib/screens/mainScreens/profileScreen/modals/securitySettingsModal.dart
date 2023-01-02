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
    final screenWidth = MediaQuery.of(context).size.width;
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
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
              'Security settings',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: () async {}, child: const Text('Save')),
          ],
        ),

        //Body
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text("Change password"),
            const SizedBox(height: 10),
            //Field for name
            SizedBox(
              width: screenWidth * 0.8,
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your Password',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Confirm password"),
            const SizedBox(height: 10),
            //Field for name
            SizedBox(
              width: screenWidth * 0.8,
              child: TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm password',
                  hintText: 'Confirm your Password',
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
