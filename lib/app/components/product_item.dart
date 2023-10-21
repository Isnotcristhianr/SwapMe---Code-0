import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/local/my_shared_pref.dart';
import 'package:swapme/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:swapme/app/modules/home/controllers/home_controller.dart';
import 'package:swapme/utils/helpers.dart';

import '../../utils/constants.dart';
import '../data/models/product_model.dart';
import '../modules/base/controllers/base_controller.dart';
import '../routes/app_pages.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    bool isMyInterested =
        product.interested?.contains(MySharedPref.getCurrentUserId()) ?? false;

    return GestureDetector(
      onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF1FA),
                    borderRadius: BorderRadius.circular(25.r),
                    image: DecorationImage(
                      image:
                          (getImage(product.image, onlyImage: false) as Image)
                              .image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                isMyInterested
                    ? const SizedBox()
                    : Positioned(
                        left: 15.w,
                        bottom: 20.h,
                        child: GetBuilder<BaseController>(
                          id: 'FavoriteButton',
                          builder: (controller) => GestureDetector(
                            onTap: () => controller.onFavoriteButtonPressed(
                                product: product),
                            child: CircleAvatar(
                              radius: 18.r,
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                product.isFavorite!
                                    ? Constants.favFilledIcon
                                    : Constants.favOutlinedIcon,
                                color: product.isFavorite!
                                    ? null
                                    : theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ).animate().fade(),
                Positioned(
                  right: 10.w,
                  top: 10.h,
                  child: GetBuilder<FavoritesController>(
                    builder: (FavoritesController controller) {
                      return !isMyInterested
                          ? const SizedBox()
                          : InkWell(
                              onTap: () => {
                                Get.defaultDialog(
                                  title: 'Confirmar quitar interes',
                                  backgroundColor: Colors.white,
                                  content: const Text(
                                      'Está seguro desea dejar de negociar esta prenda?'),
                                  cancel: TextButton(
                                    onPressed: Get.back,
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Cancelar'),
                                  ),
                                  confirm: TextButton(
                                    onPressed: () async {
                                      bool deleted = await controller
                                          .removeProductNegotiation(
                                              product: product);
                                      if (deleted) {
                                        Get.back();
                                        await Get.snackbar(
                                          'Product deleted',
                                          controller.messageToDisplay,
                                          colorText: Colors.white,
                                          backgroundColor: Colors.green,
                                          duration: const Duration(seconds: 2),
                                          snackPosition: SnackPosition.BOTTOM,
                                        ).future;
                                        controller.getFavoriteProducts();
                                        controller.getProductsInNegotiation();
                                        Get.find<HomeController>()
                                            .getProducts();
                                      } else {
                                        await Get.snackbar(
                                          'Error deleted product',
                                          controller.messageToDisplay,
                                          colorText: Colors.white,
                                          backgroundColor: Colors.red,
                                          snackPosition: SnackPosition.BOTTOM,
                                        ).future;
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text(
                                      'Quitar interes',
                                    ),
                                  ),
                                ),
                              },
                              customBorder: const CircleBorder(),
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                child: Icon(
                                  Icons.remove_shopping_cart,
                                  color: context.theme.primaryColor,
                                ),
                              ),
                            );
                    }, // Here
                  ),
                ).animate().fade(),
              ],
            ),
            10.verticalSpace,
            Text(product.name!, style: theme.textTheme.bodyMedium)
                .animate()
                .fade()
                .slideY(
                  duration: const Duration(milliseconds: 200),
                  begin: 1,
                  curve: Curves.easeInSine,
                ),
            5.verticalSpace,
            Text('\$${product.price}', style: theme.textTheme.displaySmall)
                .animate()
                .fade()
                .slideY(
                  duration: const Duration(milliseconds: 200),
                  begin: 2,
                  curve: Curves.easeInSine,
                ),
          ],
        ),
      ),
    );
  }
}
