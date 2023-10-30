import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:swapme/app/components/screen_title.dart';
import 'package:swapme/app/modules/product_details/views/widgets/rounded_button.dart';
import 'package:swapme/app/modules/settings/controllers/settings_controller.dart';
import 'package:swapme/app/routes/app_pages.dart';
import 'package:swapme/components/image_selector.dart';
import 'package:swapme/components/my_button.dart';
import 'package:swapme/components/my_textfield.dart';
import 'package:swapme/utils/constants.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ProfileScreen extends GetView<SettingsController> {
  ProfileScreen({super.key});

  final emailController = TextEditingController(
      text: Get.find<SettingsController>().user.value.email);
  final passwordController = TextEditingController(
      text: Get.find<SettingsController>().user.value.password);
  final nameController = TextEditingController(
      text: Get.find<SettingsController>().user.value.name);
  final lastNameController = TextEditingController(
      text: Get.find<SettingsController>().user.value.lastName);
  final phoneController = TextEditingController(
      text: Get.find<SettingsController>().user.value.phone);
  final genere = TextEditingController(
      text: Get.find<SettingsController>().user.value.genere);

  final TextEditingController photoController = TextEditingController(
    text: Get.find<SettingsController>().user.value.photo,
  );

  final _formKey = GlobalKey<FormState>();
  final RxBool isValidForm = RxBool(false);

  @override
  Widget build(BuildContext context) {
    // Init

    final buttonAgree = MyButtonAgree(
      text: "Actualizar datos",
      onTap: () async {
        controller.user.value.name = nameController.text;
        controller.user.value.lastName = lastNameController.text;
        controller.user.value.email = emailController.text;
        controller.user.value.phone = phoneController.text;
        controller.user.value.password = passwordController.text;
        controller.newImage = photoController.value.text;

        bool isUpdated = await controller.updateUser();
        await Get.snackbar(
          isUpdated ? 'Updated correct' : 'Updated incorrect',
          controller.messageToDisplay,
          duration: const Duration(seconds: 2),
          backgroundColor: isUpdated ? Colors.blue : Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        ).future;
        controller.isLoading.value = false;
        if (isUpdated) {
          //
          Get.offAndToNamed(Routes.BASE);
        } else {
          // ignore: avoid_print
          print(controller.user.value.toJSON());
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                RoundedButton(
                  onPressed: () => Get.back(),
                  child: SvgPicture.asset(
                    Constants.backArrowIcon,
                    fit: BoxFit.none,
                  ),
                ),
                const SizedBox(height: 15),
                const ScreenTitle(
                  title: 'Perfil',
                  dividerEndIndent: 1,
                ),
                5.verticalSpace,
                Form(
                  key: _formKey,
                  onChanged: () => isValidForm.value =
                      (_formKey.currentState?.validate() ?? false),
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ImageSelector(
                            controller: photoController,
                            onChange: () => isValidForm.value =
                                phoneController.text.isNotEmpty,
                          ),
                          5.verticalSpace,
                          MyTextField(
                            controller: nameController,
                            onChanged: (value) =>
                                controller.user.value.name = value,
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
                                controller.user.value.lastName = value,
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
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              var num = number.phoneNumber ?? '';
                              //eliminar el + del numero de telefono
                              num = num.replaceAll('+', '');
                              controller.user.value.phone = num;
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.DIALOG,
                            ),
                            ignoreBlank: false,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            selectorTextStyle:
                                const TextStyle(color: Colors.grey),
                            formatInput: false,
                            keyboardType: TextInputType.phone,
                            inputDecoration: InputDecoration(
                              hintText: 'Ingrese su número',
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                            ),
                            onFieldSubmitted: (String value) {
                              if (value.isEmpty) {
                              } else {
                                // Realiza la validación personalizada aquí si es necesario
                                if (!value.isPhoneNumber) {
                                  // El número de teléfono no es válido
                                  // Muestra un mensaje de error al usuario
                                  Get.snackbar(
                                    'Número de teléfono inválido',
                                    'Por favor, ingresa un número de teléfono válido.',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                } else {
                                  //envio numero de telefono, codigo sin + y numero
                                  // ignore: avoid_print
                                  print('Número de teléfono válido');
                                  //ver num
                                  // ignore: avoid_print
                                  print(controller.user.value.phone);
                                }
                              }
                            },
                          ),
                          MyTextField(
                            controller: phoneController,
                            hintText: 'Phone',
                            obscureText: false,
                            maxLength: 10,
                            onChanged: (value) =>
                                controller.user.value.phone = value,
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
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                            items:
                                ['Masculino', 'Femenino', 'Prefiero no decirlo']
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
                          10.verticalSpace,
                          Obx(
                            () => isValidForm.value
                                ? controller.isLoading.value
                                    ? const MyButton(
                                        onTap: null,
                                        text: 'Loading...',
                                      )
                                    : buttonAgree
                                : const SizedBox(),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
