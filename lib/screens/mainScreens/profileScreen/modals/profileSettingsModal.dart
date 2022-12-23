import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileSettingsModal extends StatelessWidget {
  const ProfileSettingsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    //Bottom modal sheet appbar with cancel, title and save button
    return Column(
      children: [
        //AppBar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){
              context.pop();
            }, child: const Text('Cancel')),
            const Text(
              'Profile Settings',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: (){}, child: const Text('Save')),
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
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text("Change email"),
            const SizedBox(height: 10),
            //Field for name
            SizedBox(
              width: screenWidth * 0.8,
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter your new email',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
