import 'package:flutter/material.dart';

// Here is your shared state define variables and such in here
// use notifyListeners(); to update any changed variable for the user too see
class HomeState extends ChangeNotifier {
  //example
  String name = "John";
  void setName(String newName) {
    name = newName; // change value in the state
    notifyListeners(); // tell the listeners state has changed and they update the ui
  }
}
