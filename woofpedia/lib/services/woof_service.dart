import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:woofpedia/models/dog.dart';

String apiKey =
    "GETlive_hKEc7Er97079x221Xn1Q7TbMbFCb62LH9zoLOBNM5H9nWbqsBZTs8vhOQNT4ZCgT";

// Docs https://developers.thecatapi.com/view-account/ylX4blBYT9FaoVd6OhvR?report=FJkYOq9tW
// In your code, replace the API reference from api.thecatapi.com with api.thedogapi.com. (For dogs for woofpedia)

class UniService {
  Future<List> getRandomDogImage() async {
    var url = "https://api.thedogapi.com/v1/images/search";
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'x-api-key': apiKey,
      }).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // convert the data to what you want and return! (url of the photo in this case)
        return []; // return that list!!!!
      } else {
        //Bad status code
        return [];
      }
    } catch (e) {
      print("No internet / connection to api!");
      return [];
    }
  }

  Future<List> getBreeds() async {
    var url = "https://api.thedogapi.com/v1/breeds";
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        // 'x-api-key': apiKey,
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<Dog> breeds = [];
        for (var breed in data) {
          Dog tempDog = Dog();
          tempDog.breedName = breed["name"] ?? "";
          tempDog.breedId = breed["id"] ?? -1;
          tempDog.temperament = breed["temperament"] ?? "";
          tempDog.imageId = breed["reference_image_id"] ?? "";
          breeds.add(tempDog);
        }
        // convert the data to what you want and return! (looking for a Map of breed name to breed id!)
        return breeds; // return that list!!!!
      } else {
        //Bad status code
        return [];
      }
    } catch (e) {
      print("No internet / connection to api!");
      return [];
    }
  }
}
