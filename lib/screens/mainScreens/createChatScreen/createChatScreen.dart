import 'package:flutter/material.dart';

class CreateChatScreen extends StatelessWidget {
  const CreateChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //ListView
        //Chat banner with ListView
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: const NetworkImage("https://i.pravatar.cc/150?img=1"),
                  ),
                  title: const Text("User Name"),
                  subtitle: const Text("#A4333"),
                  trailing: const Text("12:00"),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
