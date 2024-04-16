// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/models/ranking_model.dart';
import 'package:swapme/app/modules/details/controllers/userdetails_controller.dart';
import 'package:intl/intl.dart';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
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
                      future:
                          controller.getUserPhotoById(user.authId.toString()),
                      builder: (context, snapshot) {
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(snapshot.data ??
                              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                        );
                      },
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<String?>(
                            future:
                                controller.getUserById(user.authId.toString()),
                            builder: (context, snapshot) {
                              return Text(
                                '${snapshot.data}',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              );
                            },
                          ),
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
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              'Comentarios de usuarios: ',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          //nota
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: controller.getUserComments(user.authId.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error al cargar los comentarios'));
                }
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay comentarios'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final comment = snapshot.data![index];
                    if (comment['comment'].trim().isEmpty) {
                      return Container(); // Return an empty container for empty comments
                    }
                    return Card(
                      margin: const EdgeInsets.all(5.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(comment['date'].toDate()),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                comment['comment'],
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
