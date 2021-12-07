import '../models/models.dart';

class SchemaObject extends Schema {
  SchemaObject({
    required String id,
    this.required = const [],
    this.dependencies,
    String? title,
    String? description,
  }) : super(
          id: id,
          title: title ?? 'no-title',
          type: SchemaType.object,
          description: description,
        );

  factory SchemaObject.fromJson(
    String id,
    Map<String, dynamic> json, {
    Schema? parent,
  }) {
    final schema = SchemaObject(
      id: id,
      title: json['title'],
      description: json['description'],
      required: json["required"] != null
          ? List<String>.from(json["required"].map((x) => x))
          : [],
      dependencies: json['dependencies'],
    );

    schema.parentIdKey = parent?.idKey;
    schema.setProperties(json['properties'], schema);
    schema.setOneOf(json['oneOf'], schema);

    return schema;
  }

  @override
  Schema copyWith({
    required String id,
    String? parentIdKey,
  }) {
    var newSchema = SchemaObject(
      id: id,
      title: title,
      description: description,
    )
      ..parentIdKey = parentIdKey ?? this.parentIdKey
      ..type = type
      ..dependencies = dependencies
      ..oneOf = oneOf
      ..required = required;

    final otherProperties = properties!; //.map((p) => p.copyWith(id: p.id));

    newSchema.properties = otherProperties
        .map((e) => e.copyWith(id: e.id, parentIdKey: newSchema.idKey))
        .toList();

    return newSchema;
  }

  // ! Getters
  bool get isGenesis => id == kGenesisIdKey;

  /// array of required keys
  List<String> required;
  List<Schema>? properties;

  /// the dependencies keyword from an earlier draft of JSON Schema
  /// (note that this is not part of the latest JSON Schema spec, though).
  /// Dependencies can be used to create dynamic schemas that change fields based on what data is entered
  Map<String, dynamic>? dependencies;

  /// A [Schema] with [oneOf] is valid if exactly one of the subschemas is valid.
  List<Schema>? oneOf;

  void setProperties(
    Map<String, Map<String, dynamic>>? properties,
    SchemaObject schema,
  ) {
    if (properties == null) return;
    var props = <Schema>[];
    properties.forEach((key, _property) {
      final isRequired = schema.required.contains(key);
      final dependents = schema.dependencies?[key];

      Schema? property;
      print('Esta es $_property');
      property = Schema.fromJson(
        _property,
        id: key,
        parent: schema,
      );

      if (property is SchemaProperty) {
        property.required = isRequired;

        // Asignamos las propiedades que dependen de este
        if (dependencies != null) {
          property.dependents = dependents;
          print('==================');
          print(dependents);
        }
      }

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
