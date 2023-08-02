import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';
import 'package:get/get.dart';
import 'package:yourfish/MODELS/fish_response.dart';
import '../UTILS/app_color.dart';

class SearchableFishDropdown extends StatelessWidget {
  SearchableFishDropdown({super.key});

  final controller=Get.find<UserController>();
  final tagFishController = TextEditingController().obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => TypeAheadFormField(
      textFieldConfiguration:  TextFieldConfiguration(
        controller: tagFishController.value,
        autofocus: false,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              vertical: 14, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
                color: Colors.white, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
                color: Colors.white, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
                color: Colors.white, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
                color: Colors.white, width: 1),
          ),
          hintText: "Search for a tag fish",
          hintStyle: const TextStyle(color: Colors.white54),
          labelStyle: const TextStyle(color: Colors.white),
        ),
      ),
      suggestionsCallback: (pattern) {
        return _getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 0),
          title: Text("${suggestion.localName} ( ${suggestion.scientificName} )"),
        );
      },
      onSuggestionSelected: (suggestion) {
        // Handle when an item is selected
        if(controller.selectedFishTag.contains(suggestion)){
          //controller.selectedFishTag.remove(suggestion);
          Get.snackbar('You already tagged this fish', '',
              colorText: Colors.deepOrangeAccent, snackPosition: SnackPosition.TOP);
        }else{
          controller.selectedFishTag.add(suggestion);
        }
        tagFishController.value.text='';
        print('Selected: $suggestion');
      },
    ));
  }

  List<FishData> _getSuggestions(String pattern) {
    List<FishData> filteredList = [];
    for (FishData item in controller.fishData) {
      if ((item.localName ?? '').toLowerCase().contains(pattern.toLowerCase())) {
        filteredList.add(item);
      }
    }
    return filteredList;
  }
}
