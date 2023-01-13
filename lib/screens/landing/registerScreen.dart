import 'package:dash/helpers/colors.dart';
import 'package:dash/helpers/constants.dart';
import 'package:dash/screens/widgets/credentialTextField.dart';
import 'package:dash/screens/widgets/customButton.dart';
import 'package:dash/state/firebaseState/firebaseState.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool password1Visible = false;
  bool password2Visible = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authenticationProvider);

    return Scaffold(
        backgroundColor: ColorsHelper.background,
        body: Form(
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
                  child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double screenWidth = constraints.maxWidth;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Dash Registracija", style: TextStyle(fontSize: 30, color: Colors.black)),
                          Padding(padding: const EdgeInsets.fromLTRB(40,20,40,0),
                            child: Align(alignment: Alignment.center,
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
                                        isPasswordVisible: password1Visible,
                                        onVisibilityTap: () {
                                          setState(() {
                                            password1Visible = !password1Visible;
                                          });
                                        },
                                    ),
                                    CredentialTextField(
                                        mainText: "Ponovi geslo",
                                        isPassword: true,
                                        controller: confirmPassController,
                                        enableValidator: true,
                                        allowObscureChange: true,
                                        isPasswordVisible: password2Visible,
                                        onVisibilityTap: () {
                                          setState(() {
                                            password2Visible = !password2Visible;
                                          });
                                        },
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: CustomButton(
                                        label: "Registracija",
                                        onTap: () async {
                                          if(formKey.currentState!.validate() && passController.text == confirmPassController.text && emailController.text.isNotEmpty) {
                                            await auth.signUpWithEmailAndPassword(context: context, ref: ref, email: emailController.text, password: passController.text);
                                          } else {
                                            showTopSnackBar(
                                              Overlay.of(context)!,
                                              const CustomSnackBar.error(
                                                message:
                                                "Izpovnite vsa polja.",
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    TextButton(onPressed: (){
                                      GoRouter.of(context).go(Constants.forgotPasswordRoute);
                                    }, child: const Text("Pozabljeno geslo?")),
                                    TextButton(onPressed: (){
                                      GoRouter.of(context).go(Constants.loginRoute);
                                    }, child: const Text("Prijava")
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                    );
                    },
                  ),
                )
              )
        )
    );
  }
}
