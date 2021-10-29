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
    this.parent,
  });

  factory Schema.fromJson(
    Map<String, dynamic> json, {
    String id = kNoIdKey,
    Schema? parent,
  }) {
    Schema schema;

    switch (schemaTypeFromString(json['type'])) {
      case SchemaType.object:
        schema = SchemaObject.fromJson(id, json);
        break;

      case SchemaType.array:
        schema = SchemaArray.fromJson(id, json);

        break;

      default:
        schema = SchemaProperty.fromJson(id, json);
        break;
    }

    return schema..parent = parent;
  }

  // props
  String id;
  String title;
  String? description;
  SchemaType type;

  // util props
  Schema? parent;

  /// it lets us know the key in the formData Map {key}
  String get idKey {
    if (parent != null && !parent!.id.contains(kGenesisIdKey)) {
      if (parent!.id == kNoIdKey) {
        var parentParent = parent?.parent;
        bool parentParentIsArray = parentParent?.type == SchemaType.array;

        if (parentParentIsArray) {
          parentParent = parentParent as SchemaArray;
          var totalChilds = 0;
          if (parentParent.items is List) {
            totalChilds = parentParent.items.length;
          }

          return _appendId('${parentParent.idKey}.$totalChilds', id);
        }

        return _appendId(parentParent!.idKey, id);
      }

      return _appendId(parent!.idKey, id);
    }

    return id;
  }

  String _appendId(String path, String id) =>
      id != kNoIdKey ? '$path.$id' : path;
}
