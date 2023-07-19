import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart' as mess;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import 'package:yourfish/CONTROLLERS/user_controller.dart';
import 'package:yourfish/CREATE_ACCOUNT/get_start.dart';
import 'package:yourfish/CREATE_ACCOUNT/select_fish_interest.dart';
import 'package:yourfish/HOME/main_home.dart';

import '../CREATE_ACCOUNT/create_account.dart';
import '../MODELS/login_response.dart';
import '../NETWORKS/network.dart';
import '../NETWORKS/network_strings.dart';
import '../UTILS/utils.dart';

/// 💥💥💥💥💥Created By Arun Android💥💥💥💥💥

class AuthController extends GetxController {
  var uploadFile = File('').obs;
  late String? fcmToken;
  late String? socialType;
  late String? currentTimeZone;
  var isPasswordVisible = true.obs;
  var isPasswordVisible1 = true.obs;

  @override
  void onReady() async {
    bool? isLogin = await Utility().getBoolValue(isLoginKey);
    String? token = await Utility.getStringValue(tokenKey);

    if (token != null) {
      if (isLogin != null && isLogin) {
        Get.offAll(() => const MainHome(), transition: Transition.rightToLeft);
      } else {
        Get.offAll(() => SelectFishInterest(),
            transition: Transition.rightToLeft);
      }
    }
    //await getToken();
    //String? token = await Utility.getStringValue(tokenKey);
    print("token==========$token");
    super.onReady();
  }

  Future<void> getToken() async {
    // Get firebase token
    mess.FirebaseMessaging.instance.getToken().then((token) {
      fcmToken = token;
      print("fcmToken==============$fcmToken");
    });
  }

  /// 💥💥💥💥💥💥💥💥💥💥 Sign In With APPLE 💥💥💥💥💥💥💥💥💥💥💥💥💥💥💥

  Future<void> signInWithApple() async {
    final AuthorizationResult res = await TheAppleSignIn.performRequests([
      const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    switch (res.status) {
      case AuthorizationStatus.authorized:
        try {
          //Get Token
          final AppleIdCredential appleIdCredential = res.credential!;
          final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
          final OAuthCredential credential = oAuthProvider.credential(
              idToken:
                  String.fromCharCodes(appleIdCredential.identityToken ?? []),
              accessToken: String.fromCharCodes(
                  appleIdCredential.authorizationCode ?? []));
          // get the user's fullName
          final userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          final firebaseUser = userCredential.user!;

          final fullName = appleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';
            await firebaseUser.updateDisplayName(displayName);
          }

          userSocialLogin(userCredential.user, 'apple');
        } on FirebaseAuthException catch (error) {
          print(error.message);
          Get.snackbar('Error!', 'Apple authorization failed: ${error.message}',
              colorText: Colors.orange, snackPosition: SnackPosition.TOP);
        }
      case AuthorizationStatus.error:
        print('Apple authorization failed: ${res.error?.localizedDescription}');
        Get.snackbar('Error!',
            'Apple authorization failed: ${res.error?.localizedDescription}',
            colorText: Colors.orange, snackPosition: SnackPosition.TOP);

      case AuthorizationStatus.cancelled:
        print('Apple sign in cancelled');
        Get.snackbar('Error!', 'Apple sign in cancelled',
            colorText: Colors.orange, snackPosition: SnackPosition.TOP);
    }
  }

  ///💥💥💥💥💥💥💥💥💥💥💥 Sign In With FaceBook 💥💥💥💥💥💥💥💥💥💥💥💥💥

  Future<void> signInWithFaceBook() async {
    // try {
    //   final LoginResult result = await FacebookAuth.instance.login();
    //   if (result.status == LoginStatus.success) {
    //     // you are logged in, get the access token.
    //     final AccessToken accessToken = result.accessToken!;
    //
    //     // sign into Firebase Auth
    //     var userCredential = await FirebaseAuth.instance.signInWithCredential(
    //         FacebookAuthProvider.credential(accessToken.token));
    //     userSocialLogin(userCredential.user, 'facebook');
    //   }
    //   if (result.status == LoginStatus.cancelled) {
    //     print('Login cancelled');
    //     Get.snackbar('Error!', 'Login cancelled',
    //         colorText: Colors.orange, snackPosition: SnackPosition.TOP);
    //   }
    //   if (result.status == LoginStatus.failed) {
    //     print('💥 Login failed!');
    //     print(result.message);
    //     Get.snackbar('Error!', 'Login Failed',
    //         colorText: Colors.orange, snackPosition: SnackPosition.TOP);
    //   }
    // } catch (err) {
    //   print(err.toString());
    //   Get.snackbar('Error!', err.toString(),
    //       colorText: Colors.orange, snackPosition: SnackPosition.TOP);
    // }
    Get.snackbar('Error!', 'Login Failed',
        colorText: Colors.orange, snackPosition: SnackPosition.TOP);
  }

  /// 💥💥💥💥💥💥💥💥💥💥💥Sign In With GOOGLE 💥💥💥💥💥💥💥💥💥💥💥💥💥💥

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      userSocialLogin(userCredential.user, 'google');
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error!', 'Login Failed',
          colorText: Colors.orange, snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> userSocialLogin(User? user, String socialType) async {
    if (user != null) {
      Utility.setStringValue(emailKey, user.email ?? "");
      Utility.setStringValue(nameKey, user.displayName ?? "");
      dynamic data = {"social_type": socialType, "social_id": user.uid};
      var response =
          await Network().postRequest(endPoint: socialLoginApi, formData: data);
      if (response?.data != null) {
        UserResponse loginResponse = UserResponse.fromJson(response?.data);
        if (loginResponse.status ?? false) {
          Utility.setStringValue(tokenKey, loginResponse.token ?? "");
          if (loginResponse.data?.gearId != null) {
            Utility().saveBoolValue(isLoginKey, true);
            Get.offAll(() => const MainHome());
            Get.snackbar('Login Successfully', '',
                colorText: Colors.green, snackPosition: SnackPosition.TOP);
          } else {
            Get.off(() => SelectFishInterest(),
                transition: Transition.rightToLeft);
          }
        } else {
          Get.off(() => CreateAccountScreen(
                socialType: socialType,
                socialId: user.uid,
              ));
        }
      }
    }
  }

  Future<void> forgotPassword(String email) async {
    dynamic data = {
      "email": email,
    };
    var response = await Network()
        .postRequest(endPoint: forgotPasswordApi, formData: data);
    if (response?.data != null) {
      Get.snackbar(response?.data['message'], '',
          colorText: Colors.green, snackPosition: SnackPosition.TOP);
    } else {
      Get.snackbar('Something went wrong!', '',
          colorText: Colors.deepOrangeAccent, snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> logoutUser() async {
    Get.find<UserController>().userLogout();
    Utility().clearAll();
    FirebaseAuth.instance.signOut();
    Get.offAll(() => GetStartScreen(), transition: Transition.leftToRight);
  }

  Future<void> deleteAccount(String reason) async {
    var para = {"deleteReason": reason};
    Get.find<UserController>().deleteAccount(para);
    FirebaseAuth.instance.signOut();
    Utility().clearAll();
    Get.offAll(() => GetStartScreen(), transition: Transition.leftToRight);
  }
}
