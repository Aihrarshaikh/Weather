import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Services/authStateProvider.dart';
import 'intermediate/authRedirect.dart';

// Asynchronous function to initialize Firebase and run the app
Future main() async {
  // Ensuring that Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initializing Firebase
  await Firebase.initializeApp();
  // Setting preferred device orientations to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(App()));
  // Running the app
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // Wrapping the entire app in a ChangeNotifierProvider for state management
    return ChangeNotifierProvider(
      // Creating an instance of GoogleSignInProvider for authentication state
      create: (context) => GoogleSignInProvider(),
      // MaterialApp widget representing the main structure of the app
      child: MaterialApp(
        // Disabling the debug banner in the top-right corner
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
