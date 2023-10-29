import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';

// ignore: must_be_immutable
class NotificationItem extends StatelessWidget {
  NotificationItem({super.key});

  //fecha de hoy capturar
  DateTime date = DateTime.now();
  //hora de hoy capturar
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          'Notificación',
          'Bienvenido a SWAPME, esta funcionalidad estará disponible pronto',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: theme.primaryColor,
          colorText: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          borderRadius: 15.r,
          duration: const Duration(seconds: 3),
          icon: SvgPicture.asset(
            Constants.notificationsIcon,
            color: Colors.white,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: ListTile(
          title: Text(
            'Bienvenido a SWAPME, esta funcionalidad estará disponible pronto',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              '${date.day}/${date.month}/${date.year}'
              ' ${time.hour}:${time.minute}',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 12.sp,
              ),
            ),
          ),
          leading: Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                Constants.notificationsIcon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

