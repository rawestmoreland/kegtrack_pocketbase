import 'package:flutter/material.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/screens/login_page.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/keg_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();
  final KegService _kegService = KegService();

  @override
  void initState() {
    _authService.getSavedToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _authService),
        ChangeNotifierProvider(create: (_) => _kegService)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<AuthService>(
          builder: (context, snapshot, _) {
            switch (snapshot.status) {
              case LoginStatus.loggedIn:
                return const HomePage();
              case LoginStatus.idle:
                return const LoginPage();
              case LoginStatus.error:
                return const LoginPage();
              default:
                return Container(
                  color: Colors.blueGrey[900],
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  ),
                );
            }
          },
        ),
        routes: {
          'login': (context) => const LoginPage(),
          'home': (context) => const HomePage(),
        },
      ),
    );
  }
}
