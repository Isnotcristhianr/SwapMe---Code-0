import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../components/screen_title.dart';
import '../controllers/notifications_controller.dart';

import 'widgets/userRankingItem.dart';

//widget user ranking

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    //get put
    Get.lazyPut(() => NotificationsController());

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
            //top users
            Obx(() {
              if (controller.topUsers.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return Column(
                  children: [
                    for (int i = 0; i < controller.topUsers.length; i++)
                      FutureBuilder(
                        future: Future.wait([
                          controller.getUserById(
                              controller.topUsers[i].authId.toString()),
                          controller.getUsersProfilePhotos(
                              controller.topUsers[i].authId.toString()),
                        ]),
                        builder:
                            (context, AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return UserRankingItem(
                              position: i + 1,
                              rank: controller.topUsers[i],
                              userName: snapshot.data![0].toString(),
                                profilePhoto: snapshot.data![1]?.toString() 
                                ?? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                            );
                          } else {
                            return const Text('No data available');
                          }
                        },
                      ),
                  ],
                );
              }
            }),
            //linea divisioria
            const Divider(
              color: Colors.greenAccent,
              thickness: 5,
            ),
          ],
        ),
      ),
    );
  }
}
