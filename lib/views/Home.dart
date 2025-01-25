import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:homworkprojectapi/Controllers/HomeController.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var students = controller.students;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("قائمة الطلاب",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 255, 1),
                        blurRadius: 2,
                        offset: Offset(1, 2))
                  ])),
          backgroundColor: Colors.lightBlue,
        ),
        body: Container(child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlue,
              ),
            );
          }
          if (controller.students.isEmpty) {
            return const Center(
              child: Text(
                "There is no Students",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            );
          }
          return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: controller.students.length,
              itemBuilder: (_, index) {
                return ListTile(
                  
                  selectedColor: Colors.green,
                  onTap: () {
                    Get.snackbar("الطالب",
                        students[index].fName + " " + students[index].lName,
                        backgroundColor: Color.fromRGBO(0, 255, 0, 0.4),
                        snackPosition: SnackPosition.BOTTOM);
                  },
                  tileColor: Colors.blue,
                  shape: ShapeBorder.lerp(
                      Border.all(
                        color: Color.fromRGBO(0, 0, 255, 1),
                        width: 2,
                      ),
                      BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      20),
                  title: Text(
                    '${students[index].fName} ${students[index].lName} ',
                  ),
                  subtitle: FittedBox(
                      child:
                          Text(' تاريخ الميلاد: ${students[index].birthDate}')),
                  leading: CircleAvatar(
                    child: Icon(Icons.boy),
                  ),
                  trailing: CircleAvatar(
                    child: IconButton(icon:Icon( Icons.delete, color:Colors.white), onPressed: (){},)
                  ),
                );
              });
        })),
      ),
    );
  }
}
