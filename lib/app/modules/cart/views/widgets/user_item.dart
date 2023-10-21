import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/models/user_model.dart';
import 'package:swapme/app/modules/cart/controllers/cart_controller.dart';
import 'package:swapme/app/modules/cart/controllers/swap_controller.dart';
import 'package:swapme/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:swapme/app/routes/app_pages.dart';
import 'package:swapme/utils/helpers.dart';

class UserItem extends StatelessWidget {
  final UserModel user;
  const UserItem({Key? key, required this.user}) : super(key: key);

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
              5.verticalSpace,
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
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                onPressed: () {
                  Get.defaultDialog(
                      title: 'Confirm Swap',
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
                      onConfirm: () async {
                        await Get.find<SwapController>()
                            .confirmSwap(owner_id: user.id!);
                        Get.find<CartController>().getCartProducts();
                        Get.find<CartController>().getProductsSwapped();
                        Get.find<FavoritesController>().getFavoriteProducts();
                        Get.find<FavoritesController>()
                            .getProductsInNegotiation();
                        Get.offAndToNamed(Routes.BASE);
                      });
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
