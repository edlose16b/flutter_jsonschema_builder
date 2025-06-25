import 'package:flutter_jsonschema_builder/src/helpers/is_url.dart';
import 'package:flutter_jsonschema_builder/src/models/property_schema.dart';

String? inputValidationJsonSchema(
    {required String newValue, required SchemaProperty property}) {
  if (newValue.isEmpty) {
    return 'Required';
  }

  if ((newValue.length <= (property.minLength?.toInt() ?? 0)) &&
      property.minLength != null) {
    return 'should NOT be shorter than ${property.minLength} characters';
  }

  if ((property.format == PropertyFormat.uri)) {
    if (!(isURL(newValue))) {
      return 'you should enter a uri';
    }
  }
  return null;
}
