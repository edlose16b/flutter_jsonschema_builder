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
      "title": "Antecedentes de la persona declarante",
      "type": "object",
      "properties": {
        "name": {
          "type": "string",
          "title": "Razón social",
          "default": "Tesla"
          // "format": "password"
        },
        "cola": {
          "type": "string",
          "title": "Gaseosa preferida",
          "default": "coca",
          "enum": ["coca", "pepsi", "7up"],
          "enumNames": ['Coca Cola', 'Pepsi', "7 Up"]
        },
        "birthday": {
          "type": "string",
          "format": "date",
          "title": "Fecha de constitución",
          "default": "04/09/1998"
        },
        "dni": {"type": "string", "title": "ID", "default": "Tax Tesla"},
        "company_address": {
          "type": "object",
          "title": "Domicilio social",
          "properties": {
            "street": {
              "type": "string",
              "title": "Dirección",
              "default": "Av. Tesla"
            },
            "city": {
              "type": "string",
              "title": "Ciudad",
              "default": "City Tesla"
            },
            "number_house": {
              "type": "string",
              "title": "Número de Casa",
              "default": "AB123"
            }
          },
          "required": ["street", "city", "number_house"]
        },
        "people": {
          "type": "array",
          "title": "Personas",
          "minItems": 1,
          "items": {
            "type": "object",
            "properties": {
              "first_name": {"type": "string", "title": "Nombre"},
              "last_name": {"type": "string", "title": "Apellido"},
              "id_number": {
                "type": "string",
                "title": "Número de documento de identidad"
              },
              "id_documents": {
                "type": "array",
                "uniqueItems": true,
                "minItems": 1,
                "maxItems": 2,
                "title": "Documentos de identidad (frente y reverso)",
                "items": {"type": "string", "format": "data-url"}
              }
            },
            "required": ["first_name", "last_name", "id_number", "id_documents"]
          }
        },
        "website": {
          "type": "string",
          "title": "Sitio web",
          "default": "tesla.com"
        },
        "contact_number": {
          "type": "string",
          "title": "Número de contacto",
          "default": "987654321"
        },
        "contact_email": {
          "type": "string",
          "title": "Email de contacto",
          "format": "email",
          "default": "info@tesla.com"
        },
        "society_type": {
          "type": "string",
          "title": "Tipo de sociedad",
          "default": "random text",
          "oneOf": [
            {
              "type": "string",
              "title": "Sociedad anónima",
              "enum": ["anonym"]
            },
            {
              "type": "string",
              "title": "Sociedad de responsabilidad limitada",
              "enum": ["limited_responsability"]
            },
            {
              "type": "string",
              "title": "Empresa individual de responsabilidad limitada",
              "enum": ["individual_limited_responsability"]
            },
            {
              "type": "string",
              "title": "Otro",
              "enum": ["another"]
            }
          ]
        }
      },
      "required": [
        "name",
        "birthday",
        "dni",
        "society_type",
        "people",
        "company_address",
        "website",
        "contact_number",
        "contact_email",
        "cola"
      ],
      "dependencies": {
        "society_type": {
          "oneOf": [
            {
              "properties": {
                "society_type": {
                  "enum": ["anonym"]
                }
              }
            },
            {
              "properties": {
                "society_type": {
                  "enum": ["another"]
                },
                "society_other_name": {
                  "type": "string",
                  "title": "Específique tipo de sociedad"
                }
              },
              "required": ["society_other_name"]
            },
            {
              "properties": {
                "society_type": {
                  "enum": ["limited_responsability"]
                }
              }
            },
            {
              "properties": {
                "society_type": {
                  "enum": ["individual_limited_responsability"]
                }
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
