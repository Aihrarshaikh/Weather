import 'package:assignment5/Screens/weatherPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/weatherStateProvider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    // Using ChangeNotifierProvider for state management
    return ChangeNotifierProvider(
      // Creating an instance of WeatherProvider as the data source
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        theme: ThemeData(
          // Customizations can be added here
        ),
        home: weatherPage(),
      ),
    );
  }
}
