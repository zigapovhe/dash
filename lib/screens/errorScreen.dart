import 'package:dash/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  final GoRouterState? state;
  final String? error;
  const ErrorScreen({Key? key, required this.state, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("404 Route Not Found", style: TextStyle(color: Colors.white, fontSize: 30)),
            Padding(padding: const EdgeInsets.all(8),
              child: state == null
                  ? Text(error!, style: const TextStyle(color: Colors.white),)
                  : Text(state!.location, style: const TextStyle(color: Colors.white),),
            ),
            ElevatedButton(
              onPressed: () => context.go(Constants.loginRoute),
              child: const Text('Go to home page'),
            ),
          ],
        ),
      ),
    );
  }
}