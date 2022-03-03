import '../models/models.dart';

extension SchemaArrayX on SchemaArray {
  bool get isMultipleFile {
    return items.first is SchemaProperty &&
        (items.first as SchemaProperty).format == PropertyFormat.dataurl;
  }
}

class SchemaArray extends Schema {
  SchemaArray({
    required String id,
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
    );

    schemaArray.parentIdKey = parent?.idKey;
    schemaArray.dependentsAddedBy.addAll(parent?.dependentsAddedBy ?? []);
    if (json['items'] is Object) {
      final newSchema = Schema.fromJson(
        json['items'],
        id: '0',
        parent: schemaArray,
      );

      schemaArray.items = [newSchema];
    } else {
      schemaArray.items = (json['items'] as List<Map<String, dynamic>>)
          .map((e) => Schema.fromJson(
                e,
                id: '0',
                parent: schemaArray,
              ))
          .toList();
    }

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

  int? minItems;
  int? maxItems;
  bool uniqueItems;
}
