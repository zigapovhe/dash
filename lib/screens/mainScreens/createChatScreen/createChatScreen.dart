import 'package:dash/helpers/colors.dart';
import 'package:dash/state/firebaseState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateChatScreen extends ConsumerWidget {
  const CreateChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allUsers = ref.watch(getAllUsersProvider);

    return Column(
      children: [
        //ListView
        //Chat banner with ListView

        allUsers.when(data: (users){
          return Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final String abbreviation;
                  String name = users[index].name ?? "Dash user";
                  if(name.contains(" ")){
                    final List<String> split = name.split(" ");
                    abbreviation = split[0][0] + split[1][0];
                  } else {
                    if(name.length > 2){
                      abbreviation = name.substring(0, 2);
                    } else {
                      abbreviation = name;
                    }
                  }

                  return ListTile(
                    leading: ClipOval(
                      child: Material(
                        color: ColorsHelper.accent.withOpacity(0.5), // button color
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(child: Text(abbreviation, style: const TextStyle(color: Colors.white, fontSize: 18),))),
                      ),
                    ),
                    title: Text(users[index].name ?? "Dash user"),
                    subtitle: Text("#${users[index].tag}"),
                  );
                },
              ),
            ),
          );
        }, error: (s,e){
          print("$s\n$e");
          return const Text("Error");
        }, loading: (){
          return const Center(child: CircularProgressIndicator());
        }),

      ],
    );
  }
}
