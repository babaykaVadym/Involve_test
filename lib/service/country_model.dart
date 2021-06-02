import 'dart:convert';

// List<CountryModel> countryModelFromJson(String str) => List<CountryModel>.from(json.decode(str).map((x) => CountryModel.fromJson(x)));

// String countryModelToJson(List<CountryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryModel {
    CountryModel({
        this.name,
        this.alpha2Code,
        this.subregion,
        this.flag,
        this.latlng,
        this.borders,
        this.numericCode,
        this.currencies,
    });

    String name;
    String alpha2Code;
    String subregion;
    String flag;
    List<double> latlng;
    List<String> borders;
    String numericCode;
    List<Currency> currencies;

    factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        name: json["name"],
        alpha2Code: json["alpha2Code"],
        subregion: json["subregion"],
        flag: json["flag"],
        latlng: List<double>.from(json["latlng"].map((x) => x.toDouble())),
        borders: List<String>.from(json["borders"].map((x) => x)),
        numericCode: json["numericCode"],
        currencies: List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "alpha2Code": alpha2Code,
        "subregion": subregion,
        "flag": flag,
        "latlng": List<dynamic>.from(latlng.map((x) => x)),
        "borders": List<dynamic>.from(borders.map((x) => x)),
        "numericCode": numericCode,
        "currencies": List<dynamic>.from(currencies.map((x) => x.toJson())),
    };
}

class Currency {
    Currency({
        this.code,
        this.name,
        this.symbol,
    });

    String code;
    String name;
    String symbol;

    factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        code: json["code"],
        name: json["name"],
        symbol: json["symbol"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "symbol": symbol,
    };
}
