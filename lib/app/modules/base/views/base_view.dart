import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../controllers/base_controller.dart';
import '../../cart/views/cart_view.dart';
import '../../favorites/views/favorites_view.dart';
import '../../home/views/home_view.dart';
import '../../notifications/views/notifications_view.dart';
import '../../settings/views/settings_view.dart';


class BaseView extends GetView<BaseController> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    Get.put(BaseController());

    return GetBuilder<BaseController>(
      builder: (_) => Scaffold(
        extendBody: true,
        body: SafeArea(
          bottom: true,
          child: IndexedStack(
            index: controller.currentIndex,
            children: const [
              HomeView(),
              FavoritesView(),
              CartView(),
              NotificationsView(),
              SettingsView()
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex,
              type: BottomNavigationBarType.fixed,
              elevation: 0.0,
              backgroundColor: theme.scaffoldBackgroundColor,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0.0,
              items: [
                _mBottomNavItem(
                  label: 'Inicio',
                  icon: Constants.homeIcon,
                ),
                _mBottomNavItem(
                  label: 'Favoritos',
                  icon: Constants.favoritesIcon,
                ),
                _mBottomNavItem(
                  label: 'SwapMe',
                  icon: Constants.cartIcon,
                ),
                _mBottomNavItem(
                  label: 'Ranking',
                  icon: Constants.medalIcon,
                ),
                _mBottomNavItem(
                  label: 'Cuenta',
                  icon: Constants.settingsIcon,
                ),
              ],
              onTap: controller.changeScreen,
            ),
          ),
        ),
      ),
    );
  }

  _mBottomNavItem({required String label, required String icon}) {
    return BottomNavigationBarItem(
      label: label,
      icon: Column(
        children: [
          // ignore: deprecated_member_use
          SvgPicture.asset(icon, color: Get.theme.iconTheme.color),
          const SizedBox(height: 4), // Espaciado entre el ícono y el texto
          Text(
            label,
            style: TextStyle(
              color: Get.theme.iconTheme
                  .color, // Color del texto cuando no está activo
              fontSize: 10.0, // Tamaño del texto
            ),
          ),
        ],
      ),
      activeIcon: Column(
        children: [
          // ignore: deprecated_member_use
          SvgPicture.asset(icon, color: Get.theme.primaryColor),
          const SizedBox(height: 4), // Espaciado entre el ícono y el texto
          Text(
            label,
            style: TextStyle(
              color:
                  Get.theme.primaryColor, // Color del texto cuando está activo
              fontSize: 12.0, // Tamaño del texto
            ),
          ),
        ],
      ),
    );
  }
}
