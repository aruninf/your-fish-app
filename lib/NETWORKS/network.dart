import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:yourfish/CREATE_ACCOUNT/sign_in.dart';
import '../UTILS/dialog_helper.dart';
import '../UTILS/utils.dart';
import '../utils/network_strings.dart';

class Network {
  static Dio? _dio;
  static CancelToken? _cancelRequestToken;
  static Network? _network;
  static int connectTimeOut = 20000;
  static int receivingTimeOut = 6000;

  Network._createInstance();

  factory Network() {
    if (_network == null) {
      _network = Network._createInstance();

      _dio = _getDio();
      _cancelRequestToken = _getCancelToken();
    }
    return _network!;
  }

  static Dio _getDio() {
    return _dio ??= Dio();
  }

  static CancelToken _getCancelToken() {
    return _cancelRequestToken ??= CancelToken();
  }

  ////////////////// Get Request ///////////////////////

  Future<Response?> getRequest(
      {String baseUrl = NetworkStrings.API_BASE_URL,
      required String endPoint,
      Map<String, dynamic>? queryParameters}) async {
    Response? response;
    String? token = await Utility.getStringValue(NetworkStrings.token);
    if (await InternetConnectionChecker().hasConnection) {
      try {
        _dio?.options.connectTimeout =  Duration(milliseconds: connectTimeOut);
        response = await _dio!.get(baseUrl + endPoint,
            queryParameters: queryParameters,
            cancelToken: _cancelRequestToken,
            options: Options(
              headers: {
                'Accept': NetworkStrings.ACCEPT,
                'Authorization': token == null ? "" : "Bearer $token",
              },
              sendTimeout: Duration(milliseconds: receivingTimeOut),
              receiveTimeout: Duration(milliseconds: receivingTimeOut),
            ));
        //print(response);
      } on DioException catch (e) {
        log("Error :${e.response.toString()}");
        if (e.response?.statusCode == 403) {
          Utility().clearAll();
          getx.Get.offAll(const SignInScreen());
        }
        DialogHelper.showErrorDialog(
            title: "Server response", description: e.response?.data['message']);
      }
    } else {
      _noInternetConnection();
    }
    print(
        "API=======${NetworkStrings.API_BASE_URL + endPoint}\n\nrequest======$queryParameters\n\nresponse========== $response");

    return response;
  }

  ////////////////// Post Request /////////////////////////

  Future<Response?> postRequest({
    required String endPoint,
    Map<String, dynamic>? formData,
    bool isLoader = true,
  }) async {
    if (isLoader) {
      DialogHelper.showLoading();
    }
    Response? response;
    String? token = await Utility.getStringValue(NetworkStrings.token);

    if (await InternetConnectionChecker().hasConnection) {
      try {
        _dio?.options.connectTimeout = Duration(seconds: connectTimeOut);
        response = await _dio!.post(NetworkStrings.API_BASE_URL + endPoint,
            data: formData,
            cancelToken: _cancelRequestToken,
            options: Options(
                headers: {
                  'Accept': NetworkStrings.ACCEPT,
                  'Authorization': token == null ? "" : "Bearer $token",
                },
                sendTimeout:  Duration(milliseconds: receivingTimeOut),
                receiveTimeout: Duration(milliseconds: receivingTimeOut)));
        DialogHelper.hideLoading();
      } on DioException catch (e) {
        DialogHelper.hideLoading();
        print("$endPoint Dio: ${e.message}" );
        if (e.response?.statusCode == 403) {
          Utility().clearAll();
          getx.Get.offAll(const SignInScreen());
        }
        DialogHelper.showErrorDialog(
            title: "Server response", description: e.response?.data['message']);
      }
    } else {
      _noInternetConnection();
    }
    print(
        "API=======${NetworkStrings.API_BASE_URL + endPoint}\n\nrequest======$formData\n\nresponse========== $response");

    return response;
  }

