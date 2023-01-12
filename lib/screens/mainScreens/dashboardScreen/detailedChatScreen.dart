import 'package:dash/dtos/chatPreviewDto/chatPreviewDto.dart';
import 'package:dash/enums/ReadStatusEnum.dart';
import 'package:dash/helpers/colors.dart';
import 'package:dash/helpers/extensions.dart';
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
    final TextEditingController messageController = TextEditingController();
    final ScrollController scrollController = ScrollController();
    final screenHeight = MediaQuery.of(context).size.height;
    final chatData = ref.watch(fullChatProvider(chatPreview.chatId));
    final currentUser = ref.watch(currentUserProvider);
    if(chatPreview.readStatus == ReadStatus.newMessage) {
      ref.read(updateReadStatusProvider(chatPreview: chatPreview));
    }
    scrollToTheBottom(scrollController);

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
              child: data.isNotEmpty ? ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                      chat: data[index],
                      sentByMe: data[index].userId == currentUser.value!.uid,
                  );
                },
              ) : Column(
                children: [
                  ClipOval(
                    child: Material(
                      color: ColorsHelper.accent.withOpacity(0.5), // button color
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(child: Text(chatPreview.title.abbreviation, style: const TextStyle(color: Colors.white, fontSize: 18),))),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(chatPreview.title, style: const TextStyle(color: Colors.black, fontSize: 15)),
                  SizedBox(height: screenHeight * 0.02,),
                  const Text("Začnite pogovor z prvim sporočilom", style: TextStyle(color: Colors.grey, fontSize: 15)),
                ],
              ),
            ),
          );
        }, error: (e, s) {
          print("Error: $e\n$s");
          return Center(child: Text("Error: $e"));
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }),

        //Send message
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10,),
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          controller: messageController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Sporočilo",
                          ),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if(messageController.text.isNotEmpty){
                              ref.read(sendMessageProvider(chatPreview: chatPreview, message: messageController.text));
                            }
                            messageController.clear();
                          }
                      ),
                    ],
                  ),
                ),
              ),
        ])
        ),
      ],
    );
  }

  void scrollToTheBottom(ScrollController scrollController){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.hasClients ? scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut) : null;
    });
  }
}
