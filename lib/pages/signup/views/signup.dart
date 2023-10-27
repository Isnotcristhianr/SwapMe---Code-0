import 'dart:ui';

import 'package:get/get.dart';
import 'package:swapme/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
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
      text: "Aceptar y continuar",
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
          isRegister ? 'Registro Correcto' : 'Registro Incorrecto',
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
                  "Registro",
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
                        width: MediaQuery.of(context).size.width * 0.9,
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
                                   const SizedBox(height: 10),
                                 
                                  const SizedBox(height: 15),
                                 // ImageSelector(controller: photoController),
                                  const SizedBox(height: 15),
                                  MyTextField(
                                    controller: nameController,
                                    onChanged: (value) =>
                                        controller.user.name = value,
                                    hintText: 'Nombre',
                                    obscureText: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Ingresa un texto';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  MyTextField(
                                    controller: lastNameController,
                                    onChanged: (value) =>
                                        controller.user.lastName = value,
                                    hintText: 'Apellido',
                                    obscureText: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Ingresa un texto';
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
                                        return 'Ingresa un texto';
                                      }
                                      if (!value.isEmail) {
                                        return 'Ingresa un Email valido';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  MyTextField(
                                    controller: phoneController,
                                    hintText: 'Teléfono (codigo no uses +)',
                                    obscureText: false,
                                    maxLength: 13,
                                    onChanged: (value) =>
                                        controller.user.phone = value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Ingresa un texto';
                                      }
                                      if (!value.isPhoneNumber) {
                                        return 'Ingresa un numero valido';
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
                                    items: ['Masculino', 'Femenino', 'Prefiero no decirlo']
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
                                        return 'Ingresa un texto';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) =>
                                        controller.user.password = value,
                                    hintText: 'Contraseña',
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
                                                  'Para continuar, aceptas las normas de SwapMe',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '\n',
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
