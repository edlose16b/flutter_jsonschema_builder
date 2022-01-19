import 'dart:developer';

import 'package:flutter/foundation.dart';
import '../models/models.dart';
// Esto transforma el JSON a Modelos

enum SchemaType {
  string,
  number,
  boolean,
  integer,
  object,
  array,
  enumm,
}
SchemaType schemaTypeFromString(String value) {
  return SchemaType.values.where((e) => describeEnum(e) == value).first;
}

class Schema {
  Schema({
    required this.id,
    required this.type,
    this.title = 'no-title',
    this.description,
    this.parentIdKey,
  });

  factory Schema.fromJson(
    Map<String, dynamic> json, {
    String id = kNoIdKey,
    Schema? parent,
  }) {
    Schema schema;

// Solucion temporal y personalizada
    if (json['enum'] != null &&
        json['enum'] is List<String> &&
        json['enum'].length == 1) {
      return SchemaEnum(enumm: json['enum']);
    }

    json['type'] ??= 'object';


    switch (schemaTypeFromString(json['type'])) {
      case SchemaType.object:
        schema = SchemaObject.fromJson(id, json, parent: parent);
        break;

      case SchemaType.array:
        schema = SchemaArray.fromJson(id, json, parent: parent);

        break;

      default:
        schema = SchemaProperty.fromJson(id, json, parent: parent);
        break;
    }

    return schema;
  }

  // props
  String id;
  String title;
  String? description;
  SchemaType type;

  // util props
  String? parentIdKey;

  /// it lets us know the key in the formData Map {key}
  String get idKey {
    if (parentIdKey != null && parentIdKey != (kGenesisIdKey)) {
      if (this is SchemaProperty &&
          (this as SchemaProperty).format == PropertyFormat.dataurl) {
        return parentIdKey!;
      }

      return _appendId(parentIdKey!, id);
    }

    return id;
  }

  String _appendId(String path, String id) {
    return id != kNoIdKey ? (path.isNotEmpty ? '$path.' : '') + id : path;
  }

  Schema copyWith({
    required String id,
    String? parentIdKey,
  }) {
    return Schema(
      id: id,
      type: type,
      title: title,
      description: description,
      parentIdKey: parentIdKey ?? this.parentIdKey,
    );
  }
}

// Solucion temporal y personalizada
class SchemaEnum extends Schema {
  SchemaEnum({required this.enumm})
      : super(
          id: kNoIdKey,
          title: 'no-title',
          type: SchemaType.enumm,
        );

  final List<String> enumm;
}
