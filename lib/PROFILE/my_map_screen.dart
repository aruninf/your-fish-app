import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../CONTROLLERS/maps_conntroller.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../NETWORKS/network_strings.dart';
import '../UTILS/app_color.dart';
import '../UTILS/dialog_helper.dart';

class MyProfileMapWidget extends StatelessWidget {
  MyProfileMapWidget({super.key, this.isTopSpots});

  final bool? isTopSpots;
  final mapController = Get.put(MapController());

  void getTopSpots() async {
    Future.delayed(
      Duration.zero,
      () {
        /// type for top spots my and all 1 for all and 2 for me
        mapController.getTopSpots({"type": (isTopSpots ?? false) ? 1 : 2});
      },
    );
  }

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
    final lat = detail.result.geometry?.location.lat ?? 0.0;
    final lng = detail.result.geometry?.location.lng ?? 0.0;

    mapController.movePosition(lat, lng);
    //DialogHelper.showErrorDialog(description: "${p.description} - $lat/$lng");
  }

  @override
  Widget build(BuildContext context) {
    getTopSpots();
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            (isTopSpots ?? false)
                ? const CustomAppBar(
                    heading: 'Top Spots',
                    textColor: secondaryColor,
                  )
                : const SizedBox.shrink(),
            (isTopSpots ?? false)
                ? Container(
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 16),
                    child: TextFormField(
                        onTap: () => handlePressButton(context),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(PhosphorIcons.magnifying_glass),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 12),
                            hintStyle: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                            hintText: 'Search')),
                  )
                : const SizedBox.shrink(),
            Expanded(
              child: Obx(() => GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    mapToolbarEnabled: true,
                    mapType: MapType.normal,
                    markers: Set<Marker>.of(mapController.markers),
                    initialCameraPosition:
                        mapController.initialCameraPosition.value,
                    onMapCreated: (GoogleMapController controller) async {
                      mapController.googleMapController.complete(controller);
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
