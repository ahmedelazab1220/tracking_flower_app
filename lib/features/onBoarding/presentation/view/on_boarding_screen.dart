import 'package:flutter/material.dart';
import 'package:tracking_flower_app/core/utils/routes/app_routes.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: Column(
        children: [
          const Center(child: Text('Welcome to the Onboarding Screen!')),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.loginRoute);
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
