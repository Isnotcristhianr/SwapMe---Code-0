import 'dart:ui';

import 'package:get/get.dart';
import 'package:swapme/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:swapme/components/image_selector.dart';
import 'package:swapme/components/is_loading.dart';
import 'package:swapme/components/my_button.dart';
import 'package:swapme/components/my_textfield.dart';
import 'package:swapme/pages/signup/controllers/signup_controller.dart';
import 'package:swapme/pages/welcome.dart';

class Signup extends GetView<SignUpController> {
  Signup({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final genere = TextEditingController(text: 'Masculino');
  final photoController = TextEditingController();

  final double _sigmaX = 5; // from 0-10
  final double _sigmaY = 5; // from 0-10
  final double _opacity = 0.2;

  final _formKey = GlobalKey<FormState>();
  final RxBool isValidForm = RxBool(false);

  @override
  Widget build(BuildContext context) {
    final buttonAgree = MyButtonAgree(
      text: "Agree and Continue",
      onTap: () async {
        controller.user.name = nameController.text;
        controller.user.lastName = lastNameController.text;
        controller.user.email = emailController.text;
        controller.user.phone = phoneController.text;
        controller.user.genere = genere.text;
        controller.user.password = passwordController.text;
        controller.user.photo = photoController.text;
        bool isRegister = await controller.registerUser();

        await Get.snackbar(
          isRegister ? 'Register correct' : 'Register incorrect',
          controller.messageToDisplay,
          duration: const Duration(seconds: 2),
          backgroundColor: isRegister ? Colors.green : Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        ).future;
        controller.isLoading.value = false;
        if (isRegister) {
          WelcomeController welcomeController = Get.find();
          welcomeController.email = controller.user.email!;
          Get.offNamed(Routes.LOGIN);
        } else {}
      },
    );

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        bottom: false,
        top: false,
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
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: Get.back,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.05,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 0, 0, 1)
                              .withOpacity(_opacity),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            onChanged: () => isValidForm.value =
                                _formKey.currentState?.validate() ?? false,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // const SizedBox(height: 10),
                                  const Text(
                                    "Look like you don't have an account. Let's create a new account for",
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    textAlign: TextAlign.start,
                                  ),
                                  ImageSelector(controller: photoController),
                                  const SizedBox(height: 10),
                                  MyTextField(
                                    controller: nameController,
                                    onChanged: (value) =>
                                        controller.user.name = value,
                                    hintText: 'Name',
                                    obscureText: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  MyTextField(
                                    controller: lastNameController,
                                    onChanged: (value) =>
                                        controller.user.lastName = value,
                                    hintText: 'Lastname',
                                    obscureText: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  MyTextField(
                                    controller: emailController,
                                    onChanged: (value) =>
                                        controller.user.email = value,
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
                                  MyTextField(
                                    controller: phoneController,
                                    hintText: 'Phone',
                                    obscureText: false,
                                    maxLength: 13,
                                    onChanged: (value) =>
                                        controller.user.phone = value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      if (!value.isPhoneNumber) {
                                        return 'Please enter an email valid';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  DropdownButtonFormField<String>(
                                    value: genere.text,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400),
                                      ),
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                      hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    items: ['Masculino', 'Femenino']
                                        .map(
                                          (e) => DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(
                                              e.toString(),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) => genere.text = value!,
                                  ),
                                  const SizedBox(height: 10),
                                  MyPasswordTextField(
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) =>
                                        controller.user.password = value,
                                    hintText: 'Password',
                                    obscureText: true,
                                  ),
                                  const SizedBox(height: 16),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      RichText(
                                        text: const TextSpan(
                                          text: '',
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  'By selecting Agree & Continue below, I agree to our ',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  'Terms of Service and Privacy Policy',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 71, 233, 133),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Obx(
                                        () => isValidForm.value
                                            ? controller.isLoading.value
                                                ? const IsLoading()
                                                : buttonAgree
                                            : const SizedBox(),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
    );
  }
}
