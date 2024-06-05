import 'package:flutter/material.dart';
import 'package:swapme/app/data/models/ranking_model.dart';

class TopThreeUsersItem extends StatelessWidget {
  final int position;
  final RankingModel rank;
  final String userName;
  final String profilePhoto;

  const TopThreeUsersItem({
    super.key,
    required this.position,
    required this.rank,
    required this.userName,
    required this.profilePhoto,
  });

  @override
  Widget build(BuildContext context) {
    const defaultProfilePhoto =
        'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pngwing.com%2Fes%2Ffree-png-vieud&psig=AOvVaw3tW5UbVht3GVWl8elr04eV&ust=1717641859524000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJCw2tm4w4YDFQAAAAAdAAAAABAE';
    final validProfilePhoto =
        _isValidUrl(profilePhoto) ? profilePhoto : defaultProfilePhoto;

    return SizedBox(
      width: 100,
      height: 300, // Altura máxima para la barra y la imagen
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(validProfilePhoto),
              radius: 30, // Tamaño del CircleAvatar
              backgroundColor: Colors.white,
            ),
          ),
          Positioned(
            top: 70,
            child: Text(
              userName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Positioned(
            top: 100,
            child: Column(
              children: [
                Container(
                  height: _getBarHeight(position),
                  width: 60, // Ancho de la barra
                  decoration: BoxDecoration(
                    color: _getBarColor(position),
                    borderRadius: BorderRadius.circular(
                        15), // Forma redondeada para la barra
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // Desplazamiento de la sombra
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.emoji_events, // Icono del trofeo
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  position.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _getBarHeight(int position) {
    switch (position) {
      case 1:
        return 175; // Altura de la barra para el primer lugar
      case 2:
        return 135; // Altura de la barra para el segundo lugar
      case 3:
        return 100; // Altura de la barra para el tercer lugar
      default:
        return 0;
    }
  }

  Color _getBarColor(int position) {
    switch (position) {
      case 1:
        return Colors.greenAccent; // Color de la barra para el primer lugar
      case 2:
        return Colors.blue; // Color de la barra para el segundo lugar
      case 3:
        return Colors.grey; // Color de la barra para el tercer lugar
      default:
        return Colors.transparent;
    }
  }

  bool _isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null &&
        uri.isAbsolute &&
        (uri.scheme == 'http' || uri.scheme == 'https');
  }
}
