// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:swapme/app/data/models/user_model.dart';
import 'package:swapme/app/modules/details/controllers/userdetails_controller.dart';
import 'package:intl/intl.dart';

class UserProductDetailsView extends StatelessWidget {
  final UserModel product;

  const UserProductDetailsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback del usuario'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    // imagen del usuario
                    FutureBuilder<String?>(
                      future: UserDetailsController()
                          .getUserPhotoById(product.authId.toString()),
                      builder: (context, snapshot) {
                        String imageUrl = snapshot.data ??
                            'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';

                        return CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(imageUrl),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // nombre del usuario usando authId y transforma
                        GetBuilder<UserDetailsController>(
                          init: UserDetailsController(),
                          builder: (controller) {
                            return FutureBuilder<String?>(
                              future: controller
                                  .getUserById(product.authId.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '${snapshot.data}',
                                    style: const TextStyle(fontSize: 20),
                                  );
                                }
                                return const Text(
                                    'No se encontró el nombre del usuario');
                              },
                            );
                          },
                        ),
                        //puntuacion
                        GetBuilder<UserDetailsController>(
                          init: UserDetailsController(),
                          builder: (controller) {
                            return FutureBuilder<double>(
                              future: controller
                                  .getUserScore(product.authId.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Row(
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        index < snapshot.data!
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: index < snapshot.data!
                                            ? Colors.yellow
                                            : Colors.grey,
                                      );
                                    }),
                                  );
                                }
                                return const Text(
                                    'No se encontró la puntuación del usuario');
                              },
                            );
                          },
                        ),
                        // total de intercambios
                        GetBuilder<UserDetailsController>(
                          init: UserDetailsController(),
                          builder: (controller) {
                            return FutureBuilder<int>(
                              future: controller
                                  .getUserTotalSwaps(product.authId.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    'Swaps: ${snapshot.data}',
                                    style: const TextStyle(fontSize: 20),
                                  );
                                }
                                return const Text(
                                    'No se encontró el total de intercambios del usuario');
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Espacio para comentarios de usuarios
            const Text(
              'Comentarios de usuarios',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            //nota
            const Text(
              'Los comentarios son anónimos por privacidad.',
              style: TextStyle(fontSize: 15, color: Colors.green),
            ),
            const SizedBox(height: 20),
            GetBuilder<UserDetailsController>(
              init: UserDetailsController(),
              builder: (controller) {
                return FutureBuilder<List<Map<String, dynamic>>>(
                  future: controller.getUserComments(product.authId.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!.map((commentData) {
                          if (commentData['comment'].trim().isEmpty) {
                            return Container(); // Don't display empty comments
                          }
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      DateFormat('dd/MM/yyyy').format(
                                        commentData['date'].toDate(),
                                      ),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width, // Set the width to the screen width
                                    child: Text(
                                      commentData['comment'],
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return const Text('No se encontraron comentarios');
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
