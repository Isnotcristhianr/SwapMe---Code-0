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
                          future: controller.getUserPhotoById(user.authId.toString()),
                          builder: (context, snapshot) {
                            return CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(snapshot.data ?? ''),
                            );
                          }),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<String?>(
                                future: controller.getUserById(user.authId.toString()),
                                builder: (context, snapshot) {
                                  return Text(
                                    'Nombre: ${snapshot.data}',
                                    style: Theme.of(context).textTheme.headline6,
                                  );
                                }),
                            const SizedBox(height: 20),
                            Text(
                              'Puntaje: ${user.punt}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Total de intercambios: ${user.totalSwaps}',
                              style: Theme.of(context).textTheme.subtitle1,
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
