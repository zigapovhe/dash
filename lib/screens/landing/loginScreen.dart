import 'package:dash/helpers/colors.dart';
import 'package:dash/helpers/constants.dart';
import 'package:dash/screens/widgets/credentialTextField.dart';
import 'package:dash/screens/widgets/customButton.dart';
import 'package:dash/state/firebaseState.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authenticationProvider);
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();

    return Scaffold(
        backgroundColor: ColorsHelper.background,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;
            return Form(
              key: formKey,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: kIsWeb ? BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            1.0,
                            2.5,
                          ), //Offset
                          blurRadius: 5.0,
                          spreadRadius: 0.1,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ]
                  ) : null,
                  child: SizedBox(
                    width: kIsWeb ? screenWidth * 0.3 : screenWidth * 0.9,
                    height: screenHeight * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Dash Prijava", style: TextStyle(fontSize: 30, color: Colors.black)),
                        Padding(padding: const EdgeInsets.fromLTRB(40,20,40,20),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              alignment: Alignment.center,
                              width: kIsWeb ? screenWidth * 0.25 : null,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CredentialTextField(
                                      mainText: "Email naslov",
                                      isPassword: false,
                                      controller: emailController,
                                      enableValidator: true
                                  ),
                                  CredentialTextField(
                                      mainText: "Geslo",
                                      isPassword: true,
                                      controller: passController,
                                      enableValidator: true,
                                      allowObscureChange: true,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: CustomButton(
                                      label: "Prijava",
                                      onTap: () async {
                                        if(formKey.currentState!.validate()) {
                                          await auth.signInWithEmailAndPassword(emailController.text, passController.text, context, ref);
                                        }
                                      },
                                    ),
                                  ),
                                  TextButton(onPressed: (){}, child: const Text("Pozabljeno geslo?")),
                                  TextButton(onPressed: (){
                                    GoRouter.of(context).go(Constants.registerRoute);
                                  }, child: const Text("Registracija"))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
