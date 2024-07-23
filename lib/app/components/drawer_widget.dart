import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:swapme/app/modules/settings/controllers/settings_controller.dart';
import 'package:swapme/app/routes/app_pages.dart';
import 'package:swapme/utils/helpers.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SettingsController());

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF0FDA89),
            ),
            accountName: Text(
             '${controller.user.value.name} ${controller.user.value.lastName}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            accountEmail: Text(
              '${controller.user.value.email}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey
              ),
            ),
            //foto perfil usuario
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(controller.user.value.photo.toString()),
            ),
            
          ),
          ListTile(
            leading: const Icon(Icons.home,
              color: Colors.grey,
            ),
            title: const Text('Home',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey
              ),
            ),
            onTap: () => Get.back(), 
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart,
              color: Colors.grey,
            ),
            title: const Text('Swaps',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey
              ),
            ),
            onTap: () => Get.toNamed(Routes.CART),
          ),
          
          ListTile(
            leading: const Icon(Icons.settings,
              color: Colors.grey,
            ),
            title: const Text('Ajustes',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey
              ),
            ),
            onTap: () => Get.toNamed(Routes.SETTINGS),
          ),
        ],

        //footer
        

      ),
    );
  }
}
        