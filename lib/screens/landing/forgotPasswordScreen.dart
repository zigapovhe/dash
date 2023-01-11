import 'package:dash/helpers/colors.dart';
import 'package:dash/helpers/constants.dart';
import 'package:dash/screens/widgets/credentialTextField.dart';
import 'package:dash/screens/widgets/customButton.dart';
import 'package:dash/state/firebaseState/firebaseState.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authenticationProvider);
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();

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
                  decoration: kIsWeb
                      ? BoxDecoration(
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
                            ])
                      : null,
                  child: SizedBox(
                    width: kIsWeb ? screenWidth * 0.3 : screenWidth * 0.9,
                    height: screenHeight * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Dash pozabljeno geslo",
                            style:
                                TextStyle(fontSize: 30, color: Colors.black)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
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
                                      enableValidator: true),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: CustomButton(
                                      label: "Pošlji",
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          auth.resetPassword(emailController.text, context);
                                          GoRouter.of(context).go(Constants.loginRoute);
                                        }
                                      },
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        GoRouter.of(context)
                                            .go(Constants.loginRoute);
                                      },
                                      child: const Text("Prijava")),
                                  TextButton(
                                      onPressed: () {
                                        GoRouter.of(context)
                                            .go(Constants.registerRoute);
                                      },
                                      child: const Text("Registracija"))
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
        ));
  }
}
