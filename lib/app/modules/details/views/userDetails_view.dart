// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/models/ranking_model.dart';
import 'package:swapme/app/modules/details/controllers/userdetails_controller.dart';

class UserDetailsView extends StatelessWidget {
  final RankingModel user;

  const UserDetailsView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final UserDetailsController controller = Get.put(UserDetailsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback del usuario'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      FutureBuilder<String?>(
                          future: controller
                              .getUserPhotoById(user.authId.toString()),
                          builder: (context, snapshot) {
                            return CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(snapshot
                                      .data ?? // Si no hay foto, muestra una imagen de relleno
                                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                            );
                          }),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<String?>(
                                future: controller
                                    .getUserById(user.authId.toString()),
                                builder: (context, snapshot) {
                                  return Text(
                                    '${snapshot.data}',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  );
                                }),
                            const SizedBox(height: 15),
                            Row(
                              children: List.generate(5, (index) {
                              return Icon(
                                index < user.punt!.toInt()
                                  ? Icons.star 
                                  : Icons.star_border,
                                color: index < user.punt!.toInt()
                                  ? Colors.yellow 
                                  : Colors.grey,
                              );
                              }),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Swaps: ${user.totalSwaps}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Aquí puede agregar los comentarios de los usuarios en el futuro
        ],
      ),
    );
  }
}
