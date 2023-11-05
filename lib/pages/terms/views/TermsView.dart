// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/terms_controller.dart';

class TermsView extends GetView<TermsController> {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TermsController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Política de Privacidad de SwapMe:',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                'Introducción:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '- SwapMe es una plataforma que permite a los usuarios intercambiar prendas de vestir entre sí.',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
               SizedBox(
                height: 8.h,
              ),
             
              Text(
                'Información Recopilada:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '- SwapMe recopila información como nombre de usuario, dirección de correo electrónico y número de teléfono para facilitar la comunicación entre usuarios.',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              //actualizacion de datos
              Text(
                'Actualización de Datos',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              Text(
                '- Los usuarios pueden actualizar sus datos personales en cualquier momento a través de la plataforma.',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
               Text(
                '- Los unicos datos actualizables son la foto de perfil, nombre de usuario, apellido de usuario; ya que los demas datos son usados en otras funciones internas que garantizan el funcionamiento de la plataforma.',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                '- También se pueden recopilar datos sobre las prendas, preferencias de moda y otra información relacionada con la plataforma.',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                'Uso de la Información:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '- La información recopilada se utiliza para permitir la comunicación entre usuarios con fines de intercambio de prendas.',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                '- Podemos utilizar la información para mejorar la experiencia del usuario y personalizar recomendaciones.',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                '- La información recopilada puede ser utilizada para mejorar la plataforma y sus servicios.',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                'Compartir Información:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '- La información recopilada no será compartida con terceros.',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                'Seguridad:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '- La información recopilada se almacena en servidores seguros.',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                'Cambios en la Política de Privacidad:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '- SwapMe se reserva el derecho de modificar esta política de privacidad en cualquier momento.',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                'Contacto:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '- Para cualquier duda o consulta, puede contactarnos a través de la siguiente dirección de correo electrónico: swapme.ec@gmail.com ',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
               SizedBox(
                height: 16.h,
              ),
              Text(
                'SwapMe 2023 - Todos los derechos reservados',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),             
            ],
          ),
        ),
      ),
    );
  }
}
