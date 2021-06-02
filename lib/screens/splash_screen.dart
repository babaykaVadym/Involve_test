import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:involve_test_country/controller/country_controller.dart';

import 'country_screen.dart';

class SplashScreen extends StatelessWidget {
  CountryController controller;
  @override
  Widget build(BuildContext context) {
    controller = Get.put(CountryController());
    controller.getCountry();

    Timer(Duration(seconds: 4), () {
      Get.off(CountryScreen());
    });
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'images/load.gif',
          scale: 2.5,
        ),
      ),
    );
  }
}
