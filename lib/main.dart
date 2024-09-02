import 'package:demo_flutter_app/core/utils/session_storage.dart';
import 'package:demo_flutter_app/injection.dart';
import 'package:demo_flutter_app/presentation/home/screens/home_screen.dart';
import 'package:demo_flutter_app/presentation/login/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final SessionStorageService _secureStorageService = getIt.get();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _secureStorageService.getLoginSession(),
        builder: (context, AsyncSnapshot<Map<String, String?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            final loginSession = snapshot.data;
            if (loginSession != null && loginSession['token'] != null) {
              return const HomeScreen();
            } else {
              return LoginScreen();
            }
          }
        },
      ),
    );
  }
}
