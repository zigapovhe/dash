import 'package:dash/dtos/chatPreviewDto/chatPreviewDto.dart';
import 'package:dash/screens/mainScreens/dashboardScreen/widgets/chatBubble.dart';
import 'package:dash/state/firebaseState/firebaseState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DetailedChatScreen extends ConsumerWidget {
  final ChatPreview chatPreview;
  const DetailedChatScreen({Key? key, required this.chatPreview}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatData = ref.watch(fullChatProvider(chatPreview.chatId));
    final currentUser = ref.watch(currentUserProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        //AppBar
        SizedBox(
          height: screenHeight * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    GoRouter.of(context).pop();
                  }),
              Text(chatPreview.title, style: const TextStyle(color: Colors.black, fontSize: 20)),

              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    GoRouter.of(context).pop();
                  }),
            ],
          ),
        ),

        //Chat bubbles
        chatData.when(data: (data) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                      chat: data[index],
                      sentByMe: data[index].userId == currentUser.value!.uid,
                  );
                },
              ),
            ),
          );
        }, error: (e, s) {
          print("Error: $e\n$s");
          return Center(child: Text("Error: $e"));
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        })
      ],
    );
  }
}
