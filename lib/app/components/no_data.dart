import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class NoData extends StatelessWidget {
  final String? text;
  const NoData({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        80.verticalSpace,
        Image.asset(Constants.noData),
        20.verticalSpace,
        Text(
          text ?? 'No Data',
          style: context.textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
