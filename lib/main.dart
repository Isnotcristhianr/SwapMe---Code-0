import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/data/local/my_shared_pref.dart';
import 'app/routes/app_pages.dart';
import 'config/theme/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:connectivity/connectivity.dart';

//permiso
/* import 'package:permission_handler/permission_handler.dart';
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
/*     name: 'SwapApp',
 */
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Verificar la conectividad antes de iniciar la aplicación
  var connectivityResult = await Connectivity().checkConnectivity();
  bool isConnected = (connectivityResult != ConnectivityResult.none);

  // Iniciar la aplicación solo si hay conexión a Internet
  if (isConnected) {
    //solictar permiso
    /* var status = await Permission.camera.request();
    if (status.isGranted) {
      await MySharedPref.init();
      runApp(const MyApp());
    } else {
      // ignore: avoid_print
      print('permiso denegado');
    } */
    await MySharedPref.init();
    runApp(const MyApp());
  } else {
    // Mostrar una pantalla de error cuando no hay conexión
    runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off,
                  size: 100,
                  color: Color.fromARGB(255, 155, 244, 54),
                ),
                SizedBox(height: 20),
                Text(
                  'Swapme App',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'No internet connection',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return GetMaterialApp(
          title: "SwapMe App",
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            bool themeIsLight = MySharedPref.getThemeIsLight();
            return Theme(
              data: MyTheme.getThemeData(isLight: themeIsLight),
              child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: widget!,
              ),
            );
          },
          initialRoute:
              AppPages.INITIAL, // first screen to show when app is running
          getPages: AppPages.routes, // app screens
        );
      },
    );
  }
}
