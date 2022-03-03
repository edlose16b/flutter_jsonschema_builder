import '../models/models.dart';

enum PropertyFormat { general, password, date, datetime, email, dataurl, uri }

PropertyFormat propertyFormatFromString(String? value) {
  switch (value) {
    case 'password':
      return PropertyFormat.password;
    case 'date':
      return PropertyFormat.date;
    case 'datetime':
      return PropertyFormat.datetime;
    case 'email':
      return PropertyFormat.email;
    case 'data-url':
      return PropertyFormat.dataurl;
    case 'uri':
      return PropertyFormat.uri;
    default:
      return PropertyFormat.general;
  }
}

dynamic safeDefaultValue(Map<String, dynamic> json) {
  return schemaTypeFromString(json['type']) == SchemaType.boolean
      ? json['default'] == 'true'
      : json['default'];
}

class SchemaProperty extends Schema {
  SchemaProperty({
    required String id,
    required SchemaType type,
    String? title,
    String? description,
    this.defaultValue,
    this.enumm,
    this.enumNames,
    this.required = false,
    this.format = PropertyFormat.general,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.oneOf,
    this.readOnly = false,
  }) : super(
          id: id,
          title: title ?? 'no-title',
          type: type,
          description: description,
        );

  factory SchemaProperty.fromJson(
    String id,
    Map<String, dynamic> json, {
    Schema? parent,
  }) {
    final property = SchemaProperty(
      id: id,
      title: json['title'],
      type: schemaTypeFromString(json['type']),
      format: propertyFormatFromString(json['format']),
      defaultValue: safeDefaultValue(json),
      description: json['description'],
      // enums
      enumm: json['enum'],
      enumNames: json['enumNames'],
      minLength: json['minLength'],
      maxLength: json['maxLength'],
      pattern: json['pattern'],
      oneOf: json['oneOf'],
      readOnly: json['readOnly'] ?? false,
    );
    property.parentIdKey = parent?.idKey;
    property.dependentsAddedBy.addAll(parent?.dependentsAddedBy ?? []);

    return property;
  }

  factory SchemaProperty.fromUi(
      SchemaProperty prop, Map<String, dynamic> uiSchema) {
    SchemaProperty property = prop;

    // set general ui schema
    setUiToProperty(property, uiSchema);

    // set custom ui schema for property
    if (uiSchema.containsKey(property.id)) {
      setUiToProperty(property, uiSchema[property.id]);
    }

    return property;
  }

  @override
  SchemaProperty copyWith({
    required String id,
    String? parentIdKey,
    List<String>? dependentsAddedBy,
  }) {
    var newSchema = SchemaProperty(
        id: id,
        title: title,
        type: type,
        description: description,
        format: format,
        defaultValue: defaultValue,
        enumNames: enumNames,
        enumm: enumm,
        required: required,
        oneOf: oneOf)
      ..autoFocus = autoFocus
      ..order = order
      ..widget = widget
      ..disabled = disabled
      ..emptyValue = emptyValue
      ..help = help
      ..maxLength = maxLength
      ..minLength = minLength
      ..widget = widget
      ..parentIdKey = parentIdKey ?? this.parentIdKey
      ..dependentsAddedBy = dependentsAddedBy ?? this.dependentsAddedBy
      ..required = required
      ..dependents = dependents;

    return newSchema;
  }

  PropertyFormat format;

  /// it means enum
  List? enumm;

  /// displayed as text if is not empty
  List? enumNames;

  dynamic defaultValue;

  // propiedades que se llenan con el json
  bool? disabled;
  bool required;
  List<String>? order;
  bool? autoFocus;
  int? minLength, maxLength;
  String? pattern;
  dynamic dependents;
  bool readOnly;

  /// indica si sus dependentes han sido activados por XDependencies
  bool isDependentsActive = false;

  // not suported yet
  String? widget, emptyValue, help = '';
  List<dynamic>? oneOf;

  void setDependents(SchemaObject schema) {
    print('Intentando anadir dependts de $id');
    final dependents = schema.dependencies?[id];
    // Asignamos las propiedades que dependen de este
    if (schema.dependencies != null && dependents != null) {
      if (dependents is Map) {
        schema.isOneOf = dependents.containsKey("oneOf");
      }
      if (dependents is List || schema.isOneOf) {
        this.dependents = dependents;
      } else {
        this.dependents = Schema.fromJson(
          dependents,
          // id: '',
          parent: schema,
        );
      }
    }
  }
}

setUiToProperty(SchemaProperty property, Map<String, dynamic> uiSchema) {
  uiSchema.forEach((key, data) {
    switch (key) {
      case "ui:disabled":
        property.disabled = data as bool;
        break;
      case "ui:order":
        property.order = List<String>.from(data);
        break;
      case "ui:autofocus":
        property.autoFocus = data as bool;
        break;
      case "ui:emptyValue":
        property.emptyValue = data as String;
        break;
      case "ui:title":
        property.title = data as String;
        break;
      case "ui:description":
        property.description = data as String;
        break;
      case "ui:help":
        property.help = data as String;
        break;
      case "ui:widget":
        property.widget = data as String;
        break;
      default:
        break;
    }
  });

  return property;
}
