import 'package:dash/dtos/memberDto/memberDto.dart';
import 'package:dash/helpers/colors.dart';
import 'package:dash/helpers/extensions.dart';
import 'package:dash/state/firebaseState/firebaseState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateChatScreen extends ConsumerWidget {
  const CreateChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final allUsers = ref.watch(getAllUsersProvider);

    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          //ListView
          //Chat banner with ListView
          //Search box with TextFormField
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Iskanje",
                hintStyle: TextStyle(color: Colors.grey),
                icon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),

          allUsers.when(data: (users){
            return Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    String name = users[index].name ?? "Dash user";

                    return InkWell(
                      onTap: () async {
                        Member me = users.firstWhere((element) => element.uid == currentUser.value!.uid);
                        List<Member> selectedUsers = [me, users[index]];
                        await ref.read(createChatProvider(selectedMembers: selectedUsers).future);
                      },
                      child: ListTile(
                        leading: ClipOval(
                          child: Material(
                            color: ColorsHelper.accent.withOpacity(0.5), // button color
                            child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Center(child: Text(name.abbreviation, style: const TextStyle(color: Colors.white, fontSize: 18),))),
                          ),
                        ),
                        title: Text(name),
                        subtitle: Text("#${users[index].tag}"),
                      ),
                    );
                  },
                ),
              ),
            );
          }, error: (s,e){
            print("$s\n$e");
            return const Text("Error");
          }, loading: () => const Center(child: CircularProgressIndicator()),
          ),

        ],
      ),
    );
  }
}
