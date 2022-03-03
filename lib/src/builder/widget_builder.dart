// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/array_schema_builder.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/widget_builder_logic.dart';
import 'package:flutter_jsonschema_form/src/builder/object_schema_builder.dart';
import 'package:flutter_jsonschema_form/src/builder/property_schema_builder.dart';
import 'dart:convert';

import '../models/models.dart';

class JsonForm extends StatefulWidget {
  const JsonForm({
    Key? key,
    required this.jsonSchema,
    this.uiSchema,
    required this.onFormDataSaved,
  }) : super(key: key);

  final String jsonSchema;
  final String? uiSchema;
  final void Function(dynamic) onFormDataSaved;

  @override
  _JsonFormState createState() => _JsonFormState();
}

class _JsonFormState extends State<JsonForm> {
  late SchemaObject mainSchema;

  final _formKey = GlobalKey<FormState>();

  _JsonFormState();

  @override
  void initState() {
    print('initState');

    mainSchema = (Schema.fromJson(json.decode(widget.jsonSchema),
        id: kGenesisIdKey) as SchemaObject)
      ..setUiSchema(
          widget.uiSchema != null ? json.decode(widget.uiSchema!) : null);

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
                          // if (_formKey.currentState != null &&
                          //     _formKey.currentState!.validate()) {
                          _formKey.currentState?.save();

                          print(WidgetBuilderInherited.of(context).data);

                          widget.onFormDataSaved(
                              WidgetBuilderInherited.of(context).data);
                          // }
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
    this.schemaObject,
  }) : super(key: key);
  final Schema mainSchema;
  final Schema schema;
  final SchemaObject? schemaObject;
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
