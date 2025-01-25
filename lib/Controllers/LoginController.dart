import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:homworkprojectapi/Constants.dart';
import 'package:homworkprojectapi/Services/APIServices.dart';
import 'package:homworkprojectapi/Services/TokenStorage.dart';
import 'package:homworkprojectapi/models/LoginResponseModel.dart';
import 'package:homworkprojectapi/views/Home.dart';
import 'package:homworkprojectapi/views/SignIn.dart';

class LoginController extends GetxController {
  String? accessTokenval;
  String? refereshToken;
  final DioClient _dioClient = DioClient();

  @override
  void onInit() async {
    super.onInit();
    accessTokenval = await TokenStorage.getAccessToken();
    refereshToken = await TokenStorage.getRefreshToken();

    if (accessTokenval != null && _isTokenValid(accessTokenval!)) {
      Get.offAll(HomePage());
    }

    // accessToken=await TokenStorage.getAccess
  }

  var isPwsswordVisable = false.obs;

  void togglePasswordVisiablity() {
    isPwsswordVisable.toggle();
  }

  Future<void> refreshToken() async {
    final url = Constants.refreshToken;

    try {
      final response = await _dioClient.dio.post(
        url,
        data: {
          "token":
              refereshToken, // لا حاجة لقراءة التوكن مجددًا إذا تم تخزينه في `onInit`
        },
      );

      if (response.statusCode == 200) {
        accessTokenval = response.data['token'];
        await TokenStorage.saveToken(accessTokenval!, refereshToken!);
      } else {
        print('Failed to refresh token: ${response.statusCode}');
        _logout(); // تسجيل الخروج إذا فشل التحديث
      }
    } catch (e) {
      print("Error refreshing token: $e");
      _logout(); // تسجيل الخروج عند حدوث خطأ
    }
  }

  void _logout() {
    accessTokenval = null;
    refereshToken = null;
    TokenStorage.clearTokens(); // حذف التوكنات من التخزين
    Get.offAll(SignIn());
  }

  // Future<void> refreshToken() async {
  //   final url = Constants.refreshToken; // Replace with your refresh endpoint

  //   try {
  //     final response = await _dioClient.dio.post(
  //       url,
  //       data: {
  //         "token": await TokenStorage.getRefreshToken(),
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       accessTokenval = response.data['token'];

  //       // Update stored access token
  //       await TokenStorage.saveToken(accessTokenval!, refereshToken!);
  //     } else {
  //       print(response.statusCode);
  //       Get.snackbar("Error", "Failed to refresh token",
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   } catch (e) {
  //     print(e);
  //     Get.snackbar("Error", "Failed to refresh token",
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

//   Future<void> login(String email, String password) async {
//     final url = Constants.SignIn;

//     try {
//       final response = await _dioClient.dio
//           .post(url, data: {"email": "$email", "password": "$password"});
//       if (response.statusCode == 200) {
//         print(response);
//         final loginResponse = LoginResponseM.fromJson(response.data);
//         accessTokenval = loginResponse.accessToken;
//         refereshToken = loginResponse.refereshToken;

//         await TokenStorage.saveToken(accessTokenval!, refereshToken!);
//         Get.snackbar("Success", "Login Successfull",
//             snackPosition: SnackPosition.BOTTOM);
//         Get.offAll(HomePage());
//       } else {
//         Get.snackbar("Faild", "Login Faild",
//             snackPosition: SnackPosition.BOTTOM);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }

  Future<void> login(String email, String password) async {
    final url = Constants.SignIn;

    try {
      final response = await _dioClient.dio.post(
        url,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final loginResponse = LoginResponseM.fromJson(response.data);
        accessTokenval = loginResponse.accessToken;
        refereshToken = loginResponse.refereshToken;

        await TokenStorage.saveToken(accessTokenval!, refereshToken!);
        Get.snackbar("Success", "Login Successful",
            snackPosition: SnackPosition.BOTTOM);
        Get.offAll(HomePage());
      } else {
        Get.snackbar("Failed", response.data['message'] ?? "Login Failed",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print("Error during login: $e");
      Get.snackbar("Error", "Something went wrong. Please try again.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  bool _isTokenValid(String token) {
    try {
      final payload = JwtDecoder.decode(token);
      final expiryDate =
          DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      return DateTime.now().isBefore(expiryDate);
    } catch (e) {
      print("Invalid token: $e");
      return false;
    }
  }
}
