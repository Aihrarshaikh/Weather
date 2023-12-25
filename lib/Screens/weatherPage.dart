import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/authStateProvider.dart';
import '../Services/weatherStateProvider.dart';

import '../Widgets/infoWidget.dart';

class weatherPage extends StatefulWidget {
  const weatherPage({super.key});

  @override
  State<weatherPage> createState() => _weatherPageState();
}

class _weatherPageState extends State<weatherPage> {
  // TextEditingController for capturing user input for city name
  TextEditingController nameController = TextEditingController();
  // String variable to store the city name
  String cityName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Logout button in the app bar
          IconButton(
            onPressed: () {
              // Logging out using the GoogleSignInProvider
              final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
              Navigator.pop(context);
            },
            icon: Icon(Icons.exit_to_app, color: Colors.red),
          ),
        ],
        // Title of the app bar
        title: Text(
          'Weather App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xfff2274A5),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text field for entering the location (city name)
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Location",
                ),
                onChanged: (text) {
                  // Updating the cityName variable when text changes
                  setState(() {
                    cityName = text;
                  });
                },
                onSubmitted: (val) {
                  // Setting the city in WeatherProvider when submitted
                  context.read<WeatherProvider>().setCity(val);
                },
              ),
              // Consumer for WeatherProvider to display weather information
              Consumer<WeatherProvider>(builder: (context, model, child) {
                return model.loading == true
                    ? Container(
                  // Loading indicator while data is being fetched
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(child: CircularProgressIndicator()))
                    : model.valid == false
                    ? Container(
                  // Displaying a message for invalid location
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.question_mark),
                        Text("Cound not find your place"),
                        Text("Enter a valid name for the location"),
                      ],
                    ),
                  ),
                )
                    : Column(
                  children: <Widget>[
                    // Stack with a ClipPath for a styled container
                    Stack(
                      children: <Widget>[
                        ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            color: Color(0xfff2274A5),
                            height: 300.0,
                            child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${model.allData.location!.region}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      '${model.allData.current!.temperature}°',
                                      style: TextStyle(
                                          fontSize: 50,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      model.allData.current!
                                          .weatherDescriptions[0],
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                    // InfoWidget for displaying additional weather details
                    infoWidget('humidity.png', 'Humidity',
                        '${model.allData.current!.humidity}%'),
                    // Divider for visual separation
                    Divider(
                      color: Colors.black,
                      indent: 50,
                      endIndent: 50,
                    ),
                    infoWidget('wind.png', 'Wind speed',
                        '${model.allData.current!.windSpeed} k/h'),
                    Divider(
                      color: Colors.black,
                      indent: 50,
                      endIndent: 50,
                    ),
                    infoWidget('wind-dir.png', 'Wind direction',
                        '${model.allData.current!.windDir}'),
                    Divider(
                      color: Colors.black,
                      indent: 50,
                      endIndent: 50,
                    ),
                    infoWidget('cloud.png', 'Cloud cover',
                        '${model.allData.current!.cloudcover}%'),
                    Divider(
                      color: Colors.black,
                      indent: 50,
                      endIndent: 50,
                    ),
                    infoWidget('prus.png', 'Pressure',
                        '${model.allData.current!.pressure} MB'),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// CustomClipper class for creating a curved shape for the background
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
