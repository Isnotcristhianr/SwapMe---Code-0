import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../components/no_data.dart';
import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
      const SizedBox(height: 20),
            30.verticalSpace,
            const ScreenTitle(
              title: 'Deseados',
              dividerEndIndent: 200,
            ),
            20.verticalSpace,
            Obx(
              () => controller.productsFavorites.isEmpty
                  ? const NoData(text: 'Aun no tienes productos deseados')
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h,
                        mainAxisExtent: 260.h,
                      ),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.productsFavorites.length,
                      itemBuilder: (context, index) => ProductItem(
                        product: controller.productsFavorites[index],
                      ),
                    ),
            ),
            20.verticalSpace,
            const ScreenTitle(
              title: 'Negociación',
              dividerEndIndent: 200,
            ),
            Obx(
              () => controller.productsInNegotiation.isEmpty
                  ? const NoData(text: 'Aun no tienes productos negociados')
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h,
                        mainAxisExtent: 280.h,
                      ),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.productsInNegotiation.length,
                      itemBuilder: (context, index) => ProductItem(
                        product: controller.productsInNegotiation[index],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
