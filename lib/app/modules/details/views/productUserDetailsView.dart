import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:swapme/app/data/models/user_model.dart';
import 'package:swapme/app/modules/details/controllers/userdetails_controller.dart';

class UserProductDetailsView extends StatelessWidget {
  final UserModel product;

  const UserProductDetailsView({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            // nombre del usuario usando authId y transforma
            GetBuilder<UserDetailsController>(
              init: UserDetailsController(),
              builder: (controller) {
                return FutureBuilder<String?>(
                  future: controller.getUserById(product.authId.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        'Nombre: ${snapshot.data}',
                        style: const TextStyle(fontSize: 20),
                      );
                    }
                    return const Text('No se encontró el nombre del usuario');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
