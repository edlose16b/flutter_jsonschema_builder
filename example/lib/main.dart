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
  final json = '''
 
{
    "title": "A registration form",
    "description": "A simple form example.",
    "type": "object",
    "required": [
        "firstName",
        "lastName"
    ],
    "properties": {
        "firstName": {
            "type": "string",
            "title": "First name",
            "default": "Chuck"
        },
        "lastName": {
            "type": "string",
            "title": "Last name"
        },
        "country": {
            "title": "Country Form",
            "type": "object",
            "required": [
                "country",
                "state"
            ],
            "properties": {
                "country": {
                    "type": "string",
                    "title": "Country",
                    "enum": [
                        0,
                        1,
                        2
                    ],
                    "enumNames": [
                        "Seleccione",
                        "Perú",
                        "Chile"
                    ],
                    "default" : 2
                }
            },
            "dependencies": {
                "country": {
                    "oneOf": [
                        {
                            "required": [
                                "state",
                                "country"
                            ],
                            "properties": {
                                "country": {
                                    "enum": [
                                        1
                                    ]
                                },
                                "state": {
                                    "type": "string",
                                    "title": "Estado",
                                    "enum": [
                                        0,
                                        1,
                                        2,
                                        3,
                                        4,
                                        5
                                    ],
                                    "enumNames": [
                                        "Seleccione",
                                        "Lima",
                                        "Arequipa",
                                        "Cuzco",
                                        "Piura",
                                        "Madre de Dios"
                                    ]

                                },
                                "cola" : {
                                    "type": "string",
                                    "title": "Cola"
                                }
                            }
                        },
                        {
                            "required": [
                                "state",
                                "country"
                            ],
                            "properties": {
                                "country": {
                                    "enum": [
                                        2
                                    ]
                                },
                                "state": {
                                    "type": "string",
                                    "title": "Estado",
                                    "enum": [
                                        0,
                                        10,
                                        22
                                    ],
                                    "enumNames": [
                                        "Seleccione",
                                        "Arica",
                                        "Atacama"
                                    ]

                                },
                                "cola" : {
                                    "type": "string",
                                    "title": "Cola"
                                }
                            }
                        }
                    ]
                },
                "state": {
                    "oneOf": [
                        {
                            "required": [
                                "district",
                                "state"
                            ],
                            "properties": {
                                "state": {
                                    "enum": [
                                        1
                                    ]
                                },
                                "district": {
                                    "type": "string",
                                    "title": "Address state name"
                                }
                            }
                        }
                    ]
                }
            }
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
              uiSchema: uiSchema,
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
