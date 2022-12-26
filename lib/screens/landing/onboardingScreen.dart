import 'package:dash/helpers/constants.dart';
import 'package:dash/screens/widgets/customButton.dart';
import 'package:dash/state/generalState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final currentUser = ref.read(currentUserProvider);
    final userProvider = ref.watch(getUserDocumentProvider(currentUser.value!.uid));


    return Scaffold(
      body: userProvider.when(data: (user){
        if(user.firstLogin == false) {
          GoRouter.of(context).push(Constants.dashboardRoute);
              return const Center(
                  child: CircularProgressIndicator(),
              );
            } else {
              return Container(
                margin: EdgeInsets.fromLTRB(15, screenHeight * 0.1, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome to Dash",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Choose your name (can be changed later)', style: TextStyle(fontSize: 20),),

                    SizedBox(height: screenHeight * 0.05,),
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your full name',
                          prefixText: "#${user.tag} ",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05,),
                    CustomButton(label: "Save", onTap: (){print('save');},),
                  ],
                ),
              );
            }
          }, loading: (){
            return const Center(child: CircularProgressIndicator());
          }, error: (error, stack){
            print("Error: $error\nStack: $stack");
            return Center(child: Text("Error: $error"));
      }),
    );

  }
}
