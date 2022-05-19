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
  return schemaTypeFromString(json['type']) == SchemaType.boolean &&
          json['default'] is String
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

  void setUi(Map<String, dynamic> uiSchema) {
    // set general ui schema
    setUiToProperty(uiSchema);

    // set custom ui schema for property
    if (uiSchema.containsKey(id)) {
      setUiToProperty(uiSchema[id]);
    }
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
      ..dependents = dependents
      ..isMultipleFile = isMultipleFile;

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
  bool isMultipleFile = false;

  /// indica si sus dependentes han sido activados por XDependencies
  bool isDependentsActive = false;

  // not suported yet
  String? widget, emptyValue, help = '';
  List<dynamic>? oneOf;

  void setDependents(SchemaObject schema) {
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

  void setUiToProperty(Map<String, dynamic> uiSchema) {
    uiSchema.forEach((key, data) {
      switch (key) {
        case "ui:disabled":
          print('aplicamos pues ctmr');
          disabled = data as bool;
          break;
        case "ui:order":
          order = List<String>.from(data);
          break;
        case "ui:autofocus":
          autoFocus = data as bool;
          break;
        case "ui:emptyValue":
          emptyValue = data as String;
          break;
        case "ui:title":
          title = data as String;
          break;
        case "ui:description":
          description = data as String;
          break;
        case "ui:help":
          help = data as String;
          break;
        case "ui:widget":
          widget = data as String;
          break;
        default:
          break;
      }
    });
  }
}
