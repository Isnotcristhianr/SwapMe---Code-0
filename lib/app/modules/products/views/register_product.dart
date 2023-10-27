import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:swapme/app/components/screen_title.dart';

import 'package:swapme/app/modules/product_details/views/widgets/rounded_button.dart';
import 'package:swapme/app/modules/products/controllers/product_controller.dart';
import 'package:swapme/app/routes/app_pages.dart';
import 'package:swapme/components/image_selector.dart';
import 'package:swapme/components/is_loading.dart';
import 'package:swapme/components/my_button.dart';
import 'package:swapme/components/my_textfield.dart';
import 'package:swapme/utils/constants.dart';

class RegisterProductScreen extends GetView<ProductController> {
  RegisterProductScreen({super.key});

  final controllerName = TextEditingController();
  final controllerImage = TextEditingController();
  final controllerReview = TextEditingController(text: 'Sin review');
  final controllerPrice = TextEditingController();
  final controllerQuantity = TextEditingController();
  final controllerRaiting = TextEditingController(text: '1.0');
  final controllerSize = TextEditingController(text: 'S');

  final GlobalKey<FormState> myKeyForm = GlobalKey();
  final RxBool isValidForm = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const ScreenTitle(
                title: 'Register product',
                dividerEndIndent: 1,
              ),
              Form(
                key: myKeyForm,
                onChanged: () => isValidForm.value =
                    (myKeyForm.currentState?.validate() ?? false) &&
                        controllerImage.text.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoundedButton(
                      onPressed: () => Get.back(),
                      child: SvgPicture.asset(
                        Constants.backArrowIcon,
                        fit: BoxFit.none,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    ImageSelector(controller: controllerImage),
                    SizedBox(height: 15.h),
                    MyTextField(
                      controller: controllerName,
                      hintText: 'Name product',
                      obscureText: false,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Enter some any text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    MyTextField(
                      controller: controllerReview,
                      hintText: 'Review product',
                      obscureText: false,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Enter some any text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    MyTextField(
                      controller: controllerPrice,
                      hintText: 'Price product',
                      obscureText: false,
                      maxLength: 6,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Enter some any text';
                        }
                        if (!p0.isNumericOnly) return 'Enter only numbers';
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    MyTextField(
                      controller: controllerQuantity,
                      hintText: 'Quantity product',
                      obscureText: false,
                      maxLength: 3,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Enter some any text';
                        }
                        if (!p0.isNumericOnly) return 'Enter only numbers';
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    DropdownButtonFormField<String>(
                      value: controllerSize.text,
                      decoration: InputDecoration(
                        labelText: 'Size',
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                      items: ['XXL', 'XL', 'X', 'M', 'S']
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e.toString(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => controllerSize.text = value!,
                    ),
                    SizedBox(height: 15.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Raiting'),
                        Center(
                          child: RatingBar.builder(
                            initialRating: double.parse(controllerRaiting.text),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              controllerRaiting.text = rating.toString();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
              Obx(
                () => isValidForm.value
                    ? controller.isLoading.value
                        ? const IsLoading()
                        : MyButtonAgree(
                            onTap: () async {
                              // Register Product Model
                              controller.product.image = controllerImage
                                  .text; // controller.image.value;
                              controller.product.name = controllerName.text;
                              controller.product.reviews =
                                  controllerReview.text;
                              controller.product.price =
                                  double.parse(controllerPrice.text);
                              controller.product.quantity =
                                  int.parse(controllerQuantity.text);
                              controller.product.size = controllerSize.text;
                              controller.product.rating =
                                  double.parse(controllerRaiting.text);

                              bool isRegistered =
                                  await controller.registerProduct();
                              await Get.snackbar(
                                controller.title,
                                controller.messageToDisplay,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 1),
                                backgroundColor:
                                    isRegistered ? Colors.green : Colors.red,
                                snackPosition: SnackPosition.BOTTOM,
                                icon: const Icon(Icons.add_alert),
                                showProgressIndicator: true,
                              ).future;
                              controller.isLoading.value = false;
                              if (isRegistered) {
                                Get.offAndToNamed(Routes.BASE);
                              }
                            },
                            text: 'Register Swap',
                          )
                    : const SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
