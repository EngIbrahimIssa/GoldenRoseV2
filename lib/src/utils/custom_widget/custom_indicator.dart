import '../../colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIndicator extends StatelessWidget {

  final bool isActive;

  const CustomIndicator(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: 3.sp,
      width: 20.sp,
      decoration: BoxDecoration(
        color: isActive ? greenLightColor : Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
