import 'package:get/get.dart';
import 'package:swapme/app/modules/cart/bindings/swap_binding.dart';
import 'package:swapme/app/modules/cart/views/swap_product_view.dart';
import 'package:swapme/app/modules/products/bindings/product_binding.dart';
import 'package:swapme/app/modules/products/views/register_product.dart';
import 'package:swapme/pages/login/bindings/login_binding.dart';
import 'package:swapme/pages/login/views/confirmPassword.dart';
import 'package:swapme/pages/signup/bindings/signup_binding.dart';


import '../modules/base/bindings/base_binding.dart';
import '../modules/base/views/base_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/favorites/bindings/favorites_binding.dart';
import '../modules/favorites/views/favorites_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/product_details/bindings/product_details_binding.dart';
import '../modules/product_details/views/product_details_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../../pages/terms/views/TermsView.dart';
import '../../pages/terms/bindings/terms_binding.dart';

//login
import '../../pages/login/views/login.dart';
//welcome
import '../../pages/signup/views/signup.dart';
//signup
import '../../pages/welcome.dart';
part 'app_routes.dart';




class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.BASE,
      page: () => const BaseView(),
      binding: BaseBinding(),
    ),
    //login
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    //welcome
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomePage(),
    ),
    //signup
    GetPage(
      name: _Paths.SIGNUP,
      page: () => Signup(),
      binding: SignUpBinding(),
    ),
    //terminos y condiciones
    GetPage(
      name: _Paths.TERMS,
      page: () => const TermsView(),
      binding: TermsBinding(),
    ),

    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITES,
      page: () => const FavoritesView(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () => const ProductDetailsView(),
      binding: ProductDetailsBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: _Paths.CONFIRM_PASSWORD,
      page: () => ConfirmRestorePassword(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_PRODUCT,
      page: () => RegisterProductScreen(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.SWAP_PRODUCT,
      page: () => const SwapConfirmScreen(),
      binding: SwapBinding(),
    ),
  ];
}