  ////////////////// Delete Request /////////////////////////
  Future<Response?> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? formData,
    bool isLoader = true,
  }) async {
    if (isLoader) {
      DialogHelper.showLoading();
    }
    Response? response;
    String? token = await Utility.getStringValue(NetworkStrings.token);

    if (await InternetConnectionChecker().hasConnection) {
      try {
        _dio?.options.connectTimeout = Duration(milliseconds: connectTimeOut);
        response = await _dio!.delete(NetworkStrings.API_BASE_URL + endPoint,
            data: formData,
            queryParameters: formData,
            cancelToken: _cancelRequestToken,
            options: Options(
                headers: {
                  'Accept': NetworkStrings.ACCEPT,
                  'Authorization': token == null ? "" : "Bearer $token",
                },
                sendTimeout: Duration(milliseconds: receivingTimeOut),
                receiveTimeout: Duration(milliseconds: receivingTimeOut)));
        DialogHelper.hideLoading();
      } on DioException catch (e) {
        DialogHelper.hideLoading();
        print("$endPoint Dio: ${e.message}" );
        if (e.response?.statusCode == 403) {
          Utility().clearAll();
          getx.Get.offAll(const SignInScreen());
        }
        DialogHelper.showErrorDialog(
            title: "Server response", description: e.response?.data['message']);
      }
    } else {
      _noInternetConnection();
    }
    print(
        "API=======${NetworkStrings.API_BASE_URL + endPoint}\n\nrequest======$formData\n\nresponse========== $response");

    return response;
  }

  ////////////////// Put Request /////////////////////////
  Future<Response?> putRequest(
      {required String endPoint, Map<String, dynamic>? queryParameters}) async {
    Response? response;
    String? token = await Utility.getStringValue(NetworkStrings.token);

    if (await InternetConnectionChecker().hasConnection) {
      try {
        _dio?.options.connectTimeout = Duration(milliseconds: connectTimeOut);
        response = await _dio!.put(NetworkStrings.API_BASE_URL + endPoint,
            //queryParameters: queryParameters,
            data: queryParameters,
            cancelToken: _cancelRequestToken,
            options: Options(
                headers: {
                  'Accept': NetworkStrings.ACCEPT,
                  'Authorization': token == null ? "" : "Bearer $token",
                },
                sendTimeout: Duration(milliseconds: receivingTimeOut),
                receiveTimeout: Duration(milliseconds: receivingTimeOut)));
        //print(response);
      } on DioException catch (e) {
        print("$endPoint Dio: ${e.message}" );
        if (e.response?.statusCode == 403) {
          Utility().clearAll();
          getx.Get.offAll(const SignInScreen());
        }
        DialogHelper.showErrorDialog(
            title: "Error", description: e.response?.data['message']);
      }
    } else {
      _noInternetConnection();
    }
    if ((response?.statusCode ?? 0) <= 400) {
      DialogHelper.showErrorDialog(
          title: "Server response", description: response?.data["message"]);
    }
    return response;
  }

  Future<String?> uploadFile(File file, String type) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
      "type": type
    });
    DialogHelper.showLoading();
    Response? response;
    String? token = await Utility.getStringValue(NetworkStrings.token);

    if (await InternetConnectionChecker().hasConnection) {
      try {
        _dio?.options.connectTimeout = Duration(milliseconds: connectTimeOut);
        response = await _dio!.post(
            NetworkStrings.API_BASE_URL + NetworkStrings.uploadFile,
            data: formData,
            cancelToken: _cancelRequestToken,
            options: Options(
              headers: {
                'Accept': NetworkStrings.ACCEPT,
                'Authorization': token == null ? "" : "Bearer $token",
              },
              sendTimeout: Duration(milliseconds: receivingTimeOut),
              receiveTimeout: Duration(milliseconds: receivingTimeOut),
            ));
        DialogHelper.hideLoading();
      } on DioException catch (e) {
        DialogHelper.hideLoading();
        if (e.response?.statusCode == 403) {
          Utility().clearAll();
          getx.Get.offAll(const SignInScreen());
        }
        DialogHelper.showErrorDialog(
            title: "Server response", description: e.response?.data['message']);
      }
    } else {
      _noInternetConnection();
    }
   // print('=====================${response?.data["data"]["url"]}');
    return response?.data["data"]["url"];
  }

  Future<void> createReel(File file, dynamic payload,Function(int a,int b) call) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "video_file": await MultipartFile.fromFile(file.path, filename: fileName),
      /* "title": payload['title'],
      "content": payload['content'],
      "tag": payload['tag'],*/
      ...payload
    });
    //DialogHelper.showLoading();
    Response? response;
    String? token = await Utility.getStringValue(NetworkStrings.token);

    if (await InternetConnectionChecker().hasConnection) {
      try {
        _dio?.options.connectTimeout = Duration(milliseconds: connectTimeOut);
        response = await _dio!.post(
            NetworkStrings.API_BASE_URL + NetworkStrings.createReel,
            data: formData,
            cancelToken: _cancelRequestToken, onSendProgress:call ,
            options: Options(
              headers: {
                'Accept': NetworkStrings.ACCEPT,
                'Authorization': token == null ? "" : "Bearer $token",
              },
              sendTimeout: Duration(milliseconds: receivingTimeOut),
              receiveTimeout: Duration(milliseconds: receivingTimeOut),
            ));
        //DialogHelper.hideLoading();
      } on DioException catch (e) {
        DialogHelper.hideLoading();
        if (e.response?.statusCode == 403) {
          Utility().clearAll();
          getx.Get.offAll(const SignInScreen());
        }
        DialogHelper.showErrorDialog(
            title: "Server response", description: e.response?.data['message']);
      }
    } else {
      _noInternetConnection();
    }
    print('=====================${response?.data}');

  }

  ////////////////// No Internet Connection /////////////////////
  void _noInternetConnection() {
    DialogHelper.showErrorDialog( title : "Internet Connection!",description : NetworkStrings.NO_INTERNET_CONNECTION);
  }
}
