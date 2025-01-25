import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homworkprojectapi/Controllers/LoginController.dart';

class SignIn extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController passWordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
  final LoginController loginControleer = Get.put(LoginController());
    return Scaffold(
      // backgroundColor: Colors.lightBlue,
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 9.0,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.lightBlue,
                    Colors.white,
                    Color.fromRGBO(0, 0, 255, 0.6)
                  ]),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(1, 0),
                  spreadRadius: 1,
                  blurRadius: 10,
                ),
              ],
              border: Border.all(color: Colors.lightBlue, width: 2),
              borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.88,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.lightBlue[200],
                    child: Icon(Icons.person, size: 60),
                    maxRadius: 50),
                Container(
                  child: Text(
                    "LogIn Page",
                    style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 3,
                        color: Colors.blue,
                        shadows: [
                          BoxShadow(color: Colors.black, offset: Offset(1, 1))
                        ]),
                  ),
                ),
                TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.email, color: Color.fromRGBO(0, 0, 255, 1)),
                    label: Text("Email"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter The Email";
                    }
                    return null;
                  },
                ),
                Obx(() => TextFormField(
                      controller: passWordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color.fromRGBO(40, 40, 224, 1),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            loginControleer.togglePasswordVisiablity();
                          },
                          icon: Icon(loginControleer.isPwsswordVisable.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: Colors.blue,
                        ),
                        label: Text("Password"),
                      ),
                      obscureText: !loginControleer.isPwsswordVisable.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Add the Data";
                        }
                        if (value.length <= 6) {
                          return "Please Enter Correct Password";
                        }
                        return null;
                      },
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStatePropertyAll(Colors.blue)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final email = userNameController.text;
                        final password = passWordController.text;
                        loginControleer.login(email, password);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Sign In",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        Icon(
                          Icons.login,
                          size: 30,
                          color: Color.fromRGBO(0, 0, 255, 1),
                        ),
                      ],
                    ))
                // oa800930@gmail.com osama123
                // TuhaifButton(
                //   border: 1,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Text(
                //         "Sign In",
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //             fontSize: 20, fontWeight: FontWeight.w800),
                //       ),
                //       Icon(
                //         Icons.login,
                //         size: 30,
                //         color: Color.fromRGBO(0, 0, 255, 1),
                //       ),
                //     ],
                //   ),
                //   redus: 100,
                //   margin: 0,
                //   padding: 0,
                //   onTab: () {

                //   },
                //   backgroundColor: Colors.lightBlue,
                // ),
                ,
                SizedBox(
                    //  height: 50,
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
