import 'dart:convert';
import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';

import '../gemini_client.dart';
import '../models/collectable_card_model.dart';

class RegisterNewAnimal {
  static Future<CollectableCardModel> getGeminiObject(Uint8List image) async {
    try {
      final model = GeminiClient.instance;
      final prompt = TextPart('''
        If there is not an animal in the picture, return just the word 'ERROR', not more, I need you to recognize the animal in this picture and give me the next information
        Common Name, Scientific name, Breed, Habitat, Weight (in a range of the standard for that animal), Sex (possible options), and Curious information, listed with numbers.
        Don't crash if you can't find one of them, just Scientific name is required.
        Please return it in JSON format, the more raw the better, witouth any extra notation, like this:
        {
           "name": "Common Name",
           "scientific_name": "Scientific",
           "habitat": "Habitat",
           "regular_weight": "Weight",
           "possible_sex": "Male",
           "breed": "Breed",
           "curious_information": "They sleep 12 to 16 hours a day"
         }
         if the scientific name you get is an error, or similar, please don't return a json, just return the word ERROR.
        ''');
      final imageParts = [
        DataPart('image/jpeg', image),
      ];
      final response = await model.generateContent([
        Content.multi([prompt, ...imageParts])
      ]);
      if (response.text! == 'ERROR') {
        throw Exception(
            "We cannot know if there's an animal in the picture, please try again.");
      }
      Map<String, dynamic> properties = jsonDecode(response.text!);
      return CollectableCardModel.fromJson(properties);
    } catch (e) {
      throw Exception(
          "We cannot know if there's an animal in the picture, please try again.");
    }
  }
}
