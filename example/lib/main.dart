import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_jsonschema_form/flutter_jsonschema_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final json = {
    "title": "Widgets",
    "type": "object",
    "properties": {
      "stringFormats": {
        "type": "object",
        "title": "String formats",
        "properties": {
          "email": {"type": "string", "format": "email"},
          "uri": {"type": "string", "format": "uri"}
        }
      },
      "boolean": {
        "type": "object",
        "title": "Boolean field",
        "properties": {
          "default": {
            "type": "boolean",
            "title": "checkbox (default)",
            "description": "This is the checkbox-description"
          },
          "radio": {
            "type": "boolean",
            "title": "radio buttons",
            "description": "This is the radio-description"
          },
          "select": {
            "type": "boolean",
            "title": "select box",
            "description": "This is the select-description"
          }
        }
      },
      "string": {
        "type": "object",
        "title": "String field",
        "properties": {
          "default": {"type": "string", "title": "text input (default)"},
          "textarea": {"type": "string", "title": "textarea"},
          "placeholder": {"type": "string"},
          "color": {
            "type": "string",
            "title": "color picker",
            "default": "#151ce6"
          }
        }
      },
      "secret": {"type": "string", "default": "I'm a hidden string."},
      "disabled": {
        "type": "string",
        "title": "A disabled field",
        "default": "I am disabled."
      },
      "readonly": {
        "type": "string",
        "title": "A readonly field",
        "default": "I am read-only."
      },
      "readonly2": {
        "type": "string",
        "title": "Another readonly field",
        "default": "I am also read-only.",
        "readOnly": true
      },
      "widgetOptions": {
        "title": "Custom widget with options",
        "type": "string",
        "default": "I am yellow"
      },
      "selectWidgetOptions": {
        "title": "Custom select widget with options",
        "type": "string",
        "enum": ["foo", "bar"],
        "enumNames": ["Foo", "Bar"]
      }
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            JsonForm(
              jsonSchema: json,
              onFormDataSaved: (data) {
                inspect(data);
              },
            )
          ],
        ),
      ),
    );
  }
}
