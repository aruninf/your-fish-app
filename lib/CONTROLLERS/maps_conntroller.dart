import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yourfish/CONTROLLERS/post_controller.dart';

/// Google map implementation by Arun Android

class MapController extends GetxController {
  var locationController = Get.find<PostController>();
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  List<Marker> markers = <Marker>[];
  late BitmapDescriptor myIcon;
  double cameraZoom=14.0;

  var initialCameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 13.47,
  ).obs;

  var cameraPosition =  const CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(37.43296265331129, -122.08832357078792),
          tilt: 59.440717697143555,
          zoom: 13.47)
      .obs;

  Future<void> currentPosition() async {
    final GoogleMapController controller = await googleMapController.future;
    await controller.animateCamera(
        CameraUpdate.newCameraPosition(initialCameraPosition.value));
  }

  @override
  void onReady() async {
    await initializeMap();
    super.onReady();
    addMarker();
  }

  initializeMap() async {
    initialCameraPosition.value = CameraPosition(
      target: LatLng(locationController.currentPosition.value.latitude,
          locationController.currentPosition.value.longitude),
      zoom: cameraZoom,
    );

    cameraPosition.value = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(locationController.currentPosition.value.latitude,
            locationController.currentPosition.value.longitude),
        tilt: 9.0,
        zoom: cameraZoom);

    ///💥💥💥💥💥💥💥 SET Icon 💥💥💥💥💥💥💥

    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(24, 24)),
        'images/top_spot_icon.png')
        .then((onValue) {
      myIcon = onValue;
    });
    await currentPosition();
  }

  ///💥💥💥💥💥💥💥 Location Markers 💥💥💥💥💥💥💥
  void addMarker() {
    markers = [
      Marker(
          icon: myIcon,
          markerId: const MarkerId('SomeId1'),
          position: const LatLng(37.775834, -122.400417),
          infoWindow: const InfoWindow(title: 'Custom Marker')),
       Marker(
          icon: myIcon,
          markerId: const MarkerId('SomeId2'),
          position: const LatLng(37.785834, -122.4016417),
          infoWindow: const InfoWindow(title: 'The title of the marker')),
       Marker(
          icon: myIcon,
          markerId: const MarkerId('SomeId3'),
          position: const LatLng(37.785834, -122.4116417),
          infoWindow: const InfoWindow(title: 'The title of the marker')),
      Marker(
          icon: myIcon,
          markerId: const MarkerId('SomeId4'),
          position: const LatLng(37.795834, -122.406417),
          infoWindow: const InfoWindow(title: 'The title of the marker')),
    ];
  }
}
