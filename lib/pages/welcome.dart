// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:swapme/app/routes/app_pages.dart';
import 'package:swapme/components/is_loading.dart';
import 'package:swapme/components/my_button.dart';
import 'package:swapme/components/my_textfield.dart';
import 'package:swapme/components/square_tile.dart';
import 'package:swapme/pages/login/controllers/login_controller.dart';

class WelcomeController extends GetxController {
  String email = '';

  @override
  void onReady() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && user.emailVerified) {
        Get.offNamed(Routes.BASE);
      }
    });
    super.onReady();
  }
}

class WelcomePage extends GetView<WelcomeController> {
  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final double _sigmaX = 5;
  // from 0-10
  final double _sigmaY = 5;
  // from 0-10
  final double _opacity = 0.2;

  //final double _width = 350;
  final _formKey = GlobalKey<FormState>();

  final RxBool isValidForm = RxBool(false);

  WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final WelcomeController controller = Get.put(WelcomeController());
    final LoginController controllerLogin = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/vids/fondo.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                  const Text(
                    "Hi !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ClipRect(
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 1)
                                .withOpacity(_opacity),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Form(
                          key: _formKey,
                          onChanged: () => isValidForm.value =
                              _formKey.currentState?.validate() ?? false,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // username textfield
                                MyTextField(
                                  controller: usernameController,
                                  hintText: 'Email',
                                  obscureText: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    if (!value.isEmail) {
                                      return 'Please enter an email valid';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 10),

                                // sign in button
                                Obx(
                                  () => isValidForm.value
                                      ? controllerLogin.isLoading.value
                                          ? const IsLoading()
                                          : MyButton(
                                              onTap: () async {
                                                controller.email =
                                                    usernameController.text;
                                                controllerLogin.user.email =
                                                    usernameController.text;

                                                final isRegister =
                                                    await controllerLogin
                                                        .isRegisterEmail();
                                                if (!isRegister) {
                                                  await Get.snackbar(
                                                    'Login incorrect',
                                                    'Dont have user with email. Maybe your account is not active or go to signup :)',
                                                    duration:
                                                        Duration(seconds: 2),
                                                    backgroundColor: Colors.red,
                                                    colorText: Colors.white,
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                  ).future;
                                                  controllerLogin
                                                      .isLoading.value = false;
                                                  return;
                                                }

                                                controllerLogin
                                                    .isLoading.value = false;
                                                Get.toNamed(Routes.LOGIN);
                                              },
                                            )
                                      : SizedBox(),
                                ),

                                const SizedBox(height: 10),
                                // not a member? register now
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Text(
                                              'Don\'t have an account?',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                              textAlign: TextAlign.start,
                                            ),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () =>
                                                    Get.toNamed(Routes.SIGNUP),
                                                child: Text(
                                                  'Sign Up',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 71, 233, 133),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     print('Restore password');

                                      //   },
                                      //   child: const Text('Forgot Password?',
                                      //       style: TextStyle(
                                      //           color: Color.fromARGB(
                                      //               255, 71, 233, 133),
                                      //           fontWeight: FontWeight.bold,
                                      //           fontSize: 20),
                                      //       textAlign: TextAlign.start),
                                      // ),
                                    ],
                                  ),
                                ),
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
