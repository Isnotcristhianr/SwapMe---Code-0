import 'package:flutter/material.dart';
import 'package:swapme/app/data/models/ranking_model.dart';
import 'package:swapme/app/data/models/user_model.dart';

class UserDetailsView extends StatelessWidget {
  final RankingModel user;

  const UserDetailsView({Key? key, required this.user, required UserModel userModel}) : super(key: key);

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
            Text(
              'Nombre: ${user.authId ?? ''}',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            Text(
              'Puntaje: ${user.punt}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: 10),
            Text(
              'Total de intercambios: ${user.totalSwaps}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
