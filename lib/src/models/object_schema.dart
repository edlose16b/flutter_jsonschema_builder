import 'dart:convert';
import 'dart:developer';

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
    print(json['properties']);
    var propertyMap = Map<String, dynamic>.from(json['properties']);
    print('==========');
    print(propertyMap);
    schema.parentIdKey = parent?.idKey;
    schema.setProperties(propertyMap, schema);
    schema.setOneOf(json['oneOf'], schema);

    return schema;
  }

  factory SchemaObject.fromUi(
      SchemaObject prop, Map<String, dynamic> uiSchema) {
    SchemaObject property = prop;
    uiSchema.forEach((key, data) {
      switch (key) {
        case "ui:order":
          property.order = data as List<String>;
          break;
        case "ui:title":
          property.title = data as String;
          break;
        case "ui:description":
          property.description = data as String;
          break;
        default:
          break;
      }
    });
    return property;
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
      ..order = order
      ..required = required;

    final otherProperties = properties!; //.map((p) => p.copyWith(id: p.id));

    newSchema.properties = otherProperties
        .map((e) => e.copyWith(id: e.id, parentIdKey: newSchema.idKey))
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
    var props = <Schema>[];
    uiSchema?.forEach((key, data) {
      //print(key);

      for (int i = 0; i < (properties?.length ?? 0); i++) {
        var propertiesTemp = properties?[i];
        if (propertiesTemp?.type == SchemaType.boolean) {
          if (data is Map) {
            data.forEach((ky, val) {
              if (propertiesTemp is SchemaProperty) {
                props.add(SchemaProperty.fromUi(propertiesTemp, val));
              }
            });
          }
        } else if (propertiesTemp is SchemaObject) {
          props.add(SchemaObject.fromUi(propertiesTemp, uiSchema));
        } else if (propertiesTemp is SchemaProperty) {
          props.add(SchemaProperty.fromUi(propertiesTemp, uiSchema));
        }
      }
    });
    if (props is List) {
      if (props.isNotEmpty) {
        for (int j = 0;
            j < ((props.first as dynamic).order?.length ?? 0);
            j++) {
          for (int i = 0; i < props.length; i++) {
            var propsTemp = props[i];
            if (props[i].idKey == (props.first as dynamic).order?[j]) {
              props.removeAt(i);
              props.insert((props.length - 1), propsTemp);
            }
          }
        }
        this.properties = props;
      } else {
        this.properties = properties;
      }
    }
  }

  void setProperties(
    Map? properties,
    SchemaObject schema,
  ) {
    if (properties == null) return;
    var props = <Schema>[];

    properties.forEach((key, _property) {
      final isRequired = schema.required.contains(key);
      final dependents = schema.dependencies?[key];
      Schema? property;

      property = Schema.fromJson(
        _property,
        id: key,
        parent: schema,
      );

      if (property is SchemaProperty) {
        property.required = isRequired;
        // Asignamos las propiedades que dependen de este
        if (dependencies != null && dependents != null) {
          if (dependents is Map) {
            isOneOf = dependents.containsKey("oneOf");
          }
          if (dependents is List<String> || isOneOf) {
            property.dependents = dependents;
          } else {
            property.dependents = Schema.fromJson(
              dependents,
              // id: '',
              parent: schema,
            );
          }
        }
      }
      props.add(property);
    });

    this.properties = props;
  }

  void setOneOf(List<dynamic>? oneOf, SchemaObject schema) {
    if (oneOf == null) return;
    oneOf.map((e) => Map<String, dynamic>.from(e));
    var oneOfs = <Schema>[];
    print(oneOf);
    for (var element in oneOf) {
      print(element);
      oneOfs.add(Schema.fromJson(element, parent: schema));
    }
    /*  oneOf.forEach((key, _property) {
      print('??????');
      print(_property);
      oneOfs.add(Schema.fromJson(_property, id: key, parent: schema));
    }); */

    print(oneOfs);

    this.oneOf = oneOfs;
  }

  void add(SchemaProperty schemaProperty) {}
}
