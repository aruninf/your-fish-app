import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../CONTROLLERS/maps_conntroller.dart';
import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../UTILS/app_color.dart';

class MyProfileMapWidget extends StatelessWidget {
  MyProfileMapWidget({super.key, this.isTopSpots});

  final bool? isTopSpots;
  final mapController=Get.put(MapController());
  @override
  Widget build(BuildContext context) {
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
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                    child: CustomSearchField(
                      hintText: 'Search',
                    ),
                  )
                : const SizedBox.shrink(),
            Expanded(
              child: Obx(() => GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapToolbarEnabled: true,
                mapType: MapType.normal,
                markers: Set<Marker>.of(mapController.markers),
                initialCameraPosition: mapController.initialCameraPosition.value,
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
