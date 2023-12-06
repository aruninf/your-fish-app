import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';
import 'package:yourfish/CUSTOM_WIDGETS/fish_dropdown.dart';
import 'package:yourfish/MODELS/post_response.dart';

import '../CONTROLLERS/user_controller.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../NETWORKS/network.dart';
import '../NETWORKS/network_strings.dart';
import '../UTILS/app_color.dart';
import '../UTILS/dialog_helper.dart';

class AddFishScreen extends StatelessWidget {
  AddFishScreen({super.key, this.postData});

  final userController = Get.find<UserController>();
  final controller = Get.put(PostController());
  final imageUrl = ''.obs;
  final _formKey = GlobalKey<FormState>();
  final captionsController = TextEditingController();
  final PostData? postData;

  void getTags() {
    var data = {"sortBy": "desc", "sortOn": "id", "page": 1, "limit": "100"};
    Future.delayed(
      Duration.zero,
      () {
        Get.find<UserController>().getFish(data);
        if ((postData?.caption ?? "").isNotEmpty) {
          imageUrl.value = postData?.image ?? "";
          captionsController.text = postData?.caption ?? "";
          controller.isLocationOn.value = postData?.isPublic == 1;
          //userController.selectedFishTag.addAll(postData?.tagFish ?? []);
        }
      },
    );
  }

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
    //userController.selectedFishingLocation.add(p.description?.split(",").first);
    controller.currentAddress.value = p.description!.split(",").first;
    // Extracting the zip code
    for (var component in detail.result.addressComponents) {
      for (var type in component.types) {
        if (type == "postal_code") {
          //zipCode = component.longName;
          controller.addressPinCode.value=component.longName;
          break;
        }
      }

    }

    //DialogHelper.showErrorDialog(description: "${p.description}");
  }

  @override
  Widget build(BuildContext context) {
    getTags();
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              heading: 'Create Your Post',
              textColor: secondaryColor,
            ),
            Obx(() => Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            dense: true,
                            title: TextButton.icon(
                              label: const Text(
                                "Add a specific location",
                                style: TextStyle(color: primaryColor),
                              ),
                              onPressed: () => handlePressButton(context),
                              icon: const Icon(
                                Icons.search,
                                color: primaryColor,
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: secondaryColor),
                            ),
                            subtitle: CustomText(
                              text:
                                  (controller.currentAddress.value.replaceAll(",", "")),
                              color: secondaryColor,
                              maxLin: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 0),
                              child: Row(
                                children: [
                                  const Icon(
                                    PhosphorIcons.map_pin,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  CustomText(
                                    text: controller.isLocationOn.value
                                        ? "Public Location"
                                        : "Private Location",
                                    color: Colors.white,
                                  ),
                                  const Spacer(),
                                  Switch(
                                    activeColor: primaryColor,
                                    activeTrackColor: fishColor,
                                    value: controller.isLocationOn.value,
                                    onChanged: (value) {
                                      controller.isLocationOn.value =
                                          !controller.isLocationOn.value;
                                      if (controller.isLocationOn.value) {
                                        controller.getUserData();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Wrap(
                            runSpacing: 8,
                            spacing: 5,
                            children: List.generate(
                                userController.selectedFishTag.length,
                                (index) => InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: () {
                                        if (userController.selectedFishTag
                                            .contains(userController
                                                .selectedFishTag[index])) {
                                          userController.selectedFishTag.remove(
                                              userController
                                                  .selectedFishTag[index]);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.white24,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              userController
                                                      .selectedFishTag[index]
                                                      .localName ??
                                                  '',
                                              style: const TextStyle(
                                                  color: secondaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            const Icon(
                                              Icons.close,
                                              color: secondaryColor,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SearchableFishDropdown(),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: Get.height * 0.33,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: GestureDetector(
                              onTap: () {
                                DialogHelper.selectImageFrom(
                                    onClick: (uri) async {
                                      imageUrl.value = await Network()
                                              .uploadFile(uri!, 'fish') ??
                                          '';
                                      //controller.uploadFile.value = uri;
                                      //Get.back();
                                    },
                                    context: context);
                              },
                              child: imageUrl.value.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        imageUrl.value,
                                        fit: BoxFit.cover,
                                      ))
                                  : const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_circle_outline_rounded,
                                          size: 48,
                                          color: secondaryColor,
                                          weight: 800,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        CustomText(
                                          text: 'Upload Post',
                                          color: btnColor,
                                          weight: FontWeight.w800,
                                          sizeOfFont: 16,
                                        )
                                      ],
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: captionsController,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(color: Colors.white),
                            maxLines: 3,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Caption required';
                              }
                              return null;
                            },
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
                              hintText: "Caption/Comment...",
                              hintStyle: const TextStyle(color: Colors.white54),
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        height: 55,
        margin: const EdgeInsets.all(25),
        child: CommonButton(
          btnBgColor: secondaryColor,
          btnTextColor: primaryColor,
          btnText: "Post",
          onClick: () {
            if (_formKey.currentState!.validate()) {
              controller.getCurrentPosition();

              if (controller.currentPosition.value.latitude != 0 &&
                  controller.currentPosition.value.longitude != 0) {
                var data = {
                  "id": postData?.id,
                  "isPublic": controller.isLocationOn.value,
                  "type": 1,
                  "latitude": controller.currentPosition.value.latitude,
                  "longitude": controller.currentPosition.value.longitude,
                  "address": controller.currentAddress.value,
                  "zip_code": controller.addressPinCode.value,
                  "tag_fish": userController.selectedFishTag
                      .map((element) => element.id)
                      .toList(),
                  "image": imageUrl.value,
                  "caption": captionsController.text.trim()
                };
                controller.createPost(data);
              } else {
                Get.snackbar('Required!', 'Please enable your location',
                    colorText: Colors.orange, snackPosition: SnackPosition.TOP);
                return;
              }
            }
          },
        ),
      ),
    );
  }
}
