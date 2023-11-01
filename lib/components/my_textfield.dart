import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final int? maxLength;
  final String? initalValue;
  final String? label;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.onChanged,
    this.validator,
    this.maxLength,
    this.initalValue,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        TextFormField(
          initialValue: initalValue,
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          maxLength: maxLength,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              counterStyle: null,
              counterText: '',
              counter: null,
              semanticCounterText: null,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500])),
        ),
      ],
    );
  }
}

class MyPasswordTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final RxBool show = RxBool(false);

  MyPasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        validator: validator,
        controller: controller,
        obscureText: show.value,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () => show.value = !show.value,
            icon: Icon(show.value ? Icons.visibility : Icons.visibility_off),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
