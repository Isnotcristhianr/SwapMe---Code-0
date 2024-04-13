import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/models/ranking_model.dart';
import 'package:swapme/app/modules/details/controllers/userdetails_controller.dart';

class UserDetailsView extends StatelessWidget {
  final RankingModel user;

  const UserDetailsView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserDetailsController controller = Get.put(UserDetailsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del usuario'),
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
            //foto usuario
            FutureBuilder<String?>(
                future: controller.getUserPhotoById(user.authId.toString()),
                builder: (context, snapshot) {
                  return CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(snapshot.data ?? ''),
                  );
                }),
            const SizedBox(height: 10),

            //nombre usuario
            FutureBuilder<String?>(
                future: controller.getUserById(user.authId.toString()),
                builder: (context, snapshot) {
                  return Text(
                    'Nombre: ${snapshot.data}',
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                }),
            const SizedBox(height: 10),
            Text(
              'Puntaje: ${user.punt}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Total de intercambios: ${user.totalSwaps}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
