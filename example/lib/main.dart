import 'dart:developer';
import 'dart:io';
import 'dart:ui';

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
  final json = '''
 {
  "title": "Files",
  "type": "object",
  "properties": {
    "file": {
      "type": "string",
      "format": "data-url",
      "title": "Single file"
    },
    "files": {
      "type": "array",
      "title": "Multiple files",
      "items": {
        "type": "string",
        "format": "data-url"
      }
    },
    "filesAccept": {
      "type": "string",
      "format": "data-url",
      "title": "Single File with Accept attribute"
    }
  }
}


  ''';

  final uiSchema = null;

//   '''
// {
//   "ui:order": [
//     "country",
//     "province",
//     "subject_comply",
//     "state",
//     "city",
//     "district",
//     "number",
//     "commune",
//     "street",
//     "postal_code"
//   ]
// }

//         ''';

  Future<List<File>?> defaultCustomFileHandler() async {
    await Future.delayed(const Duration(seconds: 3));
    final file1 = File(
        'https://cdn.mos.cms.futurecdn.net/LEkEkAKZQjXZkzadbHHsVj-970-80.jpg');
    final file2 = File(
        'https://cdn.mos.cms.futurecdn.net/LEkEkAKZQjXZkzadbHHsVj-970-80.jpg');
    final file3 = File(
        'https://cdn.mos.cms.futurecdn.net/LEkEkAKZQjXZkzadbHHsVj-970-80.jpg');

    return [file1, file2, file3];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              child: JsonForm(
                jsonSchema: json,
                uiSchema: uiSchema,
                onFormDataSaved: (data) {
                  inspect(data);
                },
                customFileHandlers: () => {
                  'files': defaultCustomFileHandler,
                  'file': () async {
                    return [
                      File(
                          'https://cdn.mos.cms.futurecdn.net/LEkEkAKZQjXZkzadbHHsVj-970-80.jpg')
                    ];
                  },
                  '*': null
                },
                buildSubmitButton: (onSubmit) {
                  return TextButton.icon(
                    onPressed: onSubmit,
                    icon: const Icon(Icons.heart_broken),
                    label: const Text('Enviar'),
                  );
                },
                jsonFormSchemaStyle: JsonFormSchemaStyle(
                  title: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
