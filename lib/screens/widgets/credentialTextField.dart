import 'package:dash/helpers/validators.dart';
import 'package:flutter/material.dart';

class CredentialTextField extends StatefulWidget {
  final bool isPassword;
  final String mainText;
  final bool allowObscureChange;
  final bool isPasswordVisible;
  final TextEditingController controller;

  final Function()? onVisibilityTap;
  final Function(String)? onChanged;
  final bool enableValidator;

  const CredentialTextField({
    Key? key,
    required this.mainText,
    required this.isPassword,
    this.allowObscureChange = false,
    this.isPasswordVisible = false,
    required this.controller,
    this.onVisibilityTap,
    this.onChanged,
    required this.enableValidator,
  }) : super(key: key);

  @override
  State<CredentialTextField> createState() => _CredentialTextFieldState();
}

class _CredentialTextFieldState extends State<CredentialTextField> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    IconData icon;
    if (widget.isPasswordVisible) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }

    String? Function(String? input)? validatorFunction;
    if(widget.enableValidator){
      if(widget.isPassword) validatorFunction = Validators.requiredPasswordValidationHelper;
      if(widget.isPassword == false) validatorFunction = Validators.requiredEmailValidationHelper;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.mainText,
            style: const TextStyle(
                color: Colors.black
            )
        ),

        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: TextFormField(
                  keyboardType: widget.isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
                  obscureText: widget.allowObscureChange && !widget.isPasswordVisible,
                  autofillHints: widget.isPassword ? <String>[AutofillHints.password] : <String>[AutofillHints.email],
                  autofocus: false,
                  autocorrect: false,
                  onChanged: widget.onChanged,
                  controller: widget.controller,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  cursorRadius: const Radius.circular(8),
                  decoration: const InputDecoration(border: InputBorder.none, errorStyle: TextStyle(fontWeight: FontWeight.bold), errorMaxLines: 3),
                  validator: validatorFunction
              ),
            ),
            widget.onVisibilityTap != null && widget.allowObscureChange
                ? Positioned(
              top: 20.0,
              right: 20,
              child: GestureDetector(
                onTap: widget.onVisibilityTap,
                child: Container(
                  color: Colors.transparent,
                  child: Icon(icon, color: Colors.black54),
                ),
              ),
            ) : const SizedBox(),
          ],
        )
      ],
    );
  }
}

