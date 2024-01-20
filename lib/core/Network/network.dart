import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dioClient;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Util/SharedPrefernce.dart';
import '../../features/Login/data/remote/models/login_model.dart';
import '../../features/Login/presentation/manager/LoginViewModel.dart';
import '../../features/Login/presentation/pages/login_page.dart';
import '../../injection_container.dart';
import '../../main.dart';
import '../constant.dart';

class Network {
  final appId = "55bb914927d3496483de63aecd52312a";
  final certId = "31f34774626d40818e322613605dbed9";

  final endPoint = "https://school.awaelps.com/api/";
  final baseEndPoint = "https://school.awaelps.com/";
//  final endPoint = "http://your-schools.elmotahda.site/api/";
//  final baseEndPoint = "http://your-schools.elmotahda.site/";
  final _log = Logger('Network');

  //2
  Network();

  final Map<String, String> headers = {
    'Accept': 'application/json',
  };

  // 3
  Future getData(
      {required String url,
      String? token,
      String removeNotificationType = "",
      bool removeAllNotifications = false,
      bool removeNotifications = false,
      bool isPrint = true}) async {
    if (removeNotifications) {
      _log.info('Calling uri: ${endPoint + url}' +
          (url.contains('?')
              ? '&remove-notifications=${removeAllNotifications ? "all" : "true"}${removeAllNotifications ? "" : "&notifications-type=$removeNotificationType"}'
              : '?remove-notifications=${removeAllNotifications ? "all" : "true"}${removeAllNotifications ? "" : "&notifications-type=$removeNotificationType"}'));
    } else {
      _log.info('Calling uri: ${endPoint + url}');
    }
    if (token != null) {
      _log.info(url);
      _log.info('token >>> $token');
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    headers.addAll({'Accept-Language': locale.value.languageCode.toString()});
    // 4
    String urls;
    if (removeNotifications) {
      urls = endPoint +
          url +
          (url.contains('?')
              ? '&remove-notifications=${removeAllNotifications ? "all" : "true"}${removeAllNotifications ? "" : "&notifications-type=$removeNotificationType"}'
              : '?remove-notifications=${removeAllNotifications ? "all" : "true"}${removeAllNotifications ? "" : "&notifications-type=$removeNotificationType"}');
    } else {
      urls = endPoint + url;
    }
    // print('urls alooo : ${Uri.parse(urls)} __----__ headers alooo : ${headers}');
    Response response = await get(Uri.parse(urls), headers: headers);

    // 5
    if (response.statusCode == 200) {
      // 6
      if (isPrint) {
        _log.fine(response.body);
      }
    } else {
      _log.severe(response.statusCode);
      _log.severe(response.body);
      errorHandler(response.body, response.statusCode);
    }
    return response;
  }

  Future<Response> postData(
      {required String url,
      dynamic body,
      String? token,
      bool showError = false,
      bool handleError = true,
      bool contentType = false}) async {
    _log.info('Calling uri: ${endPoint + url}');
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    if (contentType) {
      headers.addAll({'Content-Type': 'application/json'});
    }
    headers.addAll({'Accept-Language': locale.value.languageCode.toString()});
    Response response =
        await post(Uri.parse(endPoint + url), body: body, headers: headers);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      // 6

      _log.fine(response.body + response.statusCode.toString());
    } else {
      _log.severe(response.statusCode);
      log('.request ENDPOINT ${endPoint + url}  request BODY $body  response.body.toString(). ${response.body.toString()}');
      if (showError) {
        errorHandler(response.body, response.statusCode, showError: true);
      }
    }
    return response;
  }

