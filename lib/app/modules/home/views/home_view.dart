// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Importa el paquete carousel_slider
import 'package:swapme/app/components/no_data.dart';
import 'package:swapme/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../controllers/home_controller.dart';

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
              child: CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: true,
                  autoPlay: true, // Reproducción automática
                  autoPlayInterval: const Duration(
                      seconds: 5), // Intervalo de cambio de diapositivas
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0, // Tamaño de la diapositiva
                  onPageChanged: (index, reason) {
                    // Manejar el cambio de diapositiva
                  },
                ),
                items: [
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
                  CustomSlider(
                    value: 0.5,
                    onChanged: (value) {
                      // Manejar el cambio en el valor del carrusel
                    },
                    thumbImage: 'assets/images/banner/3.jpg',
                  ),
                  CustomSlider(
                    value: 0.5,
                    onChanged: (value) {
                      // Manejar el cambio en el valor del carrusel
                    },
                    thumbImage: 'assets/images/banner/4.jpg',
                  ),
                  CustomSlider(
                    value: 0.5,
                    onChanged: (value) {
                      // Manejar el cambio en el valor del carrusel
                    },
                    thumbImage: 'assets/images/banner/5.jpg',
                  ),
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
            const SizedBox(height: 20),
            // Cuadrícula de productos
            10.verticalSpace,
            //encuesta gesture detector
           ElevatedButton(
              onPressed: () async {
                const url = 'https://forms.gle/811111';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green, // Color del texto
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20.0,
                ),
              ),
              child: const Text(
                'Encuesta',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            5.verticalSpace,
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
