import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/no_data.dart';
import '../../../components/screen_title.dart';
import '../controllers/cart_controller.dart';
import 'widgets/cart_item.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            5.verticalSpace,
            const ScreenTitle(
              title: 'Activos',
              dividerEndIndent: 250,
            ),
            10.verticalSpace,
            Obx(
              () => controller.products.isEmpty
                  ? const NoData(
                      text: 'Aun no tienes prendas para intercambiar')
                  : ListView.builder(
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) => CartItem(
                        product: controller.products[index],
                      ).animate().fade().slideX(
                            duration: const Duration(milliseconds: 300),
                            begin: -1,
                            curve: Curves.easeInSine,
                          ),
                      shrinkWrap: true,
                      primary: false,
                    ),
            ),
            5.verticalSpace,
            const SizedBox(height: 15),
            const ScreenTitle(title: 'Completados'),
            Obx(
              () => controller.productsSwapped.isEmpty
                  ? const NoData(text: 'No hay intercambios completados')
                  : ListView.builder(
                      itemCount: controller.productsSwapped.length,
                      itemBuilder: (context, index) => CartItem(
                        product: controller.productsSwapped[index],
                      ).animate().fade().slideX(
                            duration: const Duration(milliseconds: 300),
                            begin: -1,
                            curve: Curves.easeInSine,
                          ),
                      shrinkWrap: true,
                      primary: false,
                    ),
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}
