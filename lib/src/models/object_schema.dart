import '../models/models.dart';

class SchemaObject extends Schema {
  SchemaObject({
    required String id,
    this.required = const [],
    String? title,
    String? description,
  }) : super(
          id: id,
          title: title ?? 'no-title',
          type: SchemaType.object,
          description: description,
        );

  factory SchemaObject.fromJson(String id, Map<String, dynamic> json) {
    final schema = SchemaObject(
      id: id,
      title: json['title'],
      description: json['description'],
      required: json["required"] != null
          ? List<String>.from(json["required"].map((x) => x))
          : [],
    );

    schema.setProperties(json['properties'], schema);
    schema.setOneOf(json['oneOf'], schema);

    return schema;
  }
  // ! Getters
  bool get isGenesis => id == kGenesisIdKey;

  /// array of required keys
  List<String> required;
  List<Schema>? properties;

  List<Schema>? oneOf;

  void setProperties(
      Map<String, Map<String, dynamic>>? properties, SchemaObject schema) {
    if (properties == null) return;
    var props = <Schema>[];

    properties.forEach((key, _property) {
      final isRequired = schema.required.contains(key);
      Schema? property;

      property = Schema.fromJson(
        _property,
        id: key,
        parent: schema,
      );

      if (property is SchemaProperty) property.required = isRequired;

      props.add(property);
    });

    this.properties = props;
  }

  void setOneOf(Map<String, Map<String, dynamic>>? oneOf, SchemaObject schema) {
    if (oneOf == null) return;
    var oneOfs = <Schema>[];
    oneOf.forEach((key, _property) {
      oneOfs.add(Schema.fromJson(_property, id: key, parent: schema));
    });

    this.oneOf = oneOfs;
  }
}
