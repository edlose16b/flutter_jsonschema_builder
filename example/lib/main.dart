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
    "title": "Contextualized errors",
    "type": "object",
    "properties": {
      "firstName": {
        "type": "string",
        "title": "First name",
        "minLength": 8,
        "pattern": "\\d+",
        "maxLength": 10,
      },
      "active": {"type": "boolean", "title": "Active"},
      "skills": {
        "type": "array",
        "items": {"type": "string", "minLength": 5}
      },
      "multipleChoicesList": {
        "type": "array",
        "title": "Pick max two items",
        "uniqueItems": true,
        "maxItems": 2,
        "items": {
          "type": "string",
          "enum": ["foo", "bar", "fuzz"]
        }
      },
      "datetime": {"type": "string", "format": "date-time"},
      "date": {"type": "string", "format": "date", "default": "11-11-2021"}
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
