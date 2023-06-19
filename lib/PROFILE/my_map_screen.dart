import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../CUSTOM_WIDGETS/custom_search_field.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';

class MyProfileMapWidget extends StatefulWidget {
  const MyProfileMapWidget({super.key,this.isTopSpots});
  final bool? isTopSpots;

  @override
  State<MyProfileMapWidget> createState() => MyProfileMapWidgetState();
}

class MyProfileMapWidgetState extends State<MyProfileMapWidget> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  void initState() {

    super.initState();
    _goToTheLake();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   title: const Text(
      //     'Top Spots',style: TextStyle(
      //       fontSize: 16,fontFamily: 'Rodetta',
      //       color: secondaryColor
      //   ),
      //   ),
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back_ios_new_rounded,
      //       color: fishColor,
      //     ),
      //     onPressed: () => Get.back(),
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            (widget.isTopSpots ?? false) ? const CustomAppBar(
              heading: 'Top Spots',
              textColor: secondaryColor,
            ) : const SizedBox.shrink(),
            (widget.isTopSpots ?? false) ?  const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 14,vertical: 16),
              child: CustomSearchField(
                hintText: 'Search',
              ),
            ):const SizedBox.shrink(),
            Expanded(
              child: Container(
                color: Colors.white,
                child: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapToolbarEnabled: true,
                  mapType: MapType.hybrid,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}