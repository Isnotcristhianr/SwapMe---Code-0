import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swapme/app/routes/app_pages.dart';

import '../../../../utils/constants.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    var theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Constants.logo,
                width: 120.w,
                height: 90.h,
              ).animate().fade().slideY(
                  duration: const Duration(milliseconds: 500),
                  begin: 1,
                  curve: Curves.easeInSine),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Intercambia ',
                      style: theme.textTheme.displayMedium
                          ?.copyWith(color: theme.primaryColor),
                    ),
                    TextSpan(
                      text: 'para un mundo mejor',
                      style: theme.textTheme.displayMedium,
                    ),
                  ]),
                ).animate().fade().slideY(
                    duration: const Duration(milliseconds: 500),
                    begin: 5,
                    curve: Curves.easeInSine),
              ),
              SizedBox(height: 80.h),
              TextButton(
                onPressed: () {
                  Get.offNamed(Routes.WELCOME);
                },
                child: const Text('Iniciar').marginOnly(right: 20, left: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
