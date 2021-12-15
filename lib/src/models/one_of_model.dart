// To parse this JSON data, do
//
// @victwise

import 'dart:convert';

OneOfModel oneOfModelFromJson(String str) => OneOfModel.fromJson(json.decode(str));

String oneOfModelToJson(OneOfModel data) => json.encode(data.toJson());

class OneOfModel {
    OneOfModel({
        this.oneOfModelEnum,
        this.type,
        this.title,
    });

    List<String>? oneOfModelEnum;
    String? type;
    String? title;

    factory OneOfModel.fromJson(Map<String, dynamic> json) => OneOfModel(
        oneOfModelEnum: List<String>.from(json["enum"].map((x) => x)),
        type: json["type"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "enum": List<dynamic>.from(oneOfModelEnum?.map((x) => x)??[]),
        "type": type,
        "title": title,
    };
}
