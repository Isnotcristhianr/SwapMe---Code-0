// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:swapme/app/data/local/my_shared_pref.dart';
import 'package:swapme/app/modules/details/views/productUserDetailsView.dart';
import 'package:swapme/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:swapme/utils/helpers.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';
import '../controllers/product_details_controller.dart';
import 'widgets/rounded_button.dart';
//import 'widgets/size_item.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    bool userHasInNegotioation = controller.product.interested
            ?.contains(MySharedPref.getCurrentUserId()) ??
        false;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 450.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDF1FA),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      image:
                          (getImage(controller.product.image, onlyImage: false)
                                  as Image)
                              .image,
                      //height: 700.h,
                    ).animate().slideX(
                          duration: const Duration(milliseconds: 300),
                          begin: 1,
                          curve: Curves.easeInSine,
                        ),
                  ),
                  Positioned(
                    top: 30.h,
                    left: 20.w,
                    right: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoundedButton(
                          onPressed: () => {
                            Get.find<FavoritesController>()
                                .getFavoriteProducts(),
                            Get.find<FavoritesController>()
                                .getProductsInNegotiation(),
                            Get.back()
                          },
                          child: SvgPicture.asset(Constants.backArrowIcon,
                              fit: BoxFit.none),
                        ),
                        GetBuilder<ProductDetailsController>(
                          id: 'FavoriteButton',
                          builder: (_) => RoundedButton(
                            onPressed: () =>
                                controller.onFavoriteButtonPressed(),
                            child: Align(
                              child: SvgPicture.asset(
                                controller.product.isFavorite!
                                    ? Constants.favFilledIcon
                                    : Constants.favOutlinedIcon,
                                width: 16.w,
                                height: 15.h,
                                color: controller.product.isFavorite!
                                    ? null
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        controller.product.name!,
                        style: theme.textTheme.bodyLarge,
                      ).animate().fade().slideX(
                            duration: const Duration(milliseconds: 300),
                            begin: -1,
                            curve: Curves.easeInSine,
                          ),

                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            // Navegar a la vista de detalles del usuario con un objeto RankingModel
                            Get.to(() => UserProductDetailsView(
                                userModel: controller.userOwner.value)
                            ) ;
                          },
                          child: Text(
                            // dueño del producto
                            'Propietario: ${controller.userOwner.value.name} ${controller.userOwner.value.lastName}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              //tipo link
                              decoration: TextDecoration.underline,
                              color: Colors.green,
                            ),
                          ),
                        );
                      }).animate().fade().slideX(
                            duration: const Duration(milliseconds: 300),
                            begin: -1,
                            curve: Curves.easeInSine,
                          ),
                      //calificacion del usuario estrellas
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            double ownerRating =
                                controller.ownerRanking.value.punt ?? 0.0;
                            return Row(
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  Icons.star,
                                  color: index < ownerRating
                                      ? Colors.amber
                                      : Colors.grey,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Condición: ",
                          style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            controller.product.rating != null
                                ? getRatingString(controller.product.rating!)
                                : 'No disponible',
                            style: theme.textTheme.bodySmall
                                ?.copyWith(fontSize: 15.sp),
                          ),
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Talla Disponible: ',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '${controller.product.size}',
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    Row(
                      children: [
                        Text(
                          'Descripcion: ',
                          style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            controller.product.reviews!,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fade().slideX(
                    duration: const Duration(milliseconds: 300),
                    begin: -1,
                    curve: Curves.easeInSine,
                  ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: CustomButton(
                  text: userHasInNegotioation
                      ? 'Ya estás en negociación'
                      : 'Intercambiar',
                  onPressed: () async {
                    bool isAdded = await controller.onAddToCartPressed();
                    if (!isAdded) {
                      await Get.snackbar(
                        'Error Message',
                        controller.messageToDisplay.isEmpty
                            ? 'Error al intercambiar. Intentelo de nuevo'
                            : controller.messageToDisplay,
                        colorText: Colors.white,
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.BOTTOM,
                      ).future;
                    }
                  },
                  disabled:
                      !controller.product.available || userHasInNegotioation,
                  fontSize: 16.sp,
                  radius: 12.r,
                  verticalPadding: 12.h,
                  hasShadow: true,
                  shadowColor: theme.primaryColor,
                  shadowOpacity: 0.3,
                  shadowBlurRadius: 4,
                  shadowSpreadRadius: 0,
                ).animate().fade().slideY(
                      duration: const Duration(milliseconds: 300),
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
