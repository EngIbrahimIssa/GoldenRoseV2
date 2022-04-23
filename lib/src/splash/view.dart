import 'dart:math';

import 'package:entaj/src/colors.dart';
import 'package:entaj/src/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final SplashLogic logic = Get.put(SplashLogic());
  bool start = false;

  late AnimationController controller;
  late Animation<Offset> offset;
  late Animation<Offset> offset2;

  @override
  void initState() {

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    offset =
        Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(controller);

    offset2 =
        Tween<Offset>(begin: const Offset(-1, 0), end:Offset.zero)
            .animate(controller);
    controller.forward();

    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => setState(() {
              _width = 375.w;
              _height = 812.h;
            }));
    super.initState();
  }

  double _width = 0;
  double _height = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: SlideTransition(
                          position: offset, child: Image.asset(imageTextAr))),
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 3000),
                      curve: Curves.fastOutSlowIn,
                      width: _width,
                      height: _height,
                      child: Image.asset(imageRose, scale: 2),
                    ),
                  ),
                  Expanded(
                      child: SlideTransition(
                          position: offset2, child: Image.asset(imageTextEn))),
                ],
              ),
            ),
          ),
        ));
  }
}
