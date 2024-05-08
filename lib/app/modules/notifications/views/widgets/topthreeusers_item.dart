import 'package:flutter/material.dart';
import 'package:swapme/app/data/models/ranking_model.dart';

class TopThreeUsersItem extends StatelessWidget {
  final int position;
  final RankingModel rank;
  final String userName;
  final String profilePhoto;

  const TopThreeUsersItem({
    Key? key,
    required this.position,
    required this.rank,
    required this.userName,
    required this.profilePhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.yellow, // Color del atril
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            position.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          CircleAvatar(
            backgroundImage: NetworkImage(profilePhoto),
            radius: 30, // Tamaño del CircleAvatar
          ),
        ],
      ),
    );
  }
}
