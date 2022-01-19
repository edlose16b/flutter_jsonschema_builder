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
    "type": "object",
    "title": "Dirección de residencia",
    "required": ["country", "city",  "postal_code"],
    "properties": {
      "city": {
        "type": "string",
        "title": "Ciudad de residencia",
        "maxLength": 64
      },
     
      "country": {
        "type": "string",
        "oneOf": [
          {
            "enum": ["AR"],
            "type": "string",
            "title": "Argentina"
          },
          {
            "enum": ["CL"],
            "type": "string",
            "title": "Chile"
          },
           {
            "enum": ["BR"],
            "type": "string",
            "title": "Brazil"
          },
          {
            "enum": ["TW"],
            "type": "string",
            "title": "Taiwan"
          },
          {
            "enum": ["AF"],
            "type": "string",
            "title": "Afghanistan"
          },
          {
            "enum": ["AL"],
            "type": "string",
            "title": "Albania"
          },
          {
            "enum": [""],
            "type": "string",
            "title": ""
          }
        ],
        "title": "País de residencia"
      },
      // "postal_code": {
      //   "type": "string",
      //   "title": "Código postal",
      //   "maxLength": 32
      // }
    },
    "dependencies": {
      "country": {
        "oneOf": [
          {
            "required": ["subject_comply", "province"],
            "properties": {
              "country": {
                "enum": ["AR"]
              },
              "province": {
                "type": "string",
                "oneOf": [
                  {
                    "enum": ["1"],
                    "type": "string",
                    "title": "Buenos Aires"
                  },
                  {
                    "enum": ["10"],
                    "type": "string",
                    "title": "Catamarca"
                  }
                ],
                "title": "Provincia de residencia"
              },
              "subject_comply": {
                "type": "boolean",
                "title": "¿Eres Sujeto Obligado?",
                "default": "false",
                "enumNames": ["Sí", "No"]
              }
            }
          },
          {
            "required": ["state", "district", "number"],
            "properties": {
              "country": {
                "enum": ["BR"]
              },
              "state": {
                "type": "string",
                "oneOf": [
                  {
                    "enum": ["RO"],
                    "type": "string",
                    "title": "Rondônia"
                  },                  
                  {
                    "enum": ["GO"],
                    "type": "string",
                    "title": "Goiás"
                  },
                  {
                    "enum": ["DF"],
                    "type": "string",
                    "title": "Distrito Federal"
                  }
                ],
                "title": "Estado de residencia"
              },
              "number": {
                "type": "string",
                "title": "Número de residencia",
                "maxLength": 32
              },            
              "district": {
                "type": "string",
                "title": "Barrio/Distrito de residencia",
                "maxLength": 64
              }
            }
          },
          {
            "required": ["commune"],
            "properties": {
              "country": {
                "enum": ["CL"]
              },
              "commune": {
                "type": "string",
                "oneOf": [
                  {
                    "enum": ["arica"],
                    "type": "string",
                    "title": "Arica"
                  },
                  {
                    "enum": ["camarones"],
                    "type": "string",
                    "title": "Camarones"
                  },
                  {
                    "enum": ["general lagos"],
                    "type": "string",
                    "title": "General Lagos"
                  },
                  {
                    "enum": ["timaukel"],
                    "type": "string",
                    "title": "Timaukel"
                  },
                  {
                    "enum": ["torres del paine"],
                    "type": "string",
                    "title": "Torres del Paine"
                  }
                ],
                "title": "Comuna de residencia"
              },
             
            }
          }
        ]
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
