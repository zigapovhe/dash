import 'package:dash/helpers/colors.dart';
import 'package:dash/screens/mainScreens/profileScreen/modals/accountSettingsModal.dart';
import 'package:dash/screens/mainScreens/profileScreen/modals/profileSettingsModal.dart';
import 'package:dash/screens/widgets/settingsButton.dart';
import 'package:dash/state/firebaseState/firebaseState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final auth = ref.read(authenticationProvider);
    return Material(
      child: SafeArea(
        child: Container(
            color: ColorsHelper.background,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Profil", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: ColorsHelper.accent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(Icons.person, color: Colors.white, size: 50),
                    ),
                    const SizedBox(height: 20),
                    Text(auth.currentUser!.displayName ?? "No display name set", style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(auth.currentUser!.email!, style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("Nastavitve", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                //Account settings elevated buttons with full width
                SettingsButton(
                    text: "Nastavitve profila",
                    icon: Icons.person,
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const ProfileSettingsModal()
                      );
                    }
                ),
                const SizedBox(height: 5),
                SettingsButton(
                    text: "Prijatelji",
                    icon: Icons.people,
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => const AccountSettingsModal()
                      );
                    }
                ),
                const SizedBox(height: 5),
                SettingsButton(
                    text: "Varnost",
                    icon: Icons.lock,
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => const AccountSettingsModal()
                      );
                    }
                ),
                TextButton(onPressed: (){
                  auth.signOut(ref);
                  }, child: const Text("Odjava", style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold))),



              ],
            )
        ),
      ),
    );
  }
}