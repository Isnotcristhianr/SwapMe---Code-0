import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swapme/utils/helpers.dart';

class ImageSelector extends StatelessWidget {
  final TextEditingController controller;
  final RxString imageSelected = RxString('');
  final Function()? onChange;

  ImageSelector({
    super.key,
    required this.controller,
    this.onChange,
  }) {
    imageSelected.value = controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Obx(
            () {
              Image image =
                  getImage(imageSelected.value, onlyImage: false) as Image;
              return Container(
                height: 300.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: image.image,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 60,
            right: 20,
            child: IconButton(
              onPressed: () async {
                try {
                  final picker = ImagePicker();
                  final XFile? pickedFile = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 20,
                  );
                  if (pickedFile == null) return;
                  imageSelected.value = pickedFile.path;
                  controller.text = pickedFile.path;
                  if (onChange != null) onChange!();
                } catch (e) {
                  e.toString();
                }
              },
              icon: const Icon(Icons.add_a_photo),
              color: Colors.white,
              iconSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
