import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/login.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully.");

    // Check if a user is already logged in
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      print(
          "User is logged in: ${currentUser.email}"); // You can print the user's email or uid
    } else {
      print("No user is logged in.");
    }
  } catch (e) {
    print("Firebase initialization error: $e");
    // Handle initialization error (e.g., show an error screen)
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Product Recognition',
      theme: ThemeData.dark(), // Dark theme
      home: AuthWrapper(), // Determines whether to show login or home
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return HomePage(); // Redirect to home if user is logged in
        }
        return LoginPage(); // Show login if not authenticated
      },
    );
  }
}
