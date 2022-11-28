import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  final String username;

  const WelcomeView({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text('Hello $username',style: const TextStyle(fontSize: 30,
                fontWeight: FontWeight.bold)),
          ),
          const Text('you have successfully logged in'),
        ],
      )),
    );
  }
}
