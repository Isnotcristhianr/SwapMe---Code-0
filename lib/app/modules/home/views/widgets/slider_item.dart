import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//carrousel slider package
import 'package:carousel_slider/carousel_slider.dart';
import 'package:swapme/app/components/no_data.dart';
import 'package:swapme/app/routes/app_pages.dart';
import '../../../../components/product_item.dart';
import '../../../../components/screen_title.dart';
import '../../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: 175.h,
              width: double.infinity,
              child: CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {},
                ),
                items: [
                  CustomSlider(
                    value: 0.5,
                    onChanged: (value) {},
                    thumbImage: 'assets/images/banner/1.jpg',
                  ),
                  CustomSlider(
                    value: 0.5,
                    onChanged: (value) {},
                    thumbImage: 'assets/images/banner/2.jpg',
                  ),
                  CustomSlider(
                    value: 0.5,
                    onChanged: (value) {},
                    thumbImage: 'assets/images/banner/3.jpg',
                  ),
                  CustomSlider(
                    value: 0.5,
                    onChanged: (value) {},
                    thumbImage: 'assets/images/banner/4.jpg',
                  ),
                  CustomSlider(
                    value: 0.5,
                    onChanged: (value) {},
                    thumbImage: 'assets/images/banner/5.jpg',
                  ),
                  CustomSlider(
                    value: 0.5,
                    onChanged: (value) {},
                    thumbImage: 'assets/images/banner/6.jpg',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            10.verticalSpace,
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
              borderRadius: BorderRadius.circular(15.0),
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
}

class ExpandedImageView extends StatelessWidget {
  final String imageUrl;

  const ExpandedImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
