import 'package:flutter/material.dart';
import 'package:frontend/screens/login_page.dart';
import 'package:frontend/services/auth_service.dart';

class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    AuthService authService = AuthService();
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await authService.logout();
          if (!mounted) return;
          Navigator.of(context).pushNamedAndRemoveUntil(
              'login', (Route<dynamic> route) => false);
        },
        child: const Text("log out"),
      ),
    );
  }
}
