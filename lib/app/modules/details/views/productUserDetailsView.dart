// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:swapme/app/data/models/user_model.dart';

class UserProductDetailsView extends StatelessWidget {

  const UserProductDetailsView({super.key, required UserModel userModel});

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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}