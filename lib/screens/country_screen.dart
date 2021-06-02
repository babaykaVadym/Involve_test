import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:involve_test_country/controller/country_controller.dart';

import 'map_screen.dart';

class CountryScreen extends GetView<CountryController> {
  String searchString = "";
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Country"),
      ),
      body: GetX<CountryController>(
        initState: (state) => Get.find<CountryController>(),
        builder: (controller) {
          return controller.isLoading.value
              ? controller.countryLis.isEmpty
                  ? Center(
                      child: TextButton(
                        child: Text("Повторить"),
                        onPressed: () {
                          controller.isLoading.toggle();
                          controller.getCountry();
                        },
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                  labelText: "Поиск",
                                  hintText: "Поиск",
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0)))),
                              onChanged: (text) {
                                searchString = text.toLowerCase();
                                if (searchString.length >= 3) {
                                  controller.timerRead();
                                  controller.countryLis.refresh();
                                } else if (searchString.length == 0) {
                                  controller.timerRead();
                                  controller.countryLis.refresh();
                                }
                              },
                            ),
                          ),
                        ),
                        controller.isSerch.value
                            ? Expanded(
                                child: ListView.builder(
                                    itemCount: controller.countryLis.length,
                                    itemBuilder: (context, index) {
                                      var country =
                                          controller.countryLis[index];
                                      return country.name
                                              .toLowerCase()
                                              .contains(searchString)
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Dismissible(
                                                key: UniqueKey(),
                                                confirmDismiss:
                                                    (direction) async {
                                                  final bool res =
                                                      await showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              content: Text(
                                                                  "Delete ${country.name}?"),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: Text(
                                                                    "No",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child: Text(
                                                                    "Yes",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .countryLis
                                                                        .removeAt(
                                                                            index);
                                                                    controller
                                                                        .countryLis
                                                                        .refresh();
                                                                    Get.back();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                  return res;
                                                },
                                                background: Container(
                                                  color: Colors.red,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                        size: 35,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                direction:
                                                    DismissDirection.endToStart,
                                                child: ListTile(
                                                  leading: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            6,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            5,
                                                    child: SvgPicture.network(
                                                      country.flag,
                                                      allowDrawingOutsideViewBox:
                                                          true,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  title: Text(
                                                    country.name,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(country.subregion),
                                                      Text(country.alpha2Code)
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    controller.countryId.value =
                                                        country;
                                                    print(country.alpha2Code ==
                                                        "RU");
                                                    country.alpha2Code == "RU"
                                                        ? controller
                                                            .zoom.value = 1.7
                                                        : controller
                                                            .zoom.value = 5;

                                                    Get.to(MapScreen());
                                                  },
                                                ),
                                              ),
                                            )
                                          : Container();
                                    }))
                            : Center(
                                child: Image.asset(
                                  'images/load.gif',
                                  scale: 2.5,
                                ),
                              ),
                      ],
                    )
              : Center(
                  child: Image.asset(
                    'images/load.gif',
                    scale: 2.5,
                  ),
                );
        },
      ),
    );
  }
}
