import 'dart:io';

import 'package:flutter/material.dart';

Widget getImage(String? url, {bool onlyImage = true}) {
  if (url == null || url.isEmpty || url == 'null') {
    return const Image(
      image: AssetImage('assets/images/no-image.jpg'),
      fit: BoxFit.cover,
    );
  }

  if (url.startsWith('http') || url.startsWith('htts')) {
    return !onlyImage
        ? Image(
            image: FadeInImage(
              image: NetworkImage(url),
              placeholder: const AssetImage('assets/images/loading.gif'),
              fit: BoxFit.cover,
            ).image,
          )
        : FadeInImage(
            image: NetworkImage(url),
            placeholder: const AssetImage('assets/images/loading.gif'),
            fit: BoxFit.cover,
          );
  }

  return Image.file(
    File(url),
    fit: BoxFit.cover,
  );
}
