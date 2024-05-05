import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swapme/app/data/models/user_model.dart';
import 'package:swapme/app/modules/cart/controllers/cart_controller.dart';
import 'package:swapme/app/modules/cart/controllers/comment_controller.dart';
import 'package:swapme/app/modules/cart/controllers/swap_controller.dart';
import 'package:swapme/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:swapme/app/routes/app_pages.dart';
import 'package:swapme/utils/helpers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

//ranking controller
import 'package:swapme/app/modules/cart/controllers/ranking_controller.dart';

// ignore: must_be_immutable
class UserItem extends StatelessWidget {
  final UserModel user;
//controlador de comentarios
  final commentController = TextEditingController();
  // ignore: use_key_in_widget_constructors
  UserItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    //inicializar la variable rating actual
    double rating = 0;
    // Inicializa RankingController utilizando Get.put()
    final rankingController = Get.put(RankingController());
    //comments getput
    Get.put(CommentController());

    var theme = context.theme;

    return Container(
      height: 150.h,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          5.horizontalSpace,
          CircleAvatar(
            backgroundImage:
                (getImage(user.photo, onlyImage: false) as Image).image,
            maxRadius: 50,
          ),
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              10.verticalSpace,
              Text(
                '${user.name} ${user.lastName}',
                style: theme.textTheme.displayMedium,
                overflow: TextOverflow.ellipsis,
              ),
              5.verticalSpace,
              Text('Phone: ${user.phone}',
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16.sp)),
              5.verticalSpace,
              Text(
                '${user.email}',
                style: theme.textTheme.displayLarge?.copyWith(
                  fontSize: 14.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Confirmar Swap',
                    titleStyle: context.textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    middleText:
                        'Confirma el intercambio de prenda con ${user.name} ${user.lastName}?. Esta acción no se puede rehacer',
                    middleTextStyle: context.textTheme.bodyMedium,
                    cancelTextColor: Colors.red,
                    onCancel: Get.back,
                    textCancel: 'Cancelar',
                    textConfirm: 'Confirmar',
                    confirmTextColor: Colors.blue,
                    content: Column(
                      children: [
                        Text(
                          'Califica al usuario:',
                          style: theme.textTheme.bodyMedium,
                        ),
                        SizedBox(height: 10.h),
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 40.sp,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (value) {
                            rating = value;
                          },
                        ),
                        SizedBox(height: 10.h),
                        //comentarios
                        Text(
                          'Comentarios:',
                          style: theme.textTheme.bodyMedium,
                        ),
                        SizedBox(height: 10.h),
                        TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Escribe un comentario',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          maxLines: 3,
                        ),
                      ],
                    ),
                    onConfirm: () async {
                      // Lógica para confirmar el intercambio
                      await Get.find<SwapController>()
                          .confirmSwap(owner_id: user.id.toString());
                      Get.find<CartController>().getCartProducts();
                      Get.find<CartController>().getProductsSwapped();
                      Get.find<FavoritesController>().getFavoriteProducts();
                      Get.find<FavoritesController>()
                          .getProductsInNegotiation();

                      // Actualizar el rating del usuario en la base de datos
                      var rankingSnapshot = await FirebaseFirestore.instance
                          .collection('ranking')
                          .doc(user.authId)
                          .get();

                      if (rankingSnapshot.exists) {
                        var rankingData = rankingSnapshot.data()!;
                        double currentRating =
                            (rankingData['punt'] ?? 0).toDouble();
                        int totalSwaps = rankingData['totalSwaps'] ?? 0;
                        double newRating = rankingController.calculateNewRating(
                          currentRating,
                          rating,
                          totalSwaps,
                        );
                        int updatedTotalSwaps = totalSwaps + 1;

                        //comentarios
                        // Agregar el comentario a Firestore
                        var commentId =
                            await Get.find<CommentController>().addComment(
                          authId: user.authId.toString(),
                          text: commentController
                              .text, // Obtén el texto del comentario
                        );

                        // Agregar el ID del comentario al documento de ranking del usuario
                        await Get.find<RankingController>()
                            .addCommentIdToRanking(
                          user.authId.toString(),
                          commentId.id, // Obtén el ID del comentario agregado
                        );

                        await FirebaseFirestore.instance
                            .collection('ranking')
                            .doc(user.authId)
                            .update({
                          'punt': newRating,
                          'totalSwaps': updatedTotalSwaps,
                          'comments': FieldValue.arrayUnion([commentId.id])
                        });
                      } else {
                        // Si el usuario no tiene un documento de ranking, crea uno nuevo
                        await FirebaseFirestore.instance
                            .collection('ranking')
                            .doc(user.authId)
                            .set({
                          'punt': rating,
                          'totalSwaps': 1,
                          'comments': [],
                        });

                        //comentarios
                        // Agregar el comentario a Firestore
                        var commentId =
                            await Get.find<CommentController>().addComment(
                          authId: user.authId.toString(),
                          text: commentController
                              .text, // Obtén el texto del comentario
                        );

                        // Agregar el ID del comentario al documento de ranking del usuario
                        await Get.find<RankingController>()
                            .addCommentIdToRanking(
                          user.authId.toString(),
                          commentId.id, // Obtén el ID del comentario agregado
                        );
                      }

                      //abrir encuesta en el navegador link
                      // ignore: deprecated_member_use
                      await launch('https://es.surveymonkey.com/r/K62QQMQ');

                      // Volver a la pantalla base
                      Get.offAndToNamed(Routes.BASE);
                    },
                  );
                },
                child: Text(
                  'Seleccionar',
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: Colors.green,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
