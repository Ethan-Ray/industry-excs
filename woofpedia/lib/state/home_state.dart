import 'package:flutter/material.dart';
import 'package:woofpedia/models/dog.dart';
import 'package:woofpedia/services/woof_service.dart';

// Here is your shared state define variables and such in here
// use notifyListeners(); to update any changed variable for the user too see
class HomeState extends ChangeNotifier {
  //example
  String name = "John";
  UniService service = UniService();
  List breeds = [];
  List filteredBreeds = [];
  List favouriteBreeds = [];
  bool errorGettingBreeds = false;
  void setName(String newName) {
    name = newName; // change value in the state
    notifyListeners(); // tell the listeners state has changed and they update the ui
  }

  getBreeds() async {
    breeds = await service.getBreeds();
    if (breeds.isEmpty) errorGettingBreeds = true;
    notifyListeners();
  }

  filter(String value) {
    // filter the breeds list
    filteredBreeds = [];
    for (Dog breed in breeds) {
      if (breed.breedName.toLowerCase().contains(value.toLowerCase())) {
        filteredBreeds.add(breed);
      }
    }
    notifyListeners();
  }

  saveToFavourites(Dog breed) {
    if (favouriteBreeds.contains(breed)) return;
    favouriteBreeds.add(breed);
    notifyListeners();
  }

  removeFromFavourites(Dog breed) {
    favouriteBreeds.remove(breed);
    notifyListeners();
  }
}
