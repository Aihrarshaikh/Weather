import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Services/authStateProvider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Getting the size of the screen using MediaQuery
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      height: size.height,
      width: size.width,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(12),
          width: double.infinity,
          height: 72,
          child: ElevatedButton.icon(
            onPressed: () {
              // Accessing the GoogleSignInProvider from the provider
              final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
              // Triggering the Google login function
              provider.googleLogin();
            },
            icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
            label: Text(
              "Sign In with Google",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xfff2274A5),
            ),
          ),
        ),
      ),
    );
  }
}
