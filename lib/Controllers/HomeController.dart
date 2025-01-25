import 'package:get/get.dart';
import 'package:homworkprojectapi/Constants.dart';
import 'package:homworkprojectapi/Services/APIServices.dart';
import 'package:homworkprojectapi/models/StudentsModel.dart';

class HomeController extends GetxController {
  var students = <StudentsModel>[].obs;
  var isLoading = true.obs;

  final DioClient _dio = DioClient();

  @override
  void onInit() {
    super.onInit();
    
    fetchStudents();
  }

  // Future<List<StudentsModel>> fetchUsers() async {
  //   try {
  //     final response = await _dio.dio.get(Constants.getallStudents); // Replace '/users' with your API endpoint
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = response.data;
  //       return data.map((json) => StudentsModel.fromJson(json)).toList();
  //     } else {
  //       throw Exception('Failed to load users');
  //     }
  //   } catch (e) {
  //     print('Error fetching users: $e');
  //     rethrow;
  //   }
  // }

  Future<void> fetchStudents() async {
    try {
      isLoading(true);
      final respons = await _dio.dio.get(Constants.getallStudents);
      if (respons.statusCode == 200) {
        students.value = (respons.data as List)
            .map((json) => StudentsModel.fromJson(json))
            .toList();
      } else {
        Get.snackbar("Error", "Failed to fetch subjects",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print("Error Fetching Data: $e");
      Get.snackbar("Error", "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
