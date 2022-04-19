import 'package:flutter/material.dart';

class JsonFormSchemaUiConfig {
  JsonFormSchemaUiConfig({
    this.fieldTitle,
    this.error,
    this.title,
    this.subtitle,
    this.description,
    this.label,
    this.addItemBuilder,
    this.removeItemBuilder,
    this.submitButtonBuilder,
  });

  TextStyle? fieldTitle;
  TextStyle? error;
  TextStyle? title;
  TextStyle? subtitle;
  TextStyle? description;
  TextStyle? label;

  Widget Function(VoidCallback onPressed)? addItemBuilder;
  Widget Function(VoidCallback onPressed)? removeItemBuilder;
  Widget Function(VoidCallback onSubmit)? submitButtonBuilder;
}
