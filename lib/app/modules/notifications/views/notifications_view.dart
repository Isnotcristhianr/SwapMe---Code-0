import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../components/screen_title.dart';
import '../controllers/notifications_controller.dart';
import 'widgets/notification_item.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'Ranking',
              subtitle: 'Top Usuarios',
              dividerEndIndent: 150,
            ),
            10.verticalSpace,
            //top 3 usuarios intercambiantes front
            //usar fetch top users
            
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
