import 'package:dash/helpers/colors.dart';
import 'package:dash/helpers/constants.dart';
import 'package:dash/screens/mainScreens/dashboardScreen/widgets/chatBanner.dart';
import 'package:dash/state/firebaseState/firebaseState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatPreviews = ref.watch(chatPreviewsProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final searchController = TextEditingController();

    return SafeArea(
      child: Material(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: ColorsHelper.background,
                height: screenHeight * 0.08,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Klepet", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                    ClipOval(
                      //Oval avatar
                      child: Material(
                        color: ColorsHelper.appBar, // button color
                        child: InkWell(
                          splashColor: ColorsHelper.accent.withOpacity(0.5), // inkwell color
                          child: const SizedBox(width: 45, height: 45, child: Icon(Icons.add, color: Colors.white,)),
                          onTap: () {
                            GoRouter.of(context).push(Constants.createChatRoute);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Search box with TextFormField
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (String value){
                    print(value);
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Iskanje",
                    hintStyle: TextStyle(color: Colors.grey),
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),

              chatPreviews.when(
                 data: (data) {
                   return Expanded(
                     child: Container(
                       margin: const EdgeInsets.only(top: 15),
                       child: ListView.builder(
                         scrollDirection: Axis.vertical,
                         itemCount: data.length,
                         itemBuilder: (context, index) {
                           return ChatBanner(
                                chatId: data[index].chatId,
                               name: data[index].title,
                               lastMessage: data[index].lastMessage,
                               time: data[index].timestamp!,
                               readStatus: data[index].readStatus,
                               onTap: () {
                                 GoRouter.of(context).push(Constants.detailedChatRoute, extra: data[index]);
                               });
                         },
                       ),
                     ),
                   );
                 },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) {
                   print("$error\n$stack");
                   return Text(error.toString());
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}