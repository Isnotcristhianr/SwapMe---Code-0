// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swapme/app/modules/base/controllers/base_controller.dart';
import 'package:swapme/app/routes/app_pages.dart';
import 'package:swapme/components/is_loading.dart';
import 'package:swapme/components/my_button.dart';

import 'package:swapme/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:swapme/pages/login/controllers/login_controller.dart';
import 'package:swapme/pages/welcome.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  // Get controller general
  final WelcomeController welcomeController = Get.find();

  // text editing controllers
  final passwordController = TextEditingController();

  final double _sigmaX = 5; // from 0-10
  final double _sigmaY = 5; // from 0-10
  final double _opacity = 0.2;

  final _formKey = GlobalKey<FormState>();
  final RxBool isValidForm = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // background image local
              Image.asset(
                'assets/images/welcomev2.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  40.verticalSpace,
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: Get.back,
                  ),
                  100.verticalSpace,
                  const Text("Inicio de sesión",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ClipRect(
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 1)
                                .withOpacity(_opacity),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Form(
                          key: _formKey,
                          onChanged: () => isValidForm.value =
                              _formKey.currentState?.validate() ?? false,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            'https://cdn-icons-png.flaticon.com/512/3641/3641963.png'),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            welcomeController.email,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 0.035 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            welcomeController.email,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 0.03 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                MyPasswordTextField(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  obscureText: true,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                20.verticalSpace,
                                Obx(
                                  () => isValidForm.value
                                      ? controller.isLoading.value
                                          ? IsLoading()
                                          : MyButtonAgree(
                                              text: "Continue",
                                              onTap: () async {
                                                String password =
                                                    passwordController.text;
                                                controller.user.password =
                                                    password;
                                                controller.user.email =
                                                    welcomeController.email;

                                                bool isAuth =
                                                    await controller.login();

                                                if (isAuth) {
                                                  await Get.snackbar(
                                                    'Login correct',
                                                    'Credenciales correctas',
                                                    duration:
                                                        Duration(seconds: 2),
                                                    backgroundColor:
                                                        Colors.green,
                                                    colorText: Colors.white,
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                  ).future;
                                                  controller.isLoading.value =
                                                      false;
                                                  Get.put(BaseController());
                                                  Get.toNamed(Routes.BASE);
                                                } else {
                                                  await Get.snackbar(
                                                    'Login incorrect',
                                                    controller.messageToDisplay,
                                                    duration:
                                                        Duration(seconds: 2),
                                                    backgroundColor: Colors.red,
                                                    colorText: Colors.white,
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                  ).future;
                                                  controller.isLoading.value =
                                                      false;
                                                }
                                              },
                                            )
                                      : const SizedBox(),
                                ),
                                10.verticalSpace,
                                Obx(
                                  () => controller.isLoading.value
                                      ? const SizedBox()
                                      : GestureDetector(
                                          onTap: () async {
                                            controller.user.email =
                                                welcomeController.email;
                                            final isSent = await controller
                                                .restorePassword();
                                            await Get.snackbar(
                                              'Restore password',
                                              controller.messageToDisplay,
                                              duration: Duration(seconds: 2),
                                              backgroundColor: isSent
                                                  ? Colors.green
                                                  : Colors.red,
                                              colorText: Colors.white,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                            ).future;
                                            controller.isLoading.value = false;
                                          },
                                          child: Text(
                                            'Olvidaste la Contraseña?',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 71, 233, 133),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                ),
                                10.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
