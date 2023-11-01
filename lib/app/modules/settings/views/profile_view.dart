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
                            label: 'Nombre',
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
                            label: 'Apellido',
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: genere.text,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green.shade400),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                              ),
                              hintText: 'Genero',
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
