import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Constants/apiKey.dart';
import '../Model/weatherModel.dart';

// Defining a ChangeNotifier class for managing weather data
class WeatherProvider extends ChangeNotifier {
  // Constructor that fetches data upon initialization
  WeatherProvider() {
    fetchData();
  }

  // Function to set the city and trigger data fetching
  setCity(String cityy) {
    city = cityy;
    fetchData();
    // Notifying listeners about the change in data
    notifyListeners();
  }

  // Variables to track loading state, data validity, and city
  bool loading = false;
  bool valid = false;
  String city = "india";

  late Weather _weather;

  // Getter for accessing the weather data
  Weather get allData => _weather;

  // Function to set weather data and notify listeners
  setWeather(Weather data) {
    _weather = (data);
    notifyListeners();
  }

  // Asynchronous function to fetch weather data from the API
  Future fetchData() async {
    // Setting loading to true before starting the data fetch
    loading = true;

    Weather weatherData;

    var response = await http.get(
        Uri.parse('http://api.weatherstack.com/current?access_key=$api_key&query=$city'));

    // Checking if the API request was successful (status code 200)
    if (response.statusCode == 200) {
      // Decoding the JSON response
      var weatherDecode = json.decode(response.body);
      // Checking if the API response indicates success or failure
      if (weatherDecode['success'] == false) {
        valid = false;
      } else {
        valid = true;
      }

      // Creating a Weather object from the decoded JSON
      weatherData = Weather.fromJson(weatherDecode);

      // Setting weather data and updating loading state
      setWeather(weatherData);
      loading = false;
      // Returning the weather data
      return weatherData;
    } else {
      // If the API request fails, setting loading to true and notifying listeners
      loading = true;
      notifyListeners();
      // Throwing an exception with a failure message
      throw Exception('Failed to load data!');
    }
  }
}
