// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/array_schema_builder.dart';
import 'package:flutter_jsonschema_form/src/builder/object_schema_builder.dart';
import 'package:flutter_jsonschema_form/src/builder/property_schema_builder.dart';

import '../models/models.dart';

const String kNoTitle = 'no-title';

class WidgetBuilderInherited extends InheritedWidget {
  WidgetBuilderInherited({
    Key? key,
    required this.mainSchema,
    required Widget child,
  }) : super(key: key, child: child);

  final Schema mainSchema;
  dynamic data = {};

  static WidgetBuilderInherited of(BuildContext context) {
    final WidgetBuilderInherited? result =
        context.dependOnInheritedWidgetOfExactType<WidgetBuilderInherited>();
    assert(result != null, 'No WidgetBuilderInherited found in context');
    return result!;
  }

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

  @override
  bool updateShouldNotify(covariant WidgetBuilderInherited oldWidget) =>
      mainSchema != oldWidget.mainSchema;
}

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
  late SchemaObject mainSchema;

  final _formKey = GlobalKey<FormState>();

  /// final data
  // dynamic data = {};

  // get formData => data;

  _JsonFormState();

  @override
  void initState() {
    print('initState');
    mainSchema =
        Schema.fromJson(widget.jsonSchema, id: kGenesisIdKey) as SchemaObject;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetBuilderInherited(
      mainSchema: mainSchema,
      child: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          inspect(mainSchema);
                        },
                        child: const Text('INSPECT'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(width: double.infinity),
                          Text(
                            mainSchema.title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          if (mainSchema.description != null)
                            Text(
                              mainSchema.description!,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: FormFromSchemaBuilder(
                          mainSchema: mainSchema,
                          schema: mainSchema,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            _formKey.currentState?.save();

                            print('Data es ->');
                            print(WidgetBuilderInherited.of(context).data);

                            widget.onFormDataSaved(
                                WidgetBuilderInherited.of(context).data);
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
      }),
    );
  }

  //  Form methods

}

class FormFromSchemaBuilder extends StatelessWidget {
  const FormFromSchemaBuilder({
    Key? key,
    required this.mainSchema,
    required this.schema,
  }) : super(key: key);
  final Schema mainSchema;
  final Schema schema;
  @override
  Widget build(BuildContext context) {
    if (schema is SchemaProperty) {
      return PropertySchemaBuilder(
        mainSchema: mainSchema,
        schemaProperty: schema as SchemaProperty,
      );
    }
    if (schema is SchemaArray) {
      return ArraySchemaBuilder(
        mainSchema: mainSchema,
        schemaArray: schema as SchemaArray,
      );
    }

    if (schema is SchemaObject) {
      return ObjectSchemaBuilder(
        mainSchema: mainSchema,
        schemaObject: schema as SchemaObject,
      );
    }

    return const SizedBox.shrink();
  }
}
