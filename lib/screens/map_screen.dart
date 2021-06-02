import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:involve_test_country/controller/country_controller.dart';
import 'package:latlong/latlong.dart';

class MapScreen extends GetView<CountryController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(controller.countryId.value.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                    center: LatLng(controller.countryId.value.latlng[0],
                        controller.countryId.value.latlng[1]),
                    zoom: controller.zoom.value),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Country code: ${controller.countryId.value.numericCode}"),
            Text("Currencies:"),
            Container(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.countryId.value.currencies.length,
                  itemBuilder: (context, index) {
                    print(controller.countryId.value.currencies.length);
                    var currenci = controller.countryId.value.currencies[index];
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Code ${currenci.code}"),
                          Text("Name ${currenci.name}"),
                          Text("Symbol ${currenci.symbol}"),
                        ],
                      ),
                    );
                  }),
            ),
            controller.countryId.value.borders.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Country borders:"),
                      Container(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                controller.countryId.value.borders.length,
                            itemBuilder: (context, index) {
                              var borders =
                                  controller.countryId.value.borders[index];
                              return Container(
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(borders),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
