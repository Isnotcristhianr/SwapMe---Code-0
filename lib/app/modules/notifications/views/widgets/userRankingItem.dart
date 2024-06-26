// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/models/ranking_model.dart';
import 'package:swapme/app/modules/details/views/userDetails_view.dart';


class UserRankingItem extends StatelessWidget {
  final int position;
  final RankingModel rank;
  final String userName;
  final String profilePhoto;

  const UserRankingItem({
    super.key,
    required this.position,
    required this.rank,
    required this.userName,
    required this.profilePhoto,
  });

  @override
  Widget build(BuildContext context) {

    Color color;
    if (position == 1) {
      //diamante primer lugar
      color = Colors.greenAccent;
    } else if (position == 2) {
      color = Colors.blue; //2do
    } else if (position == 3) {
      color = Colors.grey; // Color de la barra para el tercer lugar
    } else {
      color = Colors.transparent; // Color para otros lugares
    }

    return Container(
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
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                position == 1
                    ? const Icon(
                        Icons.emoji_events,
                        size: 35,
                      )
                    : position == 2
                        ? const Icon(
                            Icons.emoji_events,
                            size: 35,
                          )
                        : position == 3
                            ? const Icon(Icons.emoji_events, size: 35)
                            : const Icon(Icons.emoji_events, size: 35),
                Text(
                  position.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
                width: 8), // Espacio entre los trofeos y la foto de perfil
            CircleAvatar(
              backgroundImage: NetworkImage(profilePhoto),
              radius: 20, // Tamaño del CircleAvatar
            ),
          ],
        ),
        title: Text(" $userName "), // Mostrar el nombre del usuario
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Intercambios: ${rank.totalSwaps}'), // Mostrar detalles del usuario
            RatingBarIndicator(
              rating: double.parse(rank.punt.toString()),
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
            ),
          ],
        ),
        //nueva columna ver mas btn ontap para ir a una vista
        trailing: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_forward_ios),
          ],
        ),
        onTap: () {
          // Navegar a la vista de perfil del usuario
          Get.to(() => UserDetailsView(user: rank));
        },
      ),
    );
  }
}
