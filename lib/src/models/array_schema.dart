import '../models/models.dart';

class SchemaArray extends Schema {
  SchemaArray({
    required String id,
    String? title,
    this.minItems,
    this.maxItems,
    this.uniqueItems = true,
  }) : super(
          id: id,
          title: title ?? 'no-title',
          type: SchemaType.array,
        );

  factory SchemaArray.fromJson(String id, Map<String, dynamic> json) {
    final property = SchemaArray(
      id: id,
      title: json['title'],
      minItems: json['minItems'],
      maxItems: json['maxItems'],
      uniqueItems: json['uniqueItems'] ?? true,
    );

    if (json['items'] is Object) {
      property.items = Schema.fromJson(
        json['items'],
        // id: 'oemano',
        parent: property,
      );
    } else {
      property.items = (json['items'] as List<Map<String, dynamic>>)
          .map((e) => Schema.fromJson(e));
    }

    return property;
  }

  /// can be array of [Schema] or [Schema]
  dynamic items;

  int? minItems;
  int? maxItems;
  bool uniqueItems;
}
