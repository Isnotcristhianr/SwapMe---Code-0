import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Importa el paquete carousel_slider
import 'package:swapme/app/components/no_data.dart';
import 'package:swapme/app/routes/app_pages.dart';
import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0FDA89),
        tooltip: 'Register new swap',
        child: const Icon(Icons.add),
        onPressed: () => Get.toNamed(Routes.REGISTER_PRODUCT),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            40.verticalSpace,
            const ScreenTitle(
              title: 'SwapMe',
            ),
            0.verticalSpace,
            // Contenedor que contiene el carrusel
            SizedBox(
              height: 150.h, // Ajusta la altura según tus necesidades
              child: CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: true,
                  autoPlay: true, // Reproducción automática
                  autoPlayInterval: const Duration(
                      seconds: 5), // Intervalo de cambio de diapositivas
                ),
                items: [
                  // Diapositiva 1
                  CustomSlider(
                    value: 0.5,
                    onChanged: (value) {
                      // Manejar el cambio en el valor del carrusel
                    },
                    thumbImage: 'assets/images/b1.png',
                  ),
                  // Diapositiva 2
                  CustomSlider(
                    value: 0.5,
                    onChanged: (value) {
                      // Manejar el cambio en el valor del carrusel
                    },
                    thumbImage: 'assets/images/b2.png',
                  ),
                  CustomSlider(
                    value: 0.5,
                    onChanged: (value) {
                      // Manejar el cambio en el valor del carrusel
                    },
                    thumbImage: 'assets/images/b3.png',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // Cuadrícula de productos
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
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          thumbImage,
          width: 350.0, // Ajusta el ancho de la imagen del carrusel
          height: 150.0, // Ajusta la altura de la imagen del carrusel
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
