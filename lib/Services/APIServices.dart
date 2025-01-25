import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:homworkprojectapi/Constants.dart';

import '../Controllers/LoginController.dart';

class DioClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Constants.APIUrl, // Replace with your API base URL
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
  ));

  DioClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        //print(options);
        // Add access token to headers
        final token = Get.find<LoginController>().accessTokenval;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        print("aaaaaaaaaaaaaaaaaaaaaaaaa${e}");

        // Handle 401 errors (e.g., token expiration)
        if (e.response?.statusCode == 401) {
          Get.find<LoginController>().refreshToken();

        }
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;
}
