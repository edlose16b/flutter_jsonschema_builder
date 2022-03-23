import 'package:flutter/foundation.dart';

import '../models/models.dart';

extension SchemaArrayX on SchemaArray {
  bool get isMultipleFile {
    return items.isNotEmpty &&
        items.first is SchemaProperty &&
        (items.first as SchemaProperty).format == PropertyFormat.dataurl;
  }
}

class SchemaArray extends Schema {
  SchemaArray({
    required String id,
    required this.itemsBaseSchema,
    String? title,
    this.minItems,
    this.maxItems,
    this.uniqueItems = true,
    this.items = const [],
  }) : super(
          id: id,
          title: title ?? 'no-title',
          type: SchemaType.array,
        );

  factory SchemaArray.fromJson(
    String id,
    Map<String, dynamic> json, {
    Schema? parent,
  }) {
    final schemaArray = SchemaArray(
      id: id,
      title: json['title'],
      minItems: json['minItems'],
      maxItems: json['maxItems'],
      uniqueItems: json['uniqueItems'] ?? true,
      itemsBaseSchema: json['items'],
    );

    schemaArray.parentIdKey = parent?.idKey;
    schemaArray.dependentsAddedBy.addAll(parent?.dependentsAddedBy ?? []);

    return schemaArray;
  }
  @override
  SchemaArray copyWith({
    required String id,
    String? parentIdKey,
    List<String>? dependentsAddedBy,
  }) {
    var newSchema = SchemaArray(
      id: id,
      title: title,
      maxItems: maxItems,
      minItems: minItems,
      uniqueItems: uniqueItems,
      itemsBaseSchema: itemsBaseSchema,
    )
      ..parentIdKey = parentIdKey ?? this.parentIdKey
      ..dependentsAddedBy = dependentsAddedBy ?? this.dependentsAddedBy
      ..type = type;

    newSchema.items = items
        .map((e) => e.copyWith(
              id: e.id,
              parentIdKey: newSchema.idKey,
              dependentsAddedBy: newSchema.dependentsAddedBy,
            ))
        .toList();

    return newSchema;
  }

  /// can be array of [Schema] or [Schema]
  List<Schema> items;

  // it allow us
  dynamic itemsBaseSchema;

  int? minItems;
  int? maxItems;
  bool uniqueItems;
}
