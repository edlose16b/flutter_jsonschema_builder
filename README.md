<p align="center">

  <h3 align="center">flutter_jsonschema_builder</h3>

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
  flutter_jsonschema_builder: ^0.0.1+1
```

Run in your terminal

```
flutter packages get
```

See the [File Picker Installation](https://github.com/miguelpruivo/plugins_flutter_file_picker) for file fields.

## Usage

```dart
import 'package:flutter_jsonschema_builder/flutter_jsonschema_builder.dart';


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
<img width="364" alt="image" src="https://user-images.githubusercontent.com/58694638/187986742-3b1aa96c-4a85-42a3-aec0-dac62a8515a4.png">

### Using arrays & Files
```dart
  final json = '''
{
  "title": "Example 2",
  "type": "object",
  "properties": {
   "listOfStrings": {
      "type": "array",
      "title": "A list of strings",
      "items": {
        "type": "string",
        "title" : "Write your item",
        "default": "bazinga"
      }
    },
    "files": {
      "type": "array",
      "title": "Multiple files",
      "items": {
        "type": "string",
        "format": "data-url"
      }
    }
  }
}
  ''';

### Using UI Schema
```dart

final uiSchema = '''
{
  "selectYourCola": {
    "ui:widget": "radio"
  }
 }
''';

```
<img width="348" alt="image" src="https://user-images.githubusercontent.com/58694638/187996261-ab3be73d-35e0-40c5-a0de-47900b64f1be.png">


### Custom File Handler 

```dart
customFileHandler: () => {
  'profile_photo': () async {
    
    return [
      File(
          'https://cdn.mos.cms.futurecdn.net/LEkEkAKZQjXZkzadbHHsVj-970-80.jpg')
    ];
  },
  '*': null
}
```

### Using Custom Validator

```dart
customValidatorHandler: () => {
  'selectYourCola': (value) {
    if (value == 0) {
      return 'Cola 0 is not allowed';
    }
  }
},
```
<img width="659" alt="image" src="https://user-images.githubusercontent.com/58694638/187993619-15adcfaf-2a0c-4ae0-ada4-4617d814f85e.png">


### TODO

- [ ] Add all examples
- [ ] OnChanged
- [ ] References
- [ ] pub.dev

