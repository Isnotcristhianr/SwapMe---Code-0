// ignore_for_file: non_constant_identifier_names, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swapme/app/components/no_data.dart';
import 'package:swapme/app/routes/app_pages.dart';
import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../controllers/home_controller.dart';

import '../../../components/drawer_widget.dart'; // Importación desde la carpeta components

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    //home controller
    Get.put(HomeController());

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0FDA89),
        tooltip: 'Register new swap',
        child: const Icon(Icons.add),
        onPressed: () => Get.toNamed(Routes.REGISTER_PRODUCT),
      ),

      //app bar
      appBar: AppBar(
        backgroundColor: const Color(0xFF0FDA89),
        title: const Text('SwapMe'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () =>
                  //mensaje proximanente
                  Get.snackbar(
                    'Próximamente',
                    'Función en desarrollo',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.grey[800],
                    colorText: Colors.white,
                  )),
        ],
      ),
      //menu lateral
      drawer: const DrawerWidget(),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            0.verticalSpace,
            // Contenedor que contiene el carrusel
            SizedBox(
              height: 175.h, // Ajusta la altura según tus necesidades
              width: double.infinity,
              child: Obx(
                () => controller.products.isEmpty
                    ? const NoData(text: 'No hay registros de prendas')
                    : PageView(
                        controller: PageController(viewportFraction: 0.8),
                        children: [
                          // Diapositiva 1
                          CustomSlider(
                            value: 0.5,
                            onChanged: (value) {
                              // Manejar el cambio en el valor del carrusel
                            },
                            thumbImage: 'assets/images/banner/1.jpg',
                          ),
                          // Diapositiva 2
                          CustomSlider(
                            value: 0.5,
                            onChanged: (value) {
                              // Manejar el cambio en el valor del carrusel
                            },
                            thumbImage: 'assets/images/banner/2.jpg',
                          ),
                          // Diapositiva 3
                          CustomSlider(
                            value: 0.5,
                            onChanged: (value) {
                              // Manejar el cambio en el valor del carrusel
                            },
                            thumbImage: 'assets/images/banner/3.jpg',
                          ),
                          // Diapositiva 4
                          CustomSlider(
                            value: 0.5,
                            onChanged: (value) {
                              // Manejar el cambio en el valor del carrusel
                            },
                            thumbImage: 'assets/images/banner/4.jpg',
                          ),
                          // Diapositiva 5
                          CustomSlider(
                            value: 0.5,
                            onChanged: (value) {
                              // Manejar el cambio en el valor del carrusel
                            },
                            thumbImage: 'assets/images/banner/5.jpg',
                          ),
                          // Diapositiva 6
                          CustomSlider(
                            value: 0.5,
                            onChanged: (value) {
                              // Manejar el cambio en el valor del carrusel
                            },
                            thumbImage: 'assets/images/banner/6.jpg',
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20),
            // Cuadrícula de productos
            10.verticalSpace,
            // Título de la sección
            const ScreenTitle(
              title: 'SwapMe',
              subtitle: 'Prendas disponibles',
            ),
            0.verticalSpace,
            Obx(
              () => controller.products.isEmpty
                  ? const NoData(text: 'No hay registros de prendas')
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h,
                        mainAxisExtent: 260.h,
                      ),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.products.length,
                      //producto
                      itemBuilder: (context, index) => ProductItem(
                        product: controller.products[index],
                      ),
                    ),
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}

// Widget personalizado para el carrusel con imagen de indicador
class CustomSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final String thumbImage;

  const CustomSlider({
    super.key,
    required this.value,
    required this.onChanged,
    required this.thumbImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpandedImageView(imageUrl: thumbImage),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: thumbImage,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  15.0), // Ajusta el radio según tus necesidades
              child: Image.asset(
                thumbImage,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget personalizado para la vista ampliada de la imagen, tipo zoom para ver mejor, no ocupa toda la pantalla
  Widget ExpandedImageView({required String imageUrl}) {
    return Scaffold(
      //fondo transparente
      backgroundColor: Colors.transparent,
      body: Center(
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Hero(
            tag: imageUrl,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
