import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swapme/app/routes/app_pages.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/SwapMe Logo Horizontal.png',
              ).animate().fade().slideY(
                  duration: const Duration(milliseconds: 500),
                  begin: 1,
                  curve: Curves.easeInSine),
              20.verticalSpace,
             
              SizedBox(height: 8.h),
              TextButton(
                onPressed: () {
                  Get.offNamed(Routes.WELCOME);
                }, style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  //color rgb #1D853D
                  backgroundColor: const Color(0xFF1D853D),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 20, right: 20),
                  shape: const StadiumBorder(), // Bordes redondeados
                ),
                child: const Text('Iniciar').marginOnly(right: 20, left: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
