// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: unused_import
import 'package:get/get.dart';
import 'package:swapme/app/data/models/ranking_model.dart';

// ignore: unused_import
import '../../../../../utils/constants.dart';

// ignore: must_be_immutable
class NotificationItem extends StatelessWidget {
  NotificationItem({super.key, Object? name, Object? points, Object? image, required RankingModel rankModel});

  //fecha de hoy capturar
  DateTime date = DateTime.now();
  //hora de hoy capturar
  TimeOfDay time = TimeOfDay.now();

   Color kGreyColor = const Color(0xFFA1A4B2);
  @override
  Widget build(BuildContext context) {
    //NotificationItem(
      //vacio
    //);
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        children: [
          SvgPicture.asset(
            '/assets/vectors/user.svg',
            height: 50.h,
            width: 50.w,
          ),
          20.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                style: TextStyle(
                  color: kGreyColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              5.verticalSpace,
              Text(
                'Ha intercambiado 100 puntos',
                style: TextStyle(
                  color: kGreyColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              5.verticalSpace,
              Text(
                '${date.day}/${date.month}/${date.year} ${time.hour}:${time.minute}',
                style: TextStyle(
                  color: kGreyColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

