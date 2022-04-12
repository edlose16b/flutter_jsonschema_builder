// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
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
    this.customFileHandler,
    this.buildSubmitButton,
  }) : super(key: key);

  final String jsonSchema;
  final void Function(dynamic) onFormDataSaved;

  final String? uiSchema;
  final Future<List<File>?> Function()? customFileHandler;

  /// render a custom submit button
  /// @param [VoidCallback] submit function
  final ButtonStyleButton Function(VoidCallback)? buildSubmitButton;

  @override
  _JsonFormState createState() => _JsonFormState();
}

class _JsonFormState extends State<JsonForm> {
  late SchemaObject mainSchema;

  final _formKey = GlobalKey<FormState>();

  _JsonFormState();

  @override
  void initState() {
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
      customFileHandler: widget.customFileHandler,
      child: Builder(builder: (context) {
        final widgetBuilderInherited = WidgetBuilderInherited.of(context);

        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      if (!kReleaseMode)
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
                          const Divider(),
                          if (mainSchema.description != null)
                            Text(
                              mainSchema.description!,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                        ],
                      ),
                      FormFromSchemaBuilder(
                        mainSchema: mainSchema,
                        schema: mainSchema,
                      ),
                      const SizedBox(height:20),
                      widget.buildSubmitButton == null
                          ? ElevatedButton(
                              onPressed: () => onSubmit(widgetBuilderInherited),
                              child: const Text('Enviar'),
                            )
                          : widget.buildSubmitButton!(
                              () => onSubmit(widgetBuilderInherited)),
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
  void onSubmit(WidgetBuilderInherited widgetBuilderInherited) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      print(widgetBuilderInherited.data);

      widget.onFormDataSaved(widgetBuilderInherited.data);
    }
  }
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
