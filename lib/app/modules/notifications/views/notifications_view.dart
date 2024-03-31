import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../components/screen_title.dart';
import '../controllers/notifications_controller.dart';
// ignore: unused_import
import 'widgets/notification_item.dart';

//animaciones
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

//ranking mddel
import 'package:swapme/app/data/models/ranking_model.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    //get put
    Get.put(NotificationsController());

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

            //prximamente se implementara el ranking

            Obx(() {
              if (controller.topUsers.isEmpty) {
                return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
              } else {
                return Column(
                  children: [
                    // Mostrar los tres mejores usuarios
                    for (int i = 0; i < controller.topUsers.length; i++)
                      FutureBuilder(
                        future: controller.getUserById(
                            controller.topUsers[i].authId.toString()),
                        builder: (context, snapshot) {
                          return buildUserRankingItem(
                            i + 1,
                            controller.topUsers[i],
                            snapshot.data
                                .toString(), // Pasa el nombre del usuario como parámetro
                          );
                        },
                      ),
                    // Aquí puedes mostrar la lista completa de usuarios si es necesario
                  ],
                );
              }
            }),

            40.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget buildUserRankingItem(
    int position,
    RankingModel rank,
    String userName,
  ) {
    Color color;
    if (position == 1) {
      //color primer lugar oro
      color = Colors.amber;
    } else if (position == 2) {
      color = Colors.grey; // Color para el segundo usuario
    } else if (position == 3) {
      color = Colors.brown; // Color para el tercer usuario
    } else {
      color = Colors.white; // Color para los demás usuarios
    }

    return AnimationConfiguration.staggeredList(
      position: position,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading: 
              //trofeo para cada lugar
              position == 1
                  ? const Icon(Icons.emoji_events, size: 40)
                  : position == 2
                      ? const Icon(Icons.emoji_events, size: 40)
                      : position == 3
                          ? const Icon(Icons.emoji_events, size: 40)
                          : const Icon(Icons.emoji_events, size: 40),
                          
              title:
                  Text("Usuario: $userName "), // Mostrar el nombre del usuario
              subtitle: Text(
                  'Intercambios: ${rank.totalSwaps}, Puntuación: ${rank.punt}'), // Muestra más detalles del usuario
            ),
          ),
        ),
      ),
    );
  }
}
