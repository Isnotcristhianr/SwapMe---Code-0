import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../controllers/settings_controller.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isAccount;
  final bool isDark;
  final String numberPhone;
  final double rank;
  final ImageProvider<Object>? backgroundImage;
  

  const SettingsItem({
    super.key,
    required this.title,
    required this.icon,
    this.isAccount = false,
    this.isDark = false,
    this.numberPhone = 'No registrado',
    //puntos del usuario
    this.rank = 0,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
   return ListTile(
  title: Text(title,
      style: theme.textTheme.displayMedium?.copyWith(
        fontSize: 16.sp,
      )),
  subtitle: !isAccount
      ? null
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              numberPhone,
              style: theme.textTheme.displaySmall,
            ),
            RatingBar.builder(
              initialRating: rank,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20.sp,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
              },
            ),
          ],
        ),
  leading: CircleAvatar(
    radius: isAccount ? 30.r : 25.r,
    backgroundColor: theme.primaryColor,
    backgroundImage: backgroundImage,
    child: backgroundImage == null
        ? SvgPicture.asset(icon, fit: BoxFit.none)
        : const SizedBox(),
  ),
  trailing: isDark
      ? GetBuilder<SettingsController>(
          id: 'Tema',
          builder: (controller) => CupertinoSwitch(
            value: !controller.isLightTheme,
            onChanged: controller.changeTheme,
            activeColor: theme.primaryColor,
          ),
        )
      : Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: SvgPicture.asset(Constants.forwardArrowIcon,
              fit: BoxFit.none),
        ),
);

  }
}
