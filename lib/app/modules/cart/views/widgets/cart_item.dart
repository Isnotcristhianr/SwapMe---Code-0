import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/local/my_shared_pref.dart';
import 'package:swapme/app/routes/app_pages.dart';
import 'package:swapme/utils/helpers.dart';

import '../../../../../utils/constants.dart';
import '../../../../data/models/product_model.dart';
import '../../controllers/cart_controller.dart';

class CartItem extends GetView<CartController> {
  final ProductModel product;
  const CartItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    bool isMyPurchase = product.newOwnerId == MySharedPref.getCurrentUserId();
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25.r),
            child: Stack(
              children: [
                Container(
                  width: 105.w,
                  height: 125.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF1FA),
                    image: DecorationImage(
                      image:
                          (getImage(product.image, onlyImage: false) as Image)
                              .image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          20.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.verticalSpace,
                Text(
                  product.name!,
                  style: theme.textTheme.displayMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                5.verticalSpace,
                Text('Size: ${product.size}',
                    style:
                        theme.textTheme.bodyMedium?.copyWith(fontSize: 16.sp)),
                5.verticalSpace,
                Text(
                  '\$${product.price}',
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: 18.sp,
                  ),
                ),
                5.verticalSpace,
                product.available
                    ? TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        onPressed: () => Get.toNamed(
                          Routes.SWAP_PRODUCT,
                          arguments: product,
                        ),
                        child:
                            Text('Confirmar - ${product.interested?.length}'),
                      )
                    : const SizedBox(),
                product.available
                    ? const SizedBox()
                    : Text(
                        isMyPurchase
                            ? 'Comprado a ${product.owner?.name} ${product.owner?.lastName}'
                            : 'Vendido a ${product.newOwner?.name} ${product.newOwner?.lastName}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 14.sp,
                          color: !isMyPurchase ? Colors.green : Colors.blue,
                        ),
                      ),
              ],
            ),
          ),
          product.available
              ? InkWell(
                  onTap: () => {
                    Get.defaultDialog(
                      title: 'Confirmar borrado',
                      backgroundColor: Colors.white,
                      content: const Text(
                          'Está seguro de eliminar esta prenda para intercambio?'),
                      cancel: TextButton(
                        onPressed: Get.back,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Cancelar',
                        ),
                      ),
                      confirm: TextButton(
                        onPressed: () async {
                          bool deleted =
                              await controller.deleteProduct(id: product.id!);
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
                            controller.getCartProducts();
                            controller.getProductsSwapped();
                          } else {
                            await Get.snackbar(
                              'Error deleted product',
                              controller.messageToDisplay,
                              colorText: Colors.white,
                              backgroundColor: Colors.red,
                            ).future;
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Borrar',
                        ),
                      ),
                    ),
                  },
                  customBorder: const CircleBorder(),
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    child: SvgPicture.asset(
                      Constants.cancelIcon,
                      width: 20.w,
                      height: 20.h,
                      // ignore: deprecated_member_use
                      color: theme.textTheme.bodyMedium!.color,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
