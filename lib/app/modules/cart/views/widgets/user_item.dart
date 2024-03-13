import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/models/user_model.dart';
import 'package:swapme/app/modules/cart/controllers/cart_controller.dart';
import 'package:swapme/app/modules/cart/controllers/swap_controller.dart';
import 'package:swapme/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:swapme/app/routes/app_pages.dart';
import 'package:swapme/utils/helpers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class UserItem extends StatelessWidget {
  final UserModel user;
  // ignore: use_key_in_widget_constructors
   UserItem({Key? key, required this.user});

// Obtener la calificación del usuario rating
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;

    return Container(
      height: 130.h,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          5.horizontalSpace,
          CircleAvatar(
            backgroundImage:
                (getImage(user.photo, onlyImage: false) as Image).image,
            maxRadius: 70,
          ),
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              10.verticalSpace,
              Text(
                '${user.name} ${user.lastName}',
                style: theme.textTheme.displayMedium,
                overflow: TextOverflow.ellipsis,
              ),
              5.verticalSpace,
              Text('Phone: ${user.phone}',
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16.sp)),
              5.verticalSpace,
              Text(
                '${user.email}',
                style: theme.textTheme.displayLarge?.copyWith(
                  fontSize: 14.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Confirmar Swap',
                    titleStyle: context.textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    middleText:
                        'Confirma el intercambio de prenda con ${user.name} ${user.lastName}?. Esta acción no se puede rehacer',
                    middleTextStyle: context.textTheme.bodyMedium,
                    cancelTextColor: Colors.red,
                    onCancel: Get.back,
                    textCancel: 'Cancel',
                    textConfirm: 'Confirm',
                    confirmTextColor: Colors.blue,
                    content: Column(
                      children: [
                        Text(
                          'Califica al usuario:',
                          style: theme.textTheme.bodyMedium,
                        ),
                        SizedBox(height: 10.h),
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 40.sp,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (value) {
                            rating = value;
                          },
                        ),
                      ],
                    ),
                    onConfirm: () async {
                      // Lógica para confirmar el intercambio
                      await Get.find<SwapController>()
                          .confirmSwap(owner_id: user.id!);
                      Get.find<CartController>().getCartProducts();
                      Get.find<CartController>().getProductsSwapped();
                      Get.find<FavoritesController>().getFavoriteProducts();
                      Get.find<FavoritesController>()
                          .getProductsInNegotiation();

                      // Actualizar el rating del usuario en la base de datos
                      await FirebaseFirestore.instance
                          .collection('ranking')
                          .doc(user.authId)
                          .set({
                        //auth id del usuario a calificar
                        'authId': user.authId,
                        'date': DateTime.now(),
                        'punt': rating
                      }, SetOptions(merge: true));

                      // Volver a la pantalla base
                      Get.offAndToNamed(Routes.BASE);
                    },
                  );
                },
                child: Text(
                  'Seleccionar',
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: Colors.green,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
