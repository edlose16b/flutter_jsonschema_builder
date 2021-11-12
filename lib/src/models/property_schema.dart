import '../models/models.dart';

enum PropertyFormat { general, password, date, datetime, email, dataurl, url }

PropertyFormat propertyFormatFromString(String? value) {
  switch (value) {
    case 'password':
      return PropertyFormat.password;
    case 'date':
      return PropertyFormat.date;
    case 'date-time':
      return PropertyFormat.datetime;
    case 'email':
      return PropertyFormat.email;
    case 'data-url':
      return PropertyFormat.dataurl;
    default:
      return PropertyFormat.general;
  }
}

class SchemaProperty extends Schema {
  SchemaProperty(
      {required String id,
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
      this.pattern})
      : super(
          id: id,
          title: title ?? 'no-title',
          type: type,
          description: description,
        );

  factory SchemaProperty.fromJson(String id, Map<String, dynamic> json) {
    final property = SchemaProperty(
        id: id,
        title: json['title'],
        type: schemaTypeFromString(json['type']),
        format: propertyFormatFromString(json['format']),
        defaultValue: json['default'],
        description: json['description'],
        // enums
        enumm: json['enum'],
        enumNames: json['enumNames'],
        minLength: json['minLength'],
        maxLength: json['maxLength'],
        pattern: json['pattern']);

    return property;
  }

  PropertyFormat format;

  /// it means enum
  List? enumm;

  /// displayed as text if is not empty
  List? enumNames;

  dynamic defaultValue;

  // propiedades que se llenan con el json
  bool required;
  bool? autoFocus;
  int? minLength, maxLength;
  String? pattern;

  // not suported yet
  String? widget, emptyValue, help = '';
  dynamic oneOf;
}
