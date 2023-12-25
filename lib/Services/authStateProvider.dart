import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Defining a ChangeNotifier class for Google Sign-In functionality
class GoogleSignInProvider extends ChangeNotifier {
  // Creating an instance of GoogleSignIn
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  // Getter for accessing the signed-in Google user
  GoogleSignInAccount get user => _user!;

  // Asynchronous function to handle Google Sign-In
  Future googleLogin() async {
    // Initiating the Google Sign-In process and retrieving the user
    final googleUser = await googleSignIn.signIn();
    // Checking if the user canceled the sign-in process
    if (googleUser == null) return;

    // Updating the _user variable with the signed-in Google user
    _user = googleUser;

    // Retrieving authentication details from the signed-in Google user
    final googleAuth = await googleUser.authentication;

    // Creating GoogleAuthProvider credential with access token and ID token
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Signing in with Firebase using the GoogleAuthProvider credential
    await FirebaseAuth.instance.signInWithCredential(credential);

    // Notifying listeners about the authentication state change
    notifyListeners();
  }

  // Asynchronous function to handle user logout
  Future logout() async {
    // Signing out from Google Sign-In
    await googleSignIn.signOut();
    // Signing out from Firebase Authentication
    FirebaseAuth.instance.signOut();

    // Notifying listeners about the authentication state change
    notifyListeners();
  }
}
