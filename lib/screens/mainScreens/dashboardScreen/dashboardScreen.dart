import 'package:dash/enums/ReadStatusEnum.dart';
import 'package:dash/helpers/colors.dart';
import 'package:dash/helpers/constants.dart';
import 'package:dash/screens/mainScreens/dashboardScreen/widgets/chatBanner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Material(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
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
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Iskanje",
                    hintStyle: TextStyle(color: Colors.grey),
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),



              //Chat banner with ListView
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ChatBanner(
                          name: "Lan Pavletič",
                          lastMessage: "Yo, kaku smo?",
                          time: "12:00",
                          readStatus: ReadStatusEnum.read,
                          onTap: () {
                            print("Chat banner pressed");
                          });
                      },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}