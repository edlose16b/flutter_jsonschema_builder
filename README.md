<p align="center">

  <h3 align="center">flutter-jsonschema-form</h3>

  <p align="center">
    A simple <a href="https://flutter.dev/">Flutter</a> widget capable of using <a href="http://json-schema.org/">JSON Schema</a> to declaratively build and customize web forms.
    <br />
    Inspired by <a href="https://github.com/rjsf-team/react-jsonschema-form">react-jsonschema-form</a>
    <br />    
</p>

## Installation

Add dependency to pubspec.yaml

```
dependencies:
  ...
  flutter_jsonschema_form:
    git:
      url: git://github.com/edlose16b/flutter_jsonschema_form.git
      ref: main
```

Run in your terminal

```
flutter packages get
```

See the [File Picker Installation](https://github.com/miguelpruivo/plugins_flutter_file_picker) for file fields.

## Usage

```dart
import 'package:flutter_jsonschema_form/flutter_jsonschema_form.dart';


final jsonSchema = {
  "title": "A registration form",
  "description": "A simple form example.",
  "type": "object",
  "required": [
    "firstName",
    "lastName"
  ],
  "properties": {
    "firstName": {
      "type": "string",
      "title": "First name",
      "default": "Chuck"
    },
    "lastName": {
      "type": "string",
      "title": "Last name"
    },
    "telephone": {
      "type": "string",
      "title": "Telephone",
      "minLength": 10
    }
  }
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    body: JsonForm(
      jsonSchema: jsonSchema,
      onFormDataSaved: (data) {
        inspect(data);
      },
    ),
  );
}
```

## Additional information
WIP
