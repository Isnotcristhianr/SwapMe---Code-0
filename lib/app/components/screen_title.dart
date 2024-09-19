import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final double? dividerEndIndent;

  const ScreenTitle({
    super.key,
    required this.title,
    this.subtitle = '',
    this.dividerEndIndent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.theme.textTheme.displayLarge?.copyWith(
            fontSize: 35.sp, // Tamaño de fuente más grande para el título
            fontWeight: FontWeight.bold,
            color: Colors.black, // Color del título
          ),
        ),
        Text(
          subtitle,
          style: context.theme.textTheme.displayMedium?.copyWith(
            fontSize: 18.sp, // Tamaño de fuente más pequeño para el subtítulo
            fontWeight: FontWeight.bold,
            color: Colors.grey, // Color del subtítulo
          ),
        ),
        Divider(
          thickness: 4,
          endIndent: dividerEndIndent ?? 10,
        ),
        SizedBox(height: 20.h)
      ],
    );
  }
}