  Future<dioClient.Response> postDataWithDio(
      {required String url,
      dynamic body,
      String? token,
      bool handleError = true,
      bool contentType = false}) async {
    _log.info('Calling uri: ${endPoint + url}');
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    if (contentType) {
      headers.addAll({'Content-Type': 'application/json'});
    }
    headers.addAll({'Accept-Language': locale.value.languageCode.toString()});

    var formData = dioClient.FormData.fromMap(body);

    dioClient.Dio dio = dioClient.Dio();
    dioClient.Response response = await dio.post("$endPoint$url",
        data: formData, options: dioClient.Options(headers: headers));

    log('.request ENDPOINT ${endPoint + url}  request BODY ${formData.fields}  response.body.toString(). ${response.data.toString()}');
    // Response response =
    //     await post(Uri.parse(endPoint + url), body: body, headers: headers);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      // 6

      _log.fine('${response.data} + "${response.statusCode.toString()}"');
    } else {
      _log.severe(response.statusCode);
    }
    return response;
  }

  Future<Response> putData(
      {required String url, dynamic body, String? token}) async {
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    headers.addAll({'Accept-Language': locale.value.languageCode.toString()});
    Response response =
        await put(Uri.parse(endPoint + url), body: body, headers: headers);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      // 6
      _log.fine(response.body + response.statusCode.toString());
    } else {
      _log.severe(response.statusCode);
      _log.severe(response.body);
      errorHandler(response.body, response.statusCode);
    }
    return response;
  }

  Future<Response> deleteData(
      {required String url,
      dynamic body,
      String? token,
      bool handleError = true,
      bool contentType = false}) async {
    _log.info('Calling uri: ${endPoint + url}');
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    if (contentType) {
      headers.addAll({'Content-Type': 'application/json'});
    }
    headers.addAll({'Accept-Language': locale.value.languageCode.toString()});
    Response response =
        await delete(Uri.parse(endPoint + url), body: body, headers: headers);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      // 6
      _log.fine(response.body + response.statusCode.toString());
    } else {
      _log.severe(response.statusCode);
      log('.request ENDPOINT ${endPoint + url}  request BODY $body  response.body.toString(). ${response.body.toString()}');

      //  errorHandler(response.body, response.statusCode);
    }
    return response;
  }

  Future<Response> patchData(
      {required String url, dynamic body, String? token}) async {
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    headers.addAll({'Accept-Language': locale.value.languageCode.toString()});
    Response response =
        await patch(Uri.parse(endPoint + url), body: body, headers: headers);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      // 6
      _log.fine(response.body + response.statusCode.toString());
    } else {
      _log.severe(response.statusCode);
      _log.severe(response.body);
      errorHandler(response.body, response.statusCode);
    }
    return response;
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? notificationToken;
  Future updateFcmToken(BuildContext context) async {
    //  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notificationToken = await _firebaseMessaging.getToken();
    log("Notification token $notificationToken");
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    headers.addAll({'Authorization': 'Bearer ${cToken ?? model!.token!}'});
    headers.addAll({'Accept-Language': locale.value.languageCode.toString()});

    Response response = await put(Uri.parse(endPoint + "fcm_token/update"),
        body: {
          //     'old_token': '${json.decode(profileResponse.body)['token'] ?? ""}',
          'new_token': '$notificationToken',
        },
        headers: headers);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      // 6
      _log.fine(response.body + response.statusCode.toString());
    } else {
      _log.severe(response.statusCode);
      _log.severe(response.body);
      errorHandler(response.body, response.statusCode);
    }
    return response;
    // } catch (e) {
    //   return e;
    // }
  }

  void errorHandler(String? errorBody, int statusCode,
      {bool showError = false}) {
    String message = "";

//      toast("$code")

    if (statusCode == 401) {
      SharedPreference.clearSharedPrefrence();
      Navigator.pushReplacement(
        mainNavigatorKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => sl<LoginViewModel>(),
            child: LoginPage(),
          ),
        ),
      );
    }
    if (errorBody != null) {
      String body = errorBody;
      var jsonObject = jsonDecode(body);
      Map<String, dynamic>? jsonObjectErrors = jsonObject['errors'];
      if (jsonObjectErrors != null) {
        message = jsonObject['message'];
        var keys = jsonObjectErrors.keys;
        for (String key in keys) {
          // loop to get the dynamic key
          _log.info(key);
          // get the value of the dynamic key
          if (message.isNotEmpty) {
            if (showError) {
              message = '${jsonObjectErrors[key][0]}';
            } else {
              message = '$message . ${jsonObjectErrors[key][0]}';
            }
          } else {
            message = jsonObjectErrors[key][0].toString();
          }
        }
        Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
        _log.warning(message);
      } else {
        Fluttertoast.showToast(
            msg: 'هناك خطا ما', toastLength: Toast.LENGTH_SHORT);
        _log.warning(body);
      }
      // do something here with the value...
    }
  }
}
