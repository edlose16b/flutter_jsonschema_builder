// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';

import './fields/fields.dart';
import './models/models.dart';

const String _kNoTitle = 'no-title';

class JsonForm extends StatefulWidget {
  const JsonForm({
    Key? key,
    required this.jsonSchema,
    required this.onFormDataSaved,
  }) : super(key: key);

  final Map<String, dynamic> jsonSchema;
  final void Function(dynamic) onFormDataSaved;

  @override
  _JsonFormState createState() => _JsonFormState();
}

class _JsonFormState extends State<JsonForm> {
  late SchemaObject schema;

  final _formKey = GlobalKey<FormState>();

  /// final data
  dynamic data = {};

  get formData => data;
  // String get formData => json.encode(data);

  _JsonFormState();

  @override
  void initState() {
    schema =
        Schema.fromJson(widget.jsonSchema, id: kGenesisIdKey) as SchemaObject;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(width: double.infinity),
                      Text(
                        schema.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      // const Divider(color: Colors.black),
                      if (schema.description != null)
                        Text(
                          schema.description!,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: _buildFormFromSchema(schema),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        print('Data es ->');
                        print(data);

                        widget.onFormDataSaved(formData);
                      }
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFromSchema(Schema schema) {
    if (schema is SchemaProperty) {
      return _buildProperty(schema);
    }
    if (schema is SchemaArray) {
      return _buildArray(schema);
    }

    if (schema is SchemaObject) {
      return _buildObject(schema);
    }

    return const SizedBox.shrink();
  }

  /// Esto es lo que realmente pinta el campo
  Widget _buildProperty(SchemaProperty property) {
    Widget _field = const SizedBox.shrink();

    if (property.enumm != null) {
      _field = DropDownJFormField(
        property: property,
        onSaved: (val) {
          log('onSaved: DateJFormField  ${property.idKey}  : $val');
          updateObjectData(data, property.idKey, val);
        },
      );
    } else {
      switch (property.type) {
        case SchemaType.string:
          if (property.format == PropertyFormat.date ||
              property.format == PropertyFormat.datetime) {
            _field = DateJFormField(
              property: property,
              onSaved: (val) {
                log('onSaved: DateJFormField  ${property.idKey}  : $val');
                updateObjectData(data, property.idKey, val);
              },
            );
            break;
          }

          if (property.format == PropertyFormat.dataurl) {
            _field = FileJFormField(
              property: property,
              onSaved: (val) {
                log('onSaved: FileJFormField  ${property.idKey}  : $val');
                updateObjectData(data, property.idKey, val);
              },
            );
            break;
          }

          _field = TextJFormField(
              property: property,
              onSaved: (val) {
                log('onSaved: TextJFormField ${property.idKey}  : $val');
                updateObjectData(data, property.idKey, val);
              });
          break;
        case SchemaType.integer:
        case SchemaType.number:
          _field = NumberJFormField(
            property: property,
            onSaved: (val) {
              log('onSaved: NumberJFormField ${property.idKey}  : $val');
              updateObjectData(data, property.idKey, val);
            },
          );
          break;
        case SchemaType.boolean:
          _field = CheckboxJFormField(
            property: property,
            onSaved: (val) {
              log('onSaved: CheckboxJFormField ${property.idKey}  : $val');
              updateObjectData(data, property.idKey, val);
            },
          );
          break;
        default:
          _field = TextJFormField(
            property: property,
            onSaved: (val) {
              log('onSaved: TextJFormField ${property.idKey}  : $val');
              updateObjectData(data, property.idKey, val);
            },
          );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          property.idKey,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        _field,
      ],
    );
  }

  Widget _buildArray(SchemaArray schema) {
    print(schema);
    if (schema.items is List) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Array ' + schema.idKey),
          ...(schema.items as List).map((e) => _buildFormFromSchema(e)).toList()
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            schema.title,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          if (schema.description != null)
            Text(
              schema.description!,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          _buildFormFromSchema(schema.items)
        ],
      );
    }
  }

  Widget _buildObject(SchemaObject schema) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (this.schema.title != schema.title && schema.title != _kNoTitle)
          Text(
            schema.title,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        if (schema.description != null)
          Text(
            schema.description!,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        if (this.schema.title != schema.title) const SizedBox(height: 25),
        if (schema.properties != null)
          ...schema.properties!.map((e) => _buildFormFromSchema(e)).toList()
      ],
    );
  }

  //  Form methods

  void updateObjectData(object, String path, dynamic value) {
    print('updateObjectData $object path $path value $value');

    final stack = path.split('.');

    while (stack.length > 1) {
      final _key = stack[0];
      final isNextKeyInteger = int.tryParse(stack[1]) != null;
      final newContent = isNextKeyInteger ? [] : {};
      final _keyNumeric = int.tryParse(_key);

      log('$_key - next Key is int? $isNextKeyInteger');

      _addNewContent(object, _keyNumeric, newContent);

      final tempObject = object[_keyNumeric ?? _key];
      if (tempObject != null) {
        object = tempObject;
      } else {
        object[_key] = newContent;
        object = object[_key];
      }

      stack.removeAt(0);
    }

    final _key = stack[0];
    final _keyNumeric = int.tryParse(_key);
    _addNewContent(object, _keyNumeric, value);

    object[_keyNumeric ?? _key] = value;
    stack.removeAt(0);
  }

  void _addNewContent(object, int? _keyNumeric, dynamic value) {
    if (object is List && _keyNumeric != null) {
      if (object.length - 1 < _keyNumeric) {
        object.add(value);
      }
    }
  }
}
