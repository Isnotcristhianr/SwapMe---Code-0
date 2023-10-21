import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:swapme/app/components/no_data.dart';
import 'package:swapme/app/components/screen_title.dart';

import 'package:swapme/app/modules/cart/controllers/swap_controller.dart';
import 'package:swapme/app/modules/cart/views/widgets/user_item.dart';
import 'package:swapme/app/modules/product_details/views/widgets/rounded_button.dart';
import 'package:swapme/utils/constants.dart';

class SwapConfirmScreen extends GetView<SwapController> {
  const SwapConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;

    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedButton(
                onPressed: () => Get.back(),
                child:
                    SvgPicture.asset(Constants.backArrowIcon, fit: BoxFit.none),
              ),
              // SizedBox(height: .h),
              ScreenTitle(
                title: 'Users',
                dividerEndIndent: 1.w,
              ),
              SingleChildScrollView(
                child: Obx(
                  () => controller.usersMaybeOwners.isEmpty
                      ? const NoData(
                          text: 'No hay usuarios interesados',
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return UserItem(
                              user: controller.usersMaybeOwners[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: controller.usersMaybeOwners.length,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
