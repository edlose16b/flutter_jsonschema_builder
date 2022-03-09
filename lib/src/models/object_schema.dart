import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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

    schema.dependentsAddedBy.addAll(parent?.dependentsAddedBy ?? []);

    if (json['properties'] != null) {
      schema.setProperties(json['properties'], schema);
    }
    if (json['oneOf'] != null) {
      print('ay ombeee $json');
      schema.setOneOf(json['oneOf'], schema);
    }

    return schema;
  }

  void setUi(Map<String, dynamic> uiSchema) {
    uiSchema.forEach((key, data) {
      switch (key) {
        case "ui:order":
          order = List<String>.from(data);
          break;
        case "ui:title":
          title = data as String;
          break;
        case "ui:description":
          description = data as String;
          break;
        default:
          break;
      }
    });
  }

  @override
  Schema copyWith({
    required String id,
    String? parentIdKey,
    List<String>? dependentsAddedBy,
  }) {
    var newSchema = SchemaObject(
      id: id,
      title: title,
      description: description,
    )
      ..parentIdKey = parentIdKey ?? this.parentIdKey
      ..dependentsAddedBy = dependentsAddedBy ?? this.dependentsAddedBy
      ..type = type
      ..dependencies = dependencies
      ..oneOf = oneOf
      ..order = order
      ..required = required;

    final otherProperties = properties!; //.map((p) => p.copyWith(id: p.id));

    newSchema.properties = otherProperties
        .map((e) => e.copyWith(
              id: e.id,
              parentIdKey: newSchema.idKey,
              dependentsAddedBy: newSchema.dependentsAddedBy,
            ))
        .toList();

    return newSchema;
  }

  // ! Getters
  bool get isGenesis => id == kGenesisIdKey;

  bool isOneOf = false;

  /// array of required keys
  List<String> required;
  List<Schema>? properties;
  List<String>? order;

  /// the dependencies keyword from an earlier draft of JSON Schema
  /// (note that this is not part of the latest JSON Schema spec, though).
  /// Dependencies can be used to create dynamic schemas that change fields based on what data is entered
  Map<String, dynamic>? dependencies;

  /// A [Schema] with [oneOf] is valid if exactly one of the subschemas is valid.
  List<Schema>? oneOf;

  void setUiSchema(Map<String, dynamic>? uiSchema) {
    if (uiSchema == null) return;
    if (properties != null && properties!.isEmpty) return;

    // set UI Schema to this ObjectSchema
    setUi(uiSchema);

    // assert(() {
    //   if (order != null && properties != null) {
    //     return order?.length == properties?.length;
    //   }
    //   return true;
    // }(),
    //     'Invalid root object field configuration:uiSchema order list does not contain some properties');

    // set UI Schema to their properties
    properties?.forEach((_property) {
      if (_property is SchemaObject) {
        _property.setUi(uiSchema);
      } else if (_property is SchemaProperty) {
        _property.setUi(uiSchema);
      }
    });

    // order logic
    if (order != null) {
      properties!.sort((a, b) {
        return order!.indexOf(a.id) - order!.indexOf(b.id);
      });
    }
  }

  void setProperties(
    dynamic properties,
    SchemaObject schema,
  ) {
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

      if (property is SchemaProperty) {
        property.required = isRequired;
        // Asignamos las propiedades que dependen de este
        property.setDependents(schema);
      }
      props.add(property);
    });

    this.properties = props;
  }

  void setOneOf(List<dynamic>? oneOf, SchemaObject schema) {
    if (oneOf == null) return;
    oneOf.map((e) => Map<String, dynamic>.from(e));
    var oneOfs = <Schema>[];
    for (var element in oneOf) {
      print(element);
      oneOfs.add(Schema.fromJson(element, parent: schema));
    }

    this.oneOf = oneOfs;
  }
}
