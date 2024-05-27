// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:swapme/app/modules/settings/views/profile_view.dart';
import 'package:swapme/app/routes/app_pages.dart';
import 'package:swapme/utils/helpers.dart';

import '../../../../utils/constants.dart';
import '../../../components/screen_title.dart';
import '../controllers/settings_controller.dart';
import 'widgets/settings_item.dart';

import 'package:url_launcher/url_launcher.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    // Get controller settings
    final theme = context.theme;

    //get put
    final controller = Get.put(SettingsController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'Configuraciones',
              subtitle: 'Ajustes de la aplicación',
            ),
            20.verticalSpace,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: theme.colorScheme.background,
                //sombra
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  15.verticalSpace,
                  Align(
                    alignment: Alignment.centerLeft,
                    //margen y pading
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 15.w),
                      child: Text(
                        'Perfil',
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.user.value.phone != null
                        ? InkWell(
                            onTap: () {
                              Get.to(ProfileScreen());
                              controller
                                  .getRating(); // Obtener el rating al navegar al perfil
                            },
                            splashColor: Colors.white,
                            hoverColor: Colors.white,
                            highlightColor: Colors.white,
                            child: SettingsItem(
                              title:
                                  '${controller.user.value.name} ${controller.user.value.lastName}',
                              numberPhone: '+${controller.user.value.phone!}',
                              // Mostrar el rating del usuario
                              rank: controller.ranking.value.punt != null
                                  ? double.parse(
                                      controller.ranking.value.punt.toString())
                                  : 0.0,
                              //cantidad de intercambios realizados
                              exchanges: controller.ranking.value.totalSwaps !=
                                      null
                                  ? "Intercambios: ${controller.ranking.value.totalSwaps}"
                                  : "Sin Intercambios",
                              backgroundImage: (getImage(
                                      controller.user.value.photo,
                                      onlyImage: false) as Image)
                                  .image,
                              icon: Constants.userIcon,
                              isAccount: true,
                            ),
                          )
                        : SettingsItem(
                            title: controller.user.value.name ??
                                'Sin nombre registrado',
                            numberPhone: 'Sin numero registrado',
                            icon: Constants.userIcon,
                            isAccount: true,
                          ),
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
            30.verticalSpace,
            Text('Configuraciones Generales',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                )),
            20.verticalSpace,
            const SettingsItem(
              title: 'Dark Mode',
              icon: Constants.themeIcon,
              isDark: true,
            ),
            25.verticalSpace,
            //tap
            GestureDetector(
              onTap: () {
                // Get.toNamed(Routes.LANGUAGE);
                Get.defaultDialog(
                  title: 'Swapme',
                  backgroundColor: Colors.white,
                  content: const Text(
                      'Esta funcionalidad no esta disponible de momento'),
                  confirm: TextButton(
                    onPressed: Get.back,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Aceptar',
                    ),
                  ),
                );
              },
              child: const SettingsItem(
                title: 'Lenguaje',
                icon: Constants.languageIcon,
              ),
            ),
            25.verticalSpace,
            GestureDetector(
              onTap: () {
                // Get.toNamed(Routes.LANGUAGE);
                Get.defaultDialog(
                  title: 'Swapme',
                  backgroundColor: Colors.white,
                  content: const Text(
                      'Esta funcionalidad no esta disponible de momento'),
                  confirm: TextButton(
                    onPressed: Get.back,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Aceptar',
                    ),
                  ),
                );
              },
              child: const SettingsItem(
                title: 'Ayuda',
                icon: Constants.helpIcon,
              ),
            ),
            25.verticalSpace,
            GestureDetector(
              onTap: () {
                //url
                const url = 'https://bento.me/isnotcristhiar';

                // ignore: unnecessary_null_comparison
                if (canLaunch(url) != null) {
                  launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: const SettingsItem(
                title: 'Créditos',
                icon: Constants.developerIcon,
              ),
            ),
            25.verticalSpace,
            GestureDetector(
              onTap: () {
                //url
                const url = 'https://es.surveymonkey.com/r/K62QQMQ';

                // ignore: unnecessary_null_comparison
                if (canLaunch(url) != null) {
                  launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: const SettingsItem(
                title: 'Encuesta de Satisfacción',
                icon: Constants.userIcon,
              ),
            ),
            25.verticalSpace,
            //divider
            const Divider(
              thickness: 5,
            ),
            15.verticalSpace,
            GestureDetector(
              onTap: () async {
                Get.defaultDialog(
                  title: 'Confirmar cerrar sesión',
                  backgroundColor: Colors.white,
                  content: const Text('Está seguro de cerrar sesión?'),
                  cancel: TextButton(
                    onPressed: Get.back,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Cancelar'),
                  ),
                  confirm: TextButton(
                    onPressed: () async {
                      if (FirebaseAuth.instance.currentUser != null) {
                        await FirebaseAuth.instance.signOut();
                        Get.offAllNamed(Routes.SPLASH);
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Cerrar sesión',
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(96, 76, 175, 79), // Replace with your desired color
                  borderRadius: BorderRadius.circular(10),
                  //pading
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                //padding
                padding: EdgeInsets.symmetric(vertical: 15.w),
                child: const SettingsItem(
                  title: 'Cerrar Sesion',
                  icon: Constants.logoutIcon,
                ),
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
