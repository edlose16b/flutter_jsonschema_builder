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
    "type": "object",
    "title": "Dirección de residencia",
    "properties": {
        "professional_occupation": {
            "enum": [
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9
            ],
            "type": "number",
            "title": "Professional Occupation",
            "enumNames": [
                "Assalariado",
                "Profissional Liberal",
                "Autônomo",
                "Empresário",
                "Proprietário Rural",
                "Aposentado",
                "Funcionário Público",
                "Dependente",
                "Estudante"
            ]
        }
    },
    "dependencies": {
         "professional_occupation": {
                    "oneOf": [
                        {
                            "required": [
                                "professional_occupation",
                                "wealths"
                            ],
                            "properties": {
                                "wealths": {
                                    "type": "array",
                                    "items": {
                                        "type": "object",
                                        "properties": {
                                            "wealth_desc": {
                                                "type": "string",
                                                "title": "Wealth Description"
                                            },
                                            "wealth_type": {
                                                "enum": [
                                                    1,
                                                    2,
                                                    3,
                                                    7
                                                ],
                                                "type": "number",
                                                "title": "Wealth Type",
                                                "enumNames": [
                                                    "Bem imóvel",
                                                    "Aplicação Financeira",
                                                    "Salário / pró-labore",
                                                    "Outros"
                                                ]
                                            },
                                            "wealth_value": {
                                                "type": "number",
                                                "title": "Wealth Value"
                                            }
                                        }
                                    }
                                },
                                "professional_occupation": {
                                    "enum": [
                                        8,
                                        9
                                    ]
                                }
                            }
                        },
                        {
                            "required": [
                                "professional_occupation",
                                "institution_name"
                            ],
                            "properties": {
                                "institution_name": {
                                    "type": "string",
                                    "title": "Work name"
                                },
                                "professional_occupation": {
                                    "enum": [
                                        3,
                                        6                                        
                                    ]
                                }
                            }
                        }
                    ]
                }
    }
}
''';

  final uiSchema = null;

  // '''{
  //           "ui:order": [
  //               "name",
  //               "short_name",
  //               "tax_payer_registry",
  //               "birth_date",
  //               "father_name",
  //               "mother_name",
  //               "gender",
  //               "nationality",
  //               "country_birth",
  //               "state_birth",
  //               "state_birth_name",
  //               "professional_occupation",
  //               "institution_name",
  //               "wealths",
  //               "civil_state",
  //               "civil_state_type",
  //               "spouse_name",
  //               "educational_level",
  //               "PPE",
  //               "ppe_occupation",
  //               "document",
  //               "phone",
  //               "email",
  //               "address"
  //           ]
  //       }''';

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
