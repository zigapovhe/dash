import 'package:dash/helpers/colors.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Container(
          color: ColorsHelper.background,
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Dashboard", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          )
      ),
    );
  }
}