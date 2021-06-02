import 'dart:convert';

import 'package:http/http.dart' as http;

import 'country_model.dart';

class CountryProvider {
  Future<List<CountryModel>> getCountryList() async {
    var response = await http
        .get(Uri.parse("https://restcountries.eu/rest/v2/region/europe"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((country) => new CountryModel.fromJson(country))
          .toList();
    } else {
      print(response.statusCode);
      print(response.body);
      return null;
    }
  }
}
