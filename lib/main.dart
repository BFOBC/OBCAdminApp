import 'package:bf_obc_admin/ui/AdminLogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart'; // This is generated during Firebase setup.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensures widget binding is initialized
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);  // Initialize Firebase with platform-specific options
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Login',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF18D118)),
        useMaterial3: true,
      ),
      home: AdminLoginPage(), // Use AdminLoginPage as the home page.
    );
  }
}
