// ignore_for_file: file_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swapme/components/my_button.dart';
import 'package:swapme/components/my_textfield.dart';
import 'package:swapme/pages/login/controllers/login_controller.dart';

class ConfirmRestorePassword extends GetView<LoginController> {
  final double _sigmaX = 5; // from 0-10
  final double _sigmaY = 5; // from 0-10
  final double _opacity = 0.2;

  final RxBool isValid = RxBool(false);

  final _formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
  final passwordController = TextEditingController();

  ConfirmRestorePassword({super.key});

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
                'assets/vids/fondo.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: Get.back,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const Text(
                    "Log in",
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 0, 0, 1)
                              .withOpacity(_opacity),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        // height: MediaQuery.of(context).size.height * 0.5,
                        child: Form(
                          key: _formKey,
                          onChanged: () {
                            isValid.value =
                                _formKey.currentState?.validate() ?? false;
                            debugPrint('$isValid');
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                MyTextField(
                                  controller: codeController,
                                  hintText: 'Code',
                                  obscureText: false,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    if (!val.isEmail) {
                                      return 'Please enter a valida email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                MyTextField(
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Obx(
                                  () => isValid.value
                                      ? MyButtonAgree(
                                          text: "Restore Password",
                                          onTap: () async {
                                            // ignore: avoid_print
                                            print(codeController.text);
                                            // ignore: avoid_print
                                            print(passwordController.text);
                                          },
                                        )
                                      : const SizedBox(),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
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
