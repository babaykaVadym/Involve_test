import 'dart:async';

import 'package:get/get.dart';
import 'package:involve_test_country/service/country_api_provider.dart';
import 'package:involve_test_country/service/country_model.dart';

class CountryController extends GetxController {
  final countryLis = RxList();
  var countryId = CountryModel().obs;
  var isSerch = true.obs;
  var isLoading = false.obs;
  var zoom = RxDouble(5);
  @override
  void getCountry() async {
    var countryL = await CountryProvider().getCountryList();
    if (countryL != null) {
      print("isLoading.value  ${isLoading.value}");
      countryLis.value = countryL;
      Timer(Duration(milliseconds: 2500), () {
        print("isLoading.value  ${isLoading.value}");
        isLoading.value = true;
      });
    }
  }

  void timerRead() {
    isSerch.toggle();
    Timer(Duration(milliseconds: 1500), () {
      isSerch.toggle();
    });
  }
}
