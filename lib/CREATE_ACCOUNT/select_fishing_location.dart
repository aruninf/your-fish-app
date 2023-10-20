import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:yourfish/CUSTOM_WIDGETS/custom_app_bar.dart';

import '../CONTROLLERS/user_controller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../NETWORKS/network_strings.dart';
import '../UTILS/app_color.dart';
import '../UTILS/dialog_helper.dart';

class SelectFishingLocation extends StatelessWidget {
  SelectFishingLocation({super.key});

  final userController = Get.find<UserController>();

  final searchController = TextEditingController();

  void onError(PlacesAutocompleteResponse response) {
    DialogHelper.showErrorDialog(description: response.errorMessage);
    print(response.errorMessage);
  }

  handlePressButton(BuildContext context) async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: a + b + c + d,
      onError: onError,
      radius: 10000000,
      mode: Mode.overlay,
      language: "en",
      types: [],
      strictbounds: false,
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "au")],
    );

    displayPrediction(p ?? Prediction());
  }


Future<void> displayPrediction(Prediction p) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: a + b + c + d,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(p.placeId ?? '');
    final lat = detail.result.geometry?.location.lat;
    final lng = detail.result.geometry?.location.lng;
    userController.selectedFishingLocation.add(p.description?.split(",").first);
    //DialogHelper.showErrorDialog(description: "${p.description}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              heading: 'Locations where you \nGo fishing',
              textColor: fishColor,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextButton.icon(
                label: const Text("Search from google map",style: TextStyle(color:primaryColor),),
                onPressed: () => handlePressButton(context),
                icon: const Icon(Icons.search,color: primaryColor,),
                style: TextButton.styleFrom(
                  backgroundColor: secondaryColor
                ),

              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 3.0,
                      color: Colors.black26,
                    ),
                  ]
              ),
              margin: const EdgeInsets.symmetric(horizontal: 14),

              child: TextFormField(
                  //onTap: () => handlePressButton(context),
                  controller: searchController,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 13),
                  decoration:  InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                        width: 70,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: secondaryColor,
                          ),
                          onPressed: () {
                            if (searchController.text.trim().isNotEmpty) {
                              userController.selectedFishingLocation
                                  .add(searchController.text.trim());
                              searchController.text="";
                            }
                          },
                          child: const Text('Save',style: TextStyle(color: primaryColor),),
                        ),
                      ),
                      prefixIcon: const Icon(PhosphorIcons.magnifying_glass),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      hintStyle:
                      const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      hintText: 'Add manually')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                children: List.generate(
                    userController.selectedFishingLocation.length,
                        (index) => InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        if (userController.selectedFishingLocation.contains(
                            userController
                                .selectedFishingLocation[index])) {
                          userController.selectedFishingLocation.remove(
                              userController
                                  .selectedFishingLocation[index]);
                        }
                      },
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        margin: const EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              userController.selectedFishingLocation[index],
                              style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.close,
                              color: primaryColor,

                            )
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ],
        )),
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
              Get.snackbar('Required!', 'Select at least one',
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
