import 'package:dash/dtos/memberDto/memberDto.dart';
import 'package:dash/helpers/colors.dart';
import 'package:dash/helpers/constants.dart';
import 'package:dash/helpers/extensions.dart';
import 'package:dash/state/firebaseState/firebaseState.dart';
import 'package:dash/state/selectedUsersStateNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateChatScreen extends ConsumerWidget {
  const CreateChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final ScrollController scrollController = ScrollController();
    List<Member> selectedUsers = ref.watch(selectedUsersProvider);
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
            Member me = users.firstWhere((element) => element.uid == currentUser.value!.uid);
            users = users.where((user) => user.uid != currentUser.value!.uid).toList();
            return Column(
              children: [
                //Done button
                selectedUsers.isEmpty
                    ? const SizedBox()
                    : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${selectedUsers.length} izbranih", style: const TextStyle(color: Colors.grey)),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              ref.read(selectedUsersProvider.notifier).clearUsers();
                            },
                            child: const Text("Prekliči", style: TextStyle(color: Colors.grey)),
                          ),
                          TextButton(
                              onPressed: () async {

                                List<Member> finalList = [];
                                if(selectedUsers.isNotEmpty){
                                  //Multi select
                                  finalList = [...selectedUsers, me];
                                }
                                await ref.read(createChatProvider(selectedMembers: finalList).future);
                                GoRouter.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Done', style: TextStyle(color: Colors.white),)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    height: selectedUsers.isNotEmpty ? screenHeight * 0.69 : screenHeight * 0.75,
                    child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        String name = users[index].name ?? "Dash user";

                        return InkWell(
                          onLongPress: () {
                            if(selectedUsers.contains(users[index])){
                              ref.read(selectedUsersProvider.notifier).removeUser(users[index].uid);
                            } else {
                              ref.read(selectedUsersProvider.notifier).addUser(users[index]);
                            }
                          },
                          onTap: () async {
                            if(selectedUsers.isNotEmpty){
                              if(selectedUsers.contains(users[index])){
                                ref.read(selectedUsersProvider.notifier).removeUser(users[index].uid);
                              } else {
                                ref.read(selectedUsersProvider.notifier).addUser(users[index]);
                              }
                            } else {
                              //Single select
                              List<Member> finalList = [users[index], me];
                              await ref.read(createChatProvider(selectedMembers: finalList).future);
                              GoRouter.of(context).pop();
                            }
                          },
                          child: ListTile(
                            leading: ClipOval(
                              child: Material(
                                color: selectedUsers.contains(users[index]) ? ColorsHelper.accent : ColorsHelper.accent.withOpacity(0.5), // button color
                                child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Center(child: Text(name.abbreviation, style: const TextStyle(color: Colors.white, fontSize: 18),))),
                              ),
                            ),
                            title: Text(name),
                            subtitle: Text("#${users[index].tag}"),
                            trailing: selectedUsers.contains(users[index]) ? const Icon(Icons.check) : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
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
