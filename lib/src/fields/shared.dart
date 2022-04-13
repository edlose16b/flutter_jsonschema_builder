import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/src/builder/logic/widget_builder_logic.dart';

class CustomErrorText extends StatelessWidget {
  const CustomErrorText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Text(
        text,
        style: WidgetBuilderInherited.of(context).jsonFormSchemaStyle.error,
      ),
    );
  }
}
