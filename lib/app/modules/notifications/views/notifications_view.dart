import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../components/screen_title.dart';
import '../controllers/notifications_controller.dart';

//widgets
import 'widgets/userRankingItem.dart';
import 'widgets/topthreeusers_item.dart';

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
            //top 3
            Obx(() {
              if (controller.topUsers.take(3).isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Tercer lugar a la izquierda
                    FutureBuilder(
                      future: Future.wait([
                        controller.getUserById(
                            controller.topUsers[2].authId.toString()),
                        controller.getUsersProfilePhotos(
                            controller.topUsers[2].authId.toString()),
                      ]),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return Expanded(
                            child: TopThreeUsersItem(
                              position: 3,
                              rank: controller.topUsers[2],
                              userName: snapshot.data![0].toString(),
                              profilePhoto: snapshot.data![1]?.toString() ??
                                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                            ),
                          );
                        } else {
                          return const Text('No data available');
                        }
                      },
                    ),
                    const SizedBox(width: 20),
                    // Primer lugar al centro
                    FutureBuilder(
                      future: Future.wait([
                        controller.getUserById(
                            controller.topUsers[0].authId.toString()),
                        controller.getUsersProfilePhotos(
                            controller.topUsers[0].authId.toString()),
                      ]),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return Expanded(
                            child: TopThreeUsersItem(
                              position: 1,
                              rank: controller.topUsers[0],
                              userName: snapshot.data![0].toString(),
                              profilePhoto: snapshot.data![1]?.toString() ??
                                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                            ),
                          );
                        } else {
                          return const Text('No data available');
                        }
                      },
                    ),
                    const SizedBox(width: 20),
                    // Segundo lugar a la derecha
                    FutureBuilder(
                      future: Future.wait([
                        controller.getUserById(
                            controller.topUsers[1].authId.toString()),
                        controller.getUsersProfilePhotos(
                            controller.topUsers[1].authId.toString()),
                      ]),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return Expanded(
                            child: TopThreeUsersItem(
                              position: 2,
                              rank: controller.topUsers[1],
                              userName: snapshot.data![0].toString(),
                              profilePhoto: snapshot.data![1]?.toString() ??
                                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                            ),
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

            const Divider(
              thickness: 2,
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
                        ] as Iterable<Future>),
                        builder:
                            (context, AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return UserRankingItem(
                              position: i + 1,
                              rank: controller.topUsers[i],
                              userName: snapshot.data![0].toString(),
                              profilePhoto: snapshot.data![1]?.toString() ??
                                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
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
