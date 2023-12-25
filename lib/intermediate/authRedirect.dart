import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Screens/login.dart';
import 'mainScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // StreamBuilder listens to changes in the authentication state
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Checking if the authentication state is still waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Displaying a loading indicator if the state is waiting
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Checking if there is an error in the authentication process
          if (snapshot.hasError) {
            // Displaying an error message if an error occurs
            return Center(
              child: Text("Something went wrong"),
            );
          }

          // Checking if user authentication data is available
          if (snapshot.hasData) {
            // Navigating to the MainScreen if user is authenticated
            return MainScreen();
          } else {
            // Navigating to the LoginScreen if user is not authenticated
            return LoginScreen();
          }
        },
      ),
    );
  }
}
