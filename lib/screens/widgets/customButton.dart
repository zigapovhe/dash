import 'package:dash/helpers/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  const CustomButton({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
          backgroundColor: MaterialStateProperty.all(ColorsHelper.accent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )
          )
      ),
      onPressed: onTap,
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}