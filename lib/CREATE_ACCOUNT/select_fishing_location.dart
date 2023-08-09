import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:yourfish/NETWORKS/keys.dart';
import '../CONTROLLERS/user_controller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import '../UTILS/dialog_helper.dart';

class SelectFishingLocation extends StatelessWidget {
  SelectFishingLocation({super.key});

  final userController = Get.find<UserController>();

  final searchController = TextEditingController();

  void callApi() async {
    var data = {
      "sortBy": "asc",
      "sortOn": "created_at",
      "page": "1",
      "limit": "20"
    };
    Future.delayed(
      Duration.zero,
      () => userController.getFishLocation(data),
    );
  }

  void onError(PlacesAutocompleteResponse response) {
    DialogHelper.showErrorDialog(description: response.errorMessage );
    print(response.errorMessage);
  }
  _handlePressButton(BuildContext context) async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      //apiKey: '',
      apiKey: '',
      onError: onError,
      radius: 10000000,
      types: [],
      strictbounds: false,
      mode: Mode.overlay,
      language: "en",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "in")],
    );

    displayPrediction(p ?? Prediction());
  }


Future<void> displayPrediction(Prediction p) async {
  GoogleMapsPlaces _places = GoogleMapsPlaces(
    apiKey: '',
    apiHeaders: await const GoogleApiHeaders().getHeaders(),
  );
  PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId ?? '');
  final lat = detail.result.geometry?.location.lat;
  final lng = detail.result.geometry?.location.lng;
  DialogHelper.showErrorDialog(description: "${p.description} - $lat/$lng" );


}

  @override
  Widget build(BuildContext context) {
    callApi();
    return Scaffold(
      extendBody: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              heading: 'Locations where you \nGo fishing',
              textColor: fishColor,
            ),

            //TextButton(onPressed: () => _handlePressButton(context), child: const Text("Search Places")),

            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: CustomSearchField(
                hintText: 'Search Location',
                controller: searchController,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(() => Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: userController.isDataLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : userController.fishingLocation.isEmpty
                          ? const Center(
                              child: Text(
                                "No Record Found!",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : ListView.builder(
                              itemCount: userController.fishingLocation.length,
                              itemBuilder: (context, index) => Obx(() =>
                                  Container(
                                    width: Get.width,
                                    margin: const EdgeInsets.only(top: 16),
                                    decoration: BoxDecoration(
                                      color: userController
                                              .selectedFishingLocation
                                              .contains(userController
                                                  .fishingLocation[index].name)
                                          ? fishColor
                                          : btnColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () {
                                        if (userController
                                            .selectedFishingLocation
                                            .contains(userController
                                                .fishingLocation[index].name)) {
                                          userController.selectedFishingLocation
                                              .remove(userController
                                                  .fishingLocation[index].name);
                                        } else {
                                          userController.selectedFishingLocation
                                              .add(userController
                                                  .fishingLocation[index].name);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: CustomText(
                                          text: userController
                                                  .fishingLocation[index]
                                                  .name ??
                                              '',
                                          sizeOfFont: 16,
                                          weight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                )))
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: 55,
        margin: const EdgeInsets.all(25),
        child: CommonButton(
          btnBgColor: fishColor,
          btnTextColor: primaryColor,
          btnText: "NEXT",
          onClick: () {
            if (userController.selectedFishingLocation.isEmpty) {
              Get.snackbar('Required!', 'Select at-least one',
                  colorText: Colors.orange, snackPosition: SnackPosition.TOP);
              return;
            }
            var data = {
              "location_id":
                  userController.selectedFishingLocation.join(",").toString(),
            };
            userController.updateOnBoarding(data, 3);
          },
        ),
      ),
    );
  }
}
