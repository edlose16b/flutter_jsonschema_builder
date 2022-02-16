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
    "required": ["country", "city", "street", "postal_code"],
    "properties": {
      "city": {
        "type": "string",
        "title": "Ciudad de residencia",
        "maxLength": 64
      },
      "street": {
        "type": "string",
        "title": "Direccción de residencia",
        "maxLength": 128
      },
      "country": {
        "type": "string",
        "oneOf": [
          {
            "enum": ["TW"],
            "type": "string",
            "title": ""
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
            "enum": ["DZ"],
            "type": "string",
            "title": "Algeria"
          },
          {
            "enum": ["AS"],
            "type": "string",
            "title": "American Samoa"
          },
          {
            "enum": ["AD"],
            "type": "string",
            "title": "Andorra"
          },
          {
            "enum": ["AO"],
            "type": "string",
            "title": "Angola"
          },
          {
            "enum": ["AI"],
            "type": "string",
            "title": "Anguilla"
          },
          {
            "enum": ["AQ"],
            "type": "string",
            "title": "Antarctica"
          },
          {
            "enum": ["AG"],
            "type": "string",
            "title": "Antigua and Barbuda"
          },
          {
            "enum": ["AR"],
            "type": "string",
            "title": "Argentina"
          },
          {
            "enum": ["AM"],
            "type": "string",
            "title": "Armenia"
          },
          {
            "enum": ["AW"],
            "type": "string",
            "title": "Aruba"
          },
          {
            "enum": ["AU"],
            "type": "string",
            "title": "Australia"
          },
          {
            "enum": ["AT"],
            "type": "string",
            "title": "Austria"
          },
          {
            "enum": ["AZ"],
            "type": "string",
            "title": "Azerbaijan"
          },
          {
            "enum": ["BS"],
            "type": "string",
            "title": "Bahamas"
          },
          {
            "enum": ["BH"],
            "type": "string",
            "title": "Bahrain"
          },
          {
            "enum": ["BD"],
            "type": "string",
            "title": "Bangladesh"
          },
          {
            "enum": ["BB"],
            "type": "string",
            "title": "Barbados"
          },
          {
            "enum": ["BY"],
            "type": "string",
            "title": "Belarus"
          },
          {
            "enum": ["BE"],
            "type": "string",
            "title": "Belgium"
          },
          {
            "enum": ["BZ"],
            "type": "string",
            "title": "Belize"
          },
          {
            "enum": ["BJ"],
            "type": "string",
            "title": "Benin"
          },
          {
            "enum": ["BM"],
            "type": "string",
            "title": "Bermuda"
          },
          {
            "enum": ["BT"],
            "type": "string",
            "title": "Bhutan"
          },
          {
            "enum": ["BO"],
            "type": "string",
            "title": "Bolivia (Plurinational State of)"
          },
          {
            "enum": ["BQ"],
            "type": "string",
            "title": "Bonaire, Sint Eustatius and Saba"
          },
          {
            "enum": ["BA"],
            "type": "string",
            "title": "Bosnia and Herzegovina"
          },
          {
            "enum": ["BW"],
            "type": "string",
            "title": "Botswana"
          },
          {
            "enum": ["BV"],
            "type": "string",
            "title": "Bouvet Island"
          },
          {
            "enum": ["BR"],
            "type": "string",
            "title": "Brazil"
          },
          {
            "enum": ["IO"],
            "type": "string",
            "title": "British Indian Ocean Territory"
          },
          {
            "enum": ["VG"],
            "type": "string",
            "title": "British Virgin Islands"
          },
          {
            "enum": ["BN"],
            "type": "string",
            "title": "Brunei Darussalam"
          },
          {
            "enum": ["BG"],
            "type": "string",
            "title": "Bulgaria"
          },
          {
            "enum": ["BF"],
            "type": "string",
            "title": "Burkina Faso"
          },
          {
            "enum": ["BI"],
            "type": "string",
            "title": "Burundi"
          },
          {
            "enum": ["CV"],
            "type": "string",
            "title": "Cabo Verde"
          },
          {
            "enum": ["KH"],
            "type": "string",
            "title": "Cambodia"
          },
          {
            "enum": ["CM"],
            "type": "string",
            "title": "Cameroon"
          },
          {
            "enum": ["CA"],
            "type": "string",
            "title": "Canada"
          },
          {
            "enum": ["KY"],
            "type": "string",
            "title": "Cayman Islands"
          },
          {
            "enum": ["CF"],
            "type": "string",
            "title": "Central African Republic"
          },
          {
            "enum": ["TD"],
            "type": "string",
            "title": "Chad"
          },
          {
            "enum": ["CL"],
            "type": "string",
            "title": "Chile"
          },
          {
            "enum": ["CN"],
            "type": "string",
            "title": "China"
          },
          {
            "enum": ["HK"],
            "type": "string",
            "title": "China, Hong Kong Special Administrative Region"
          },
          {
            "enum": ["MO"],
            "type": "string",
            "title": "China, Macao Special Administrative Region"
          },
          {
            "enum": ["CX"],
            "type": "string",
            "title": "Christmas Island"
          },
          {
            "enum": ["CC"],
            "type": "string",
            "title": "Cocos (Keeling) Islands"
          },
          {
            "enum": ["CO"],
            "type": "string",
            "title": "Colombia"
          },
          {
            "enum": ["KM"],
            "type": "string",
            "title": "Comoros"
          },
          {
            "enum": ["CG"],
            "type": "string",
            "title": "Congo"
          },
          {
            "enum": ["CK"],
            "type": "string",
            "title": "Cook Islands"
          },
          {
            "enum": ["CR"],
            "type": "string",
            "title": "Costa Rica"
          },
          {
            "enum": ["HR"],
            "type": "string",
            "title": "Croatia"
          },
          {
            "enum": ["CU"],
            "type": "string",
            "title": "Cuba"
          },
          {
            "enum": ["CW"],
            "type": "string",
            "title": "Curaçao"
          },
          {
            "enum": ["CY"],
            "type": "string",
            "title": "Cyprus"
          },
          {
            "enum": ["CZ"],
            "type": "string",
            "title": "Czechia"
          },
          {
            "enum": ["CI"],
            "type": "string",
            "title": "Côte d'Ivoire"
          },
          {
            "enum": ["KP"],
            "type": "string",
            "title": "Democratic People's Republic of Korea"
          },
          {
            "enum": ["CD"],
            "type": "string",
            "title": "Democratic Republic of the Congo"
          },
          {
            "enum": ["DK"],
            "type": "string",
            "title": "Denmark"
          },
          {
            "enum": ["DJ"],
            "type": "string",
            "title": "Djibouti"
          },
          {
            "enum": ["DM"],
            "type": "string",
            "title": "Dominica"
          },
          {
            "enum": ["DO"],
            "type": "string",
            "title": "Dominican Republic"
          },
          {
            "enum": ["EC"],
            "type": "string",
            "title": "Ecuador"
          },
          {
            "enum": ["EG"],
            "type": "string",
            "title": "Egypt"
          },
          {
            "enum": ["SV"],
            "type": "string",
            "title": "El Salvador"
          },
          {
            "enum": ["GQ"],
            "type": "string",
            "title": "Equatorial Guinea"
          },
          {
            "enum": ["ER"],
            "type": "string",
            "title": "Eritrea"
          },
          {
            "enum": ["EE"],
            "type": "string",
            "title": "Estonia"
          },
          {
            "enum": ["SZ"],
            "type": "string",
            "title": "Eswatini"
          },
          {
            "enum": ["ET"],
            "type": "string",
            "title": "Ethiopia"
          },
          {
            "enum": ["FK"],
            "type": "string",
            "title": "Falkland Islands (Malvinas)"
          },
          {
            "enum": ["FO"],
            "type": "string",
            "title": "Faroe Islands"
          },
          {
            "enum": ["FJ"],
            "type": "string",
            "title": "Fiji"
          },
          {
            "enum": ["FI"],
            "type": "string",
            "title": "Finland"
          },
          {
            "enum": ["FR"],
            "type": "string",
            "title": "France"
          },
          {
            "enum": ["GF"],
            "type": "string",
            "title": "French Guiana"
          },
          {
            "enum": ["PF"],
            "type": "string",
            "title": "French Polynesia"
          },
          {
            "enum": ["TF"],
            "type": "string",
            "title": "French Southern Territories"
          },
          {
            "enum": ["GA"],
            "type": "string",
            "title": "Gabon"
          },
          {
            "enum": ["GM"],
            "type": "string",
            "title": "Gambia"
          },
          {
            "enum": ["GE"],
            "type": "string",
            "title": "Georgia"
          },
          {
            "enum": ["DE"],
            "type": "string",
            "title": "Germany"
          },
          {
            "enum": ["GH"],
            "type": "string",
            "title": "Ghana"
          },
          {
            "enum": ["GI"],
            "type": "string",
            "title": "Gibraltar"
          },
          {
            "enum": ["GR"],
            "type": "string",
            "title": "Greece"
          },
          {
            "enum": ["GL"],
            "type": "string",
            "title": "Greenland"
          },
          {
            "enum": ["GD"],
            "type": "string",
            "title": "Grenada"
          },
          {
            "enum": ["GP"],
            "type": "string",
            "title": "Guadeloupe"
          },
          {
            "enum": ["GU"],
            "type": "string",
            "title": "Guam"
          },
          {
            "enum": ["GT"],
            "type": "string",
            "title": "Guatemala"
          },
          {
            "enum": ["GG"],
            "type": "string",
            "title": "Guernsey"
          },
          {
            "enum": ["GN"],
            "type": "string",
            "title": "Guinea"
          },
          {
            "enum": ["GW"],
            "type": "string",
            "title": "Guinea-Bissau"
          },
          {
            "enum": ["GY"],
            "type": "string",
            "title": "Guyana"
          },
          {
            "enum": ["HT"],
            "type": "string",
            "title": "Haiti"
          },
          {
            "enum": ["HM"],
            "type": "string",
            "title": "Heard Island and McDonald Islands"
          },
          {
            "enum": ["VA"],
            "type": "string",
            "title": "Holy See"
          },
          {
            "enum": ["HN"],
            "type": "string",
            "title": "Honduras"
          },
          {
            "enum": ["HU"],
            "type": "string",
            "title": "Hungary"
          },
          {
            "enum": ["IS"],
            "type": "string",
            "title": "Iceland"
          },
          {
            "enum": ["IN"],
            "type": "string",
            "title": "India"
          },
          {
            "enum": ["ID"],
            "type": "string",
            "title": "Indonesia"
          },
          {
            "enum": ["IR"],
            "type": "string",
            "title": "Iran (Islamic Republic of)"
          },
          {
            "enum": ["IQ"],
            "type": "string",
            "title": "Iraq"
          },
          {
            "enum": ["IE"],
            "type": "string",
            "title": "Ireland"
          },
          {
            "enum": ["IM"],
            "type": "string",
            "title": "Isle of Man"
          },
          {
            "enum": ["IL"],
            "type": "string",
            "title": "Israel"
          },
          {
            "enum": ["IT"],
            "type": "string",
            "title": "Italy"
          },
          {
            "enum": ["JM"],
            "type": "string",
            "title": "Jamaica"
          },
          {
            "enum": ["JP"],
            "type": "string",
            "title": "Japan"
          },
          {
            "enum": ["JE"],
            "type": "string",
            "title": "Jersey"
          },
          {
            "enum": ["JO"],
            "type": "string",
            "title": "Jordan"
          },
          {
            "enum": ["KZ"],
            "type": "string",
            "title": "Kazakhstan"
          },
          {
            "enum": ["KE"],
            "type": "string",
            "title": "Kenya"
          },
          {
            "enum": ["KI"],
            "type": "string",
            "title": "Kiribati"
          },
          {
            "enum": ["KW"],
            "type": "string",
            "title": "Kuwait"
          },
          {
            "enum": ["KG"],
            "type": "string",
            "title": "Kyrgyzstan"
          },
          {
            "enum": ["LA"],
            "type": "string",
            "title": "Lao People's Democratic Republic"
          },
          {
            "enum": ["LV"],
            "type": "string",
            "title": "Latvia"
          },
          {
            "enum": ["LB"],
            "type": "string",
            "title": "Lebanon"
          },
          {
            "enum": ["LS"],
            "type": "string",
            "title": "Lesotho"
          },
          {
            "enum": ["LR"],
            "type": "string",
            "title": "Liberia"
          },
          {
            "enum": ["LY"],
            "type": "string",
            "title": "Libya"
          },
          {
            "enum": ["LI"],
            "type": "string",
            "title": "Liechtenstein"
          },
          {
            "enum": ["LT"],
            "type": "string",
            "title": "Lithuania"
          },
          {
            "enum": ["LU"],
            "type": "string",
            "title": "Luxembourg"
          },
          {
            "enum": ["MG"],
            "type": "string",
            "title": "Madagascar"
          },
          {
            "enum": ["MW"],
            "type": "string",
            "title": "Malawi"
          },
          {
            "enum": ["MY"],
            "type": "string",
            "title": "Malaysia"
          },
          {
            "enum": ["MV"],
            "type": "string",
            "title": "Maldives"
          },
          {
            "enum": ["ML"],
            "type": "string",
            "title": "Mali"
          },
          {
            "enum": ["MT"],
            "type": "string",
            "title": "Malta"
          },
          {
            "enum": ["MH"],
            "type": "string",
            "title": "Marshall Islands"
          },
          {
            "enum": ["MQ"],
            "type": "string",
            "title": "Martinique"
          },
          {
            "enum": ["MR"],
            "type": "string",
            "title": "Mauritania"
          },
          {
            "enum": ["MU"],
            "type": "string",
            "title": "Mauritius"
          },
          {
            "enum": ["YT"],
            "type": "string",
            "title": "Mayotte"
          },
          {
            "enum": ["MX"],
            "type": "string",
            "title": "Mexico"
          },
          {
            "enum": ["FM"],
            "type": "string",
            "title": "Micronesia (Federated States of)"
          },
          {
            "enum": ["MC"],
            "type": "string",
            "title": "Monaco"
          },
          {
            "enum": ["MN"],
            "type": "string",
            "title": "Mongolia"
          },
          {
            "enum": ["ME"],
            "type": "string",
            "title": "Montenegro"
          },
          {
            "enum": ["MS"],
            "type": "string",
            "title": "Montserrat"
          },
          {
            "enum": ["MA"],
            "type": "string",
            "title": "Morocco"
          },
          {
            "enum": ["MZ"],
            "type": "string",
            "title": "Mozambique"
          },
          {
            "enum": ["MM"],
            "type": "string",
            "title": "Myanmar"
          },
          {
            "enum": ["NA"],
            "type": "string",
            "title": "Namibia"
          },
          {
            "enum": ["NR"],
            "type": "string",
            "title": "Nauru"
          },
          {
            "enum": ["NP"],
            "type": "string",
            "title": "Nepal"
          },
          {
            "enum": ["NL"],
            "type": "string",
            "title": "Netherlands"
          },
          {
            "enum": ["NC"],
            "type": "string",
            "title": "New Caledonia"
          },
          {
            "enum": ["NZ"],
            "type": "string",
            "title": "New Zealand"
          },
          {
            "enum": ["NI"],
            "type": "string",
            "title": "Nicaragua"
          },
          {
            "enum": ["NE"],
            "type": "string",
            "title": "Niger"
          },
          {
            "enum": ["NG"],
            "type": "string",
            "title": "Nigeria"
          },
          {
            "enum": ["NU"],
            "type": "string",
            "title": "Niue"
          },
          {
            "enum": ["NF"],
            "type": "string",
            "title": "Norfolk Island"
          },
          {
            "enum": ["MP"],
            "type": "string",
            "title": "Northern Mariana Islands"
          },
          {
            "enum": ["NO"],
            "type": "string",
            "title": "Norway"
          },
          {
            "enum": ["OM"],
            "type": "string",
            "title": "Oman"
          },
          {
            "enum": ["PK"],
            "type": "string",
            "title": "Pakistan"
          },
          {
            "enum": ["PW"],
            "type": "string",
            "title": "Palau"
          },
          {
            "enum": ["PA"],
            "type": "string",
            "title": "Panama"
          },
          {
            "enum": ["PG"],
            "type": "string",
            "title": "Papua New Guinea"
          },
          {
            "enum": ["PY"],
            "type": "string",
            "title": "Paraguay"
          },
          {
            "enum": ["PE"],
            "type": "string",
            "title": "Peru"
          },
          {
            "enum": ["PH"],
            "type": "string",
            "title": "Philippines"
          },
          {
            "enum": ["PN"],
            "type": "string",
            "title": "Pitcairn"
          },
          {
            "enum": ["PL"],
            "type": "string",
            "title": "Poland"
          },
          {
            "enum": ["PT"],
            "type": "string",
            "title": "Portugal"
          },
          {
            "enum": ["PR"],
            "type": "string",
            "title": "Puerto Rico"
          },
          {
            "enum": ["QA"],
            "type": "string",
            "title": "Qatar"
          },
          {
            "enum": ["KR"],
            "type": "string",
            "title": "Republic of Korea"
          },
          {
            "enum": ["MD"],
            "type": "string",
            "title": "Republic of Moldova"
          },
          {
            "enum": ["RO"],
            "type": "string",
            "title": "Romania"
          },
          {
            "enum": ["RU"],
            "type": "string",
            "title": "Russian Federation"
          },
          {
            "enum": ["RW"],
            "type": "string",
            "title": "Rwanda"
          },
          {
            "enum": ["RE"],
            "type": "string",
            "title": "Réunion"
          },
          {
            "enum": ["BL"],
            "type": "string",
            "title": "Saint Barthélemy"
          },
          {
            "enum": ["SH"],
            "type": "string",
            "title": "Saint Helena"
          },
          {
            "enum": ["KN"],
            "type": "string",
            "title": "Saint Kitts and Nevis"
          },
          {
            "enum": ["LC"],
            "type": "string",
            "title": "Saint Lucia"
          },
          {
            "enum": ["MF"],
            "type": "string",
            "title": "Saint Martin (French Part)"
          },
          {
            "enum": ["PM"],
            "type": "string",
            "title": "Saint Pierre and Miquelon"
          },
          {
            "enum": ["VC"],
            "type": "string",
            "title": "Saint Vincent and the Grenadines"
          },
          {
            "enum": ["WS"],
            "type": "string",
            "title": "Samoa"
          },
          {
            "enum": ["SM"],
            "type": "string",
            "title": "San Marino"
          },
          {
            "enum": ["ST"],
            "type": "string",
            "title": "Sao Tome and Principe"
          },
          {
            "enum": [""],
            "type": "string",
            "title": "Sark"
          },
          {
            "enum": ["SA"],
            "type": "string",
            "title": "Saudi Arabia"
          },
          {
            "enum": ["SN"],
            "type": "string",
            "title": "Senegal"
          },
          {
            "enum": ["RS"],
            "type": "string",
            "title": "Serbia"
          },
          {
            "enum": ["SC"],
            "type": "string",
            "title": "Seychelles"
          },
          {
            "enum": ["SL"],
            "type": "string",
            "title": "Sierra Leone"
          },
          {
            "enum": ["SG"],
            "type": "string",
            "title": "Singapore"
          },
          {
            "enum": ["SX"],
            "type": "string",
            "title": "Sint Maarten (Dutch part)"
          },
          {
            "enum": ["SK"],
            "type": "string",
            "title": "Slovakia"
          },
          {
            "enum": ["SI"],
            "type": "string",
            "title": "Slovenia"
          },
          {
            "enum": ["SB"],
            "type": "string",
            "title": "Solomon Islands"
          },
          {
            "enum": ["SO"],
            "type": "string",
            "title": "Somalia"
          },
          {
            "enum": ["ZA"],
            "type": "string",
            "title": "South Africa"
          },
          {
            "enum": ["GS"],
            "type": "string",
            "title": "South Georgia and the South Sandwich Islands"
          },
          {
            "enum": ["SS"],
            "type": "string",
            "title": "South Sudan"
          },
          {
            "enum": ["ES"],
            "type": "string",
            "title": "Spain"
          },
          {
            "enum": ["LK"],
            "type": "string",
            "title": "Sri Lanka"
          },
          {
            "enum": ["PS"],
            "type": "string",
            "title": "State of Palestine"
          },
          {
            "enum": ["SD"],
            "type": "string",
            "title": "Sudan"
          },
          {
            "enum": ["SR"],
            "type": "string",
            "title": "Suriname"
          },
          {
            "enum": ["SJ"],
            "type": "string",
            "title": "Svalbard and Jan Mayen Islands"
          },
          {
            "enum": ["SE"],
            "type": "string",
            "title": "Sweden"
          },
          {
            "enum": ["CH"],
            "type": "string",
            "title": "Switzerland"
          },
          {
            "enum": ["SY"],
            "type": "string",
            "title": "Syrian Arab Republic"
          },
          {
            "enum": ["TJ"],
            "type": "string",
            "title": "Tajikistan"
          },
          {
            "enum": ["TH"],
            "type": "string",
            "title": "Thailand"
          },
          {
            "enum": ["MK"],
            "type": "string",
            "title": "The former Yugoslav Republic of Macedonia"
          },
          {
            "enum": ["TL"],
            "type": "string",
            "title": "Timor-Leste"
          },
          {
            "enum": ["TG"],
            "type": "string",
            "title": "Togo"
          },
          {
            "enum": ["TK"],
            "type": "string",
            "title": "Tokelau"
          },
          {
            "enum": ["TO"],
            "type": "string",
            "title": "Tonga"
          },
          {
            "enum": ["TT"],
            "type": "string",
            "title": "Trinidad and Tobago"
          },
          {
            "enum": ["TN"],
            "type": "string",
            "title": "Tunisia"
          },
          {
            "enum": ["TR"],
            "type": "string",
            "title": "Turkey"
          },
          {
            "enum": ["TM"],
            "type": "string",
            "title": "Turkmenistan"
          },
          {
            "enum": ["TC"],
            "type": "string",
            "title": "Turks and Caicos Islands"
          },
          {
            "enum": ["TV"],
            "type": "string",
            "title": "Tuvalu"
          },
          {
            "enum": ["UG"],
            "type": "string",
            "title": "Uganda"
          },
          {
            "enum": ["UA"],
            "type": "string",
            "title": "Ukraine"
          },
          {
            "enum": ["AE"],
            "type": "string",
            "title": "United Arab Emirates"
          },
          {
            "enum": ["GB"],
            "type": "string",
            "title": "United Kingdom of Great Britain and Northern Ireland"
          },
          {
            "enum": ["TZ"],
            "type": "string",
            "title": "United Republic of Tanzania"
          },
          {
            "enum": ["UM"],
            "type": "string",
            "title": "United States Minor Outlying Islands"
          },
          {
            "enum": ["VI"],
            "type": "string",
            "title": "United States Virgin Islands"
          },
          {
            "enum": ["US"],
            "type": "string",
            "title": "United States of America"
          },
          {
            "enum": ["UY"],
            "type": "string",
            "title": "Uruguay"
          },
          {
            "enum": ["UZ"],
            "type": "string",
            "title": "Uzbekistan"
          },
          {
            "enum": ["VU"],
            "type": "string",
            "title": "Vanuatu"
          },
          {
            "enum": ["VE"],
            "type": "string",
            "title": "Venezuela (Bolivarian Republic of)"
          },
          {
            "enum": ["VN"],
            "type": "string",
            "title": "Viet Nam"
          },
          {
            "enum": ["WF"],
            "type": "string",
            "title": "Wallis and Futuna Islands"
          },
          {
            "enum": ["EH"],
            "type": "string",
            "title": "Western Sahara"
          },
          {
            "enum": ["YE"],
            "type": "string",
            "title": "Yemen"
          },
          {
            "enum": ["ZM"],
            "type": "string",
            "title": "Zambia"
          },
          {
            "enum": ["ZW"],
            "type": "string",
            "title": "Zimbabwe"
          },
          {
            "enum": ["AX"],
            "type": "string",
            "title": "Åland Islands"
          },
          {
            "enum": [""],
            "type": "string",
            "title": ""
          }
        ],
        "title": "País de residencia"
      },
      "postal_code": {
        "type": "string",
        "title": "Código postal",
        "maxLength": 32
      }
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
                  },
                  {
                    "enum": ["14"],
                    "type": "string",
                    "title": "Chaco"
                  },
                  {
                    "enum": ["20"],
                    "type": "string",
                    "title": "Chubut"
                  },
                  {
                    "enum": ["43"],
                    "type": "string",
                    "title": "Ciudad Autónoma de Buenos Aires"
                  },
                  {
                    "enum": ["3"],
                    "type": "string",
                    "title": "Córdoba"
                  },
                  {
                    "enum": ["15"],
                    "type": "string",
                    "title": "Corrientes"
                  },
                  {
                    "enum": ["5"],
                    "type": "string",
                    "title": "Entre Ríos"
                  },
                  {
                    "enum": ["13"],
                    "type": "string",
                    "title": "Formosa"
                  },
                  {
                    "enum": ["11"],
                    "type": "string",
                    "title": "Jujuy"
                  },
                  {
                    "enum": ["18"],
                    "type": "string",
                    "title": "La Pampa"
                  },
                  {
                    "enum": ["9"],
                    "type": "string",
                    "title": "La Rioja"
                  },
                  {
                    "enum": ["4"],
                    "type": "string",
                    "title": "Mendoza"
                  },
                  {
                    "enum": ["16"],
                    "type": "string",
                    "title": "Misiones"
                  },
                  {
                    "enum": ["19"],
                    "type": "string",
                    "title": "Neuquén"
                  },
                  {
                    "enum": ["21"],
                    "type": "string",
                    "title": "Río Negro"
                  },
                  {
                    "enum": ["12"],
                    "type": "string",
                    "title": "Salta"
                  },
                  {
                    "enum": ["7"],
                    "type": "string",
                    "title": "San Juan"
                  },
                  {
                    "enum": ["8"],
                    "type": "string",
                    "title": "San Luis"
                  },
                  {
                    "enum": ["22"],
                    "type": "string",
                    "title": "Santa Cruz"
                  },
                  {
                    "enum": ["2"],
                    "type": "string",
                    "title": "Santa Fe"
                  },
                  {
                    "enum": ["6"],
                    "type": "string",
                    "title": "Santiago del Estero"
                  },
                  {
                    "enum": ["23"],
                    "type": "string",
                    "title":
                        "Tierra del Fuego, Antártida e Islas del Atlántico Sur"
                  },
                  {
                    "enum": ["17"],
                    "type": "string",
                    "title": "Tucumán"
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
              "state": {
                "type": "string",
                "oneOf": [
                  {
                    "enum": ["RO"],
                    "type": "string",
                    "title": "Rondônia"
                  },
                  {
                    "enum": ["AC"],
                    "type": "string",
                    "title": "Acre"
                  },
                  {
                    "enum": ["AM"],
                    "type": "string",
                    "title": "Amazonas"
                  },
                  {
                    "enum": ["RR"],
                    "type": "string",
                    "title": "Roraima"
                  },
                  {
                    "enum": ["PA"],
                    "type": "string",
                    "title": "Pará"
                  },
                  {
                    "enum": ["AP"],
                    "type": "string",
                    "title": "Amapá"
                  },
                  {
                    "enum": ["TO"],
                    "type": "string",
                    "title": "Tocantins"
                  },
                  {
                    "enum": ["MA"],
                    "type": "string",
                    "title": "Maranhão"
                  },
                  {
                    "enum": ["PI"],
                    "type": "string",
                    "title": "Piauí"
                  },
                  {
                    "enum": ["CE"],
                    "type": "string",
                    "title": "Ceará"
                  },
                  {
                    "enum": ["RN"],
                    "type": "string",
                    "title": "Rio Grande do Norte"
                  },
                  {
                    "enum": ["PB"],
                    "type": "string",
                    "title": "Paraíba"
                  },
                  {
                    "enum": ["PE"],
                    "type": "string",
                    "title": "Pernambuco"
                  },
                  {
                    "enum": ["AL"],
                    "type": "string",
                    "title": "Alagoas"
                  },
                  {
                    "enum": ["SE"],
                    "type": "string",
                    "title": "Sergipe"
                  },
                  {
                    "enum": ["BA"],
                    "type": "string",
                    "title": "Bahia"
                  },
                  {
                    "enum": ["MG"],
                    "type": "string",
                    "title": "Minas Gerais"
                  },
                  {
                    "enum": ["ES"],
                    "type": "string",
                    "title": "Espírito Santo"
                  },
                  {
                    "enum": ["RJ"],
                    "type": "string",
                    "title": "Rio de Janeiro"
                  },
                  {
                    "enum": ["SP"],
                    "type": "string",
                    "title": "São Paulo"
                  },
                  {
                    "enum": ["PR"],
                    "type": "string",
                    "title": "Paraná"
                  },
                  {
                    "enum": ["SC"],
                    "type": "string",
                    "title": "Santa Catarina"
                  },
                  {
                    "enum": ["RS"],
                    "type": "string",
                    "title": "Rio Grande do Sul"
                  },
                  {
                    "enum": ["MS"],
                    "type": "string",
                    "title": "Mato Grosso do Sul"
                  },
                  {
                    "enum": ["MT"],
                    "type": "string",
                    "title": "Mato Grosso"
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
              "country": {
                "enum": ["BR"]
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
                    "enum": ["putre"],
                    "type": "string",
                    "title": "Putre"
                  },
                  {
                    "enum": ["alto hospicio"],
                    "type": "string",
                    "title": "Alto Hospicio"
                  },
                  {
                    "enum": ["camiña"],
                    "type": "string",
                    "title": "Camiña"
                  },
                  {
                    "enum": ["colchane"],
                    "type": "string",
                    "title": "Colchane"
                  },
                  {
                    "enum": ["huara"],
                    "type": "string",
                    "title": "Huara"
                  },
                  {
                    "enum": ["iquique"],
                    "type": "string",
                    "title": "Iquique"
                  },
                  {
                    "enum": ["pica"],
                    "type": "string",
                    "title": "Pica"
                  },
                  {
                    "enum": ["pozo almonte"],
                    "type": "string",
                    "title": "Pozo Almonte"
                  },
                  {
                    "enum": ["antofagasta"],
                    "type": "string",
                    "title": "Antofagasta"
                  },
                  {
                    "enum": ["calama"],
                    "type": "string",
                    "title": "Calama"
                  },
                  {
                    "enum": ["maría elena"],
                    "type": "string",
                    "title": "María Elena"
                  },
                  {
                    "enum": ["mejillones"],
                    "type": "string",
                    "title": "Mejillones"
                  },
                  {
                    "enum": ["ollagüe"],
                    "type": "string",
                    "title": "Ollagüe"
                  },
                  {
                    "enum": ["san pedro de atacama"],
                    "type": "string",
                    "title": "San Pedro de Atacama"
                  },
                  {
                    "enum": ["sierra gorda"],
                    "type": "string",
                    "title": "Sierra Gorda"
                  },
                  {
                    "enum": ["taltal"],
                    "type": "string",
                    "title": "Taltal"
                  },
                  {
                    "enum": ["tocopilla"],
                    "type": "string",
                    "title": "Tocopilla"
                  },
                  {
                    "enum": ["alto del carmen"],
                    "type": "string",
                    "title": "Alto del Carmen"
                  },
                  {
                    "enum": ["caldera"],
                    "type": "string",
                    "title": "Caldera"
                  },
                  {
                    "enum": ["chañaral"],
                    "type": "string",
                    "title": "Chañaral"
                  },
                  {
                    "enum": ["copiapó"],
                    "type": "string",
                    "title": "Copiapó"
                  },
                  {
                    "enum": ["diego de almagro"],
                    "type": "string",
                    "title": "Diego de Almagro"
                  },
                  {
                    "enum": ["freirina"],
                    "type": "string",
                    "title": "Freirina"
                  },
                  {
                    "enum": ["huasco"],
                    "type": "string",
                    "title": "Huasco"
                  },
                  {
                    "enum": ["tierra amarilla"],
                    "type": "string",
                    "title": "Tierra Amarilla"
                  },
                  {
                    "enum": ["vallenar"],
                    "type": "string",
                    "title": "Vallenar"
                  },
                  {
                    "enum": ["andacollo"],
                    "type": "string",
                    "title": "Andacollo"
                  },
                  {
                    "enum": ["canela"],
                    "type": "string",
                    "title": "Canela"
                  },
                  {
                    "enum": ["combarbalá"],
                    "type": "string",
                    "title": "Combarbalá"
                  },
                  {
                    "enum": ["coquimbo"],
                    "type": "string",
                    "title": "Coquimbo"
                  },
                  {
                    "enum": ["illapel"],
                    "type": "string",
                    "title": "Illapel"
                  },
                  {
                    "enum": ["la higuera"],
                    "type": "string",
                    "title": "La Higuera"
                  },
                  {
                    "enum": ["la serena"],
                    "type": "string",
                    "title": "La Serena"
                  },
                  {
                    "enum": ["los vilos"],
                    "type": "string",
                    "title": "Los Vilos"
                  },
                  {
                    "enum": ["monte patria"],
                    "type": "string",
                    "title": "Monte Patria"
                  },
                  {
                    "enum": ["ovalle"],
                    "type": "string",
                    "title": "Ovalle"
                  },
                  {
                    "enum": ["paiguano"],
                    "type": "string",
                    "title": "Paiguano"
                  },
                  {
                    "enum": ["punitaqui"],
                    "type": "string",
                    "title": "Punitaqui"
                  },
                  {
                    "enum": ["río hurtado"],
                    "type": "string",
                    "title": "Río Hurtado"
                  },
                  {
                    "enum": ["salamanca"],
                    "type": "string",
                    "title": "Salamanca"
                  },
                  {
                    "enum": ["vicuña"],
                    "type": "string",
                    "title": "Vicuña"
                  },
                  {
                    "enum": ["algarrobo"],
                    "type": "string",
                    "title": "Algarrobo"
                  },
                  {
                    "enum": ["cabildo"],
                    "type": "string",
                    "title": "Cabildo"
                  },
                  {
                    "enum": ["calera"],
                    "type": "string",
                    "title": "Calera"
                  },
                  {
                    "enum": ["calle larga"],
                    "type": "string",
                    "title": "Calle Larga"
                  },
                  {
                    "enum": ["cartagena"],
                    "type": "string",
                    "title": "Cartagena"
                  },
                  {
                    "enum": ["casablanca"],
                    "type": "string",
                    "title": "Casablanca"
                  },
                  {
                    "enum": ["catemu"],
                    "type": "string",
                    "title": "Catemu"
                  },
                  {
                    "enum": ["concón"],
                    "type": "string",
                    "title": "Concón"
                  },
                  {
                    "enum": ["el quisco"],
                    "type": "string",
                    "title": "El Quisco"
                  },
                  {
                    "enum": ["el tabo"],
                    "type": "string",
                    "title": "El Tabo"
                  },
                  {
                    "enum": ["hijuelas"],
                    "type": "string",
                    "title": "Hijuelas"
                  },
                  {
                    "enum": ["isla de pascua"],
                    "type": "string",
                    "title": "Isla de Pascua"
                  },
                  {
                    "enum": ["juan fernández"],
                    "type": "string",
                    "title": "Juan Fernández"
                  },
                  {
                    "enum": ["la cruz"],
                    "type": "string",
                    "title": "La Cruz"
                  },
                  {
                    "enum": ["la ligua"],
                    "type": "string",
                    "title": "La Ligua"
                  },
                  {
                    "enum": ["limache"],
                    "type": "string",
                    "title": "Limache"
                  },
                  {
                    "enum": ["llaillay"],
                    "type": "string",
                    "title": "Llaillay"
                  },
                  {
                    "enum": ["los andes"],
                    "type": "string",
                    "title": "Los Andes"
                  },
                  {
                    "enum": ["nogales"],
                    "type": "string",
                    "title": "Nogales"
                  },
                  {
                    "enum": ["olmué"],
                    "type": "string",
                    "title": "Olmué"
                  },
                  {
                    "enum": ["panquehue"],
                    "type": "string",
                    "title": "Panquehue"
                  },
                  {
                    "enum": ["papudo"],
                    "type": "string",
                    "title": "Papudo"
                  },
                  {
                    "enum": ["petorca"],
                    "type": "string",
                    "title": "Petorca"
                  },
                  {
                    "enum": ["puchuncaví"],
                    "type": "string",
                    "title": "Puchuncaví"
                  },
                  {
                    "enum": ["putaendo"],
                    "type": "string",
                    "title": "Putaendo"
                  },
                  {
                    "enum": ["quillota"],
                    "type": "string",
                    "title": "Quillota"
                  },
                  {
                    "enum": ["quilpué"],
                    "type": "string",
                    "title": "Quilpué"
                  },
                  {
                    "enum": ["quintero"],
                    "type": "string",
                    "title": "Quintero"
                  },
                  {
                    "enum": ["rinconada"],
                    "type": "string",
                    "title": "Rinconada"
                  },
                  {
                    "enum": ["san antonio"],
                    "type": "string",
                    "title": "San Antonio"
                  },
                  {
                    "enum": ["san esteban"],
                    "type": "string",
                    "title": "San Esteban"
                  },
                  {
                    "enum": ["san felipe"],
                    "type": "string",
                    "title": "San Felipe"
                  },
                  {
                    "enum": ["santa maría"],
                    "type": "string",
                    "title": "Santa María"
                  },
                  {
                    "enum": ["santo domingo"],
                    "type": "string",
                    "title": "Santo Domingo"
                  },
                  {
                    "enum": ["valparaíso"],
                    "type": "string",
                    "title": "Valparaíso"
                  },
                  {
                    "enum": ["villa alemana"],
                    "type": "string",
                    "title": "Villa Alemana"
                  },
                  {
                    "enum": ["viña del mar"],
                    "type": "string",
                    "title": "Viña del Mar"
                  },
                  {
                    "enum": ["zapallar"],
                    "type": "string",
                    "title": "Zapallar"
                  },
                  {
                    "enum": ["alhué"],
                    "type": "string",
                    "title": "Alhué"
                  },
                  {
                    "enum": ["buin"],
                    "type": "string",
                    "title": "Buin"
                  },
                  {
                    "enum": ["calera de tango"],
                    "type": "string",
                    "title": "Calera de Tango"
                  },
                  {
                    "enum": ["cerrillos"],
                    "type": "string",
                    "title": "Cerrillos"
                  },
                  {
                    "enum": ["cerro navia"],
                    "type": "string",
                    "title": "Cerro Navia"
                  },
                  {
                    "enum": ["colina"],
                    "type": "string",
                    "title": "Colina"
                  },
                  {
                    "enum": ["conchalí"],
                    "type": "string",
                    "title": "Conchalí"
                  },
                  {
                    "enum": ["curacaví"],
                    "type": "string",
                    "title": "Curacaví"
                  },
                  {
                    "enum": ["el bosque"],
                    "type": "string",
                    "title": "El Bosque"
                  },
                  {
                    "enum": ["el monte"],
                    "type": "string",
                    "title": "El Monte"
                  },
                  {
                    "enum": ["estación central"],
                    "type": "string",
                    "title": "Estación Central"
                  },
                  {
                    "enum": ["huechuraba"],
                    "type": "string",
                    "title": "Huechuraba"
                  },
                  {
                    "enum": ["independencia"],
                    "type": "string",
                    "title": "Independencia"
                  },
                  {
                    "enum": ["isla de maipo"],
                    "type": "string",
                    "title": "Isla de Maipo"
                  },
                  {
                    "enum": ["la cisterna"],
                    "type": "string",
                    "title": "La Cisterna"
                  },
                  {
                    "enum": ["la florida"],
                    "type": "string",
                    "title": "La Florida"
                  },
                  {
                    "enum": ["la granja"],
                    "type": "string",
                    "title": "La Granja"
                  },
                  {
                    "enum": ["la pintana"],
                    "type": "string",
                    "title": "La Pintana"
                  },
                  {
                    "enum": ["la reina"],
                    "type": "string",
                    "title": "La Reina"
                  },
                  {
                    "enum": ["lampa"],
                    "type": "string",
                    "title": "Lampa"
                  },
                  {
                    "enum": ["las condes"],
                    "type": "string",
                    "title": "Las Condes"
                  },
                  {
                    "enum": ["lo barnechea"],
                    "type": "string",
                    "title": "Lo Barnechea"
                  },
                  {
                    "enum": ["lo espejo"],
                    "type": "string",
                    "title": "Lo Espejo"
                  },
                  {
                    "enum": ["lo prado"],
                    "type": "string",
                    "title": "Lo Prado"
                  },
                  {
                    "enum": ["macul"],
                    "type": "string",
                    "title": "Macul"
                  },
                  {
                    "enum": ["maipú"],
                    "type": "string",
                    "title": "Maipú"
                  },
                  {
                    "enum": ["maría pinto"],
                    "type": "string",
                    "title": "María Pinto"
                  },
                  {
                    "enum": ["melipilla"],
                    "type": "string",
                    "title": "Melipilla"
                  },
                  {
                    "enum": ["ñuñoa"],
                    "type": "string",
                    "title": "Ñuñoa"
                  },
                  {
                    "enum": ["padre hurtado"],
                    "type": "string",
                    "title": "Padre Hurtado"
                  },
                  {
                    "enum": ["paine"],
                    "type": "string",
                    "title": "Paine"
                  },
                  {
                    "enum": ["pedro aguirre cerda"],
                    "type": "string",
                    "title": "Pedro Aguirre Cerda"
                  },
                  {
                    "enum": ["peñaflor"],
                    "type": "string",
                    "title": "Peñaflor"
                  },
                  {
                    "enum": ["peñalolén"],
                    "type": "string",
                    "title": "Peñalolén"
                  },
                  {
                    "enum": ["pirque"],
                    "type": "string",
                    "title": "Pirque"
                  },
                  {
                    "enum": ["providencia"],
                    "type": "string",
                    "title": "Providencia"
                  },
                  {
                    "enum": ["pudahuel"],
                    "type": "string",
                    "title": "Pudahuel"
                  },
                  {
                    "enum": ["puente alto"],
                    "type": "string",
                    "title": "Puente Alto"
                  },
                  {
                    "enum": ["quilicura"],
                    "type": "string",
                    "title": "Quilicura"
                  },
                  {
                    "enum": ["quinta normal"],
                    "type": "string",
                    "title": "Quinta Normal"
                  },
                  {
                    "enum": ["recoleta"],
                    "type": "string",
                    "title": "Recoleta"
                  },
                  {
                    "enum": ["renca"],
                    "type": "string",
                    "title": "Renca"
                  },
                  {
                    "enum": ["san bernardo"],
                    "type": "string",
                    "title": "San Bernardo"
                  },
                  {
                    "enum": ["san joaquín"],
                    "type": "string",
                    "title": "San Joaquín"
                  },
                  {
                    "enum": ["san josé de maipo"],
                    "type": "string",
                    "title": "San José de Maipo"
                  },
                  {
                    "enum": ["san miguel"],
                    "type": "string",
                    "title": "San Miguel"
                  },
                  {
                    "enum": ["san pedro"],
                    "type": "string",
                    "title": "San Pedro"
                  },
                  {
                    "enum": ["san ramón"],
                    "type": "string",
                    "title": "San Ramón"
                  },
                  {
                    "enum": ["santiago"],
                    "type": "string",
                    "title": "Santiago"
                  },
                  {
                    "enum": ["talagante"],
                    "type": "string",
                    "title": "Talagante"
                  },
                  {
                    "enum": ["tiltil"],
                    "type": "string",
                    "title": "Tiltil"
                  },
                  {
                    "enum": ["vitacura"],
                    "type": "string",
                    "title": "Vitacura"
                  },
                  {
                    "enum": ["chimbarongo"],
                    "type": "string",
                    "title": "Chimbarongo"
                  },
                  {
                    "enum": ["chépica"],
                    "type": "string",
                    "title": "Chépica"
                  },
                  {
                    "enum": ["codegua"],
                    "type": "string",
                    "title": "Codegua"
                  },
                  {
                    "enum": ["coinco"],
                    "type": "string",
                    "title": "Coinco"
                  },
                  {
                    "enum": ["coltauco"],
                    "type": "string",
                    "title": "Coltauco"
                  },
                  {
                    "enum": ["doñihue"],
                    "type": "string",
                    "title": "Doñihue"
                  },
                  {
                    "enum": ["graneros"],
                    "type": "string",
                    "title": "Graneros"
                  },
                  {
                    "enum": ["la estrella"],
                    "type": "string",
                    "title": "La Estrella"
                  },
                  {
                    "enum": ["las cabras"],
                    "type": "string",
                    "title": "Las Cabras"
                  },
                  {
                    "enum": ["litueche"],
                    "type": "string",
                    "title": "Litueche"
                  },
                  {
                    "enum": ["lolol"],
                    "type": "string",
                    "title": "Lolol"
                  },
                  {
                    "enum": ["machalí"],
                    "type": "string",
                    "title": "Machalí"
                  },
                  {
                    "enum": ["malloa"],
                    "type": "string",
                    "title": "Malloa"
                  },
                  {
                    "enum": ["marchihue"],
                    "type": "string",
                    "title": "Marchihue"
                  },
                  {
                    "enum": ["nancagua"],
                    "type": "string",
                    "title": "Nancagua"
                  },
                  {
                    "enum": ["navidad"],
                    "type": "string",
                    "title": "Navidad"
                  },
                  {
                    "enum": ["olivar"],
                    "type": "string",
                    "title": "Olivar"
                  },
                  {
                    "enum": ["palmilla"],
                    "type": "string",
                    "title": "Palmilla"
                  },
                  {
                    "enum": ["paredones"],
                    "type": "string",
                    "title": "Paredones"
                  },
                  {
                    "enum": ["peralillo"],
                    "type": "string",
                    "title": "Peralillo"
                  },
                  {
                    "enum": ["peumo"],
                    "type": "string",
                    "title": "Peumo"
                  },
                  {
                    "enum": ["pichidegua"],
                    "type": "string",
                    "title": "Pichidegua"
                  },
                  {
                    "enum": ["pichilemu"],
                    "type": "string",
                    "title": "Pichilemu"
                  },
                  {
                    "enum": ["placilla"],
                    "type": "string",
                    "title": "Placilla"
                  },
                  {
                    "enum": ["pumanque"],
                    "type": "string",
                    "title": "Pumanque"
                  },
                  {
                    "enum": ["quinta de tilcoco"],
                    "type": "string",
                    "title": "Quinta de Tilcoco"
                  },
                  {
                    "enum": ["rancagua"],
                    "type": "string",
                    "title": "Rancagua"
                  },
                  {
                    "enum": ["rengo"],
                    "type": "string",
                    "title": "Rengo"
                  },
                  {
                    "enum": ["requínoa"],
                    "type": "string",
                    "title": "Requínoa"
                  },
                  {
                    "enum": ["san fernando"],
                    "type": "string",
                    "title": "San Fernando"
                  },
                  {
                    "enum": ["san francisco de mostazal"],
                    "type": "string",
                    "title": "San Francisco de Mostazal"
                  },
                  {
                    "enum": ["san vicente de tagua tagua"],
                    "type": "string",
                    "title": "San Vicente de Tagua Tagua"
                  },
                  {
                    "enum": ["santa cruz"],
                    "type": "string",
                    "title": "Santa Cruz"
                  },
                  {
                    "enum": ["cauquenes"],
                    "type": "string",
                    "title": "Cauquenes"
                  },
                  {
                    "enum": ["chanco"],
                    "type": "string",
                    "title": "Chanco"
                  },
                  {
                    "enum": ["colbún"],
                    "type": "string",
                    "title": "Colbún"
                  },
                  {
                    "enum": ["constitución"],
                    "type": "string",
                    "title": "Constitución"
                  },
                  {
                    "enum": ["curepto"],
                    "type": "string",
                    "title": "Curepto"
                  },
                  {
                    "enum": ["curicó"],
                    "type": "string",
                    "title": "Curicó"
                  },
                  {
                    "enum": ["empedrado"],
                    "type": "string",
                    "title": "Empedrado"
                  },
                  {
                    "enum": ["hualañé"],
                    "type": "string",
                    "title": "Hualañé"
                  },
                  {
                    "enum": ["licantén"],
                    "type": "string",
                    "title": "Licantén"
                  },
                  {
                    "enum": ["linares"],
                    "type": "string",
                    "title": "Linares"
                  },
                  {
                    "enum": ["longaví"],
                    "type": "string",
                    "title": "Longaví"
                  },
                  {
                    "enum": ["maule"],
                    "type": "string",
                    "title": "Maule"
                  },
                  {
                    "enum": ["molina"],
                    "type": "string",
                    "title": "Molina"
                  },
                  {
                    "enum": ["parral"],
                    "type": "string",
                    "title": "Parral"
                  },
                  {
                    "enum": ["pelarco"],
                    "type": "string",
                    "title": "Pelarco"
                  },
                  {
                    "enum": ["pelluhue"],
                    "type": "string",
                    "title": "Pelluhue"
                  },
                  {
                    "enum": ["pencahue"],
                    "type": "string",
                    "title": "Pencahue"
                  },
                  {
                    "enum": ["rauco"],
                    "type": "string",
                    "title": "Rauco"
                  },
                  {
                    "enum": ["retiro"],
                    "type": "string",
                    "title": "Retiro"
                  },
                  {
                    "enum": ["romeral"],
                    "type": "string",
                    "title": "Romeral"
                  },
                  {
                    "enum": ["río claro"],
                    "type": "string",
                    "title": "Río Claro"
                  },
                  {
                    "enum": ["sagrada familia"],
                    "type": "string",
                    "title": "Sagrada Familia"
                  },
                  {
                    "enum": ["san clemente"],
                    "type": "string",
                    "title": "San Clemente"
                  },
                  {
                    "enum": ["san javier de loncomilla"],
                    "type": "string",
                    "title": "San Javier de Loncomilla"
                  },
                  {
                    "enum": ["san rafael"],
                    "type": "string",
                    "title": "San Rafael"
                  },
                  {
                    "enum": ["talca"],
                    "type": "string",
                    "title": "Talca"
                  },
                  {
                    "enum": ["teno"],
                    "type": "string",
                    "title": "Teno"
                  },
                  {
                    "enum": ["vichuquén"],
                    "type": "string",
                    "title": "Vichuquén"
                  },
                  {
                    "enum": ["villa alegre"],
                    "type": "string",
                    "title": "Villa Alegre"
                  },
                  {
                    "enum": ["yerbas buenas"],
                    "type": "string",
                    "title": "Yerbas Buenas"
                  },
                  {
                    "enum": ["bulnes"],
                    "type": "string",
                    "title": "Bulnes"
                  },
                  {
                    "enum": ["chillán viejo"],
                    "type": "string",
                    "title": "Chillán Viejo"
                  },
                  {
                    "enum": ["chillán"],
                    "type": "string",
                    "title": "Chillán"
                  },
                  {
                    "enum": ["cobquecura"],
                    "type": "string",
                    "title": "Cobquecura"
                  },
                  {
                    "enum": ["coelemu"],
                    "type": "string",
                    "title": "Coelemu"
                  },
                  {
                    "enum": ["coihueco"],
                    "type": "string",
                    "title": "Coihueco"
                  },
                  {
                    "enum": ["el carmen"],
                    "type": "string",
                    "title": "El Carmen"
                  },
                  {
                    "enum": ["ninhue"],
                    "type": "string",
                    "title": "Ninhue"
                  },
                  {
                    "enum": ["ñiquén"],
                    "type": "string",
                    "title": "Ñiquén"
                  },
                  {
                    "enum": ["pemuco"],
                    "type": "string",
                    "title": "Pemuco"
                  },
                  {
                    "enum": ["pinto"],
                    "type": "string",
                    "title": "Pinto"
                  },
                  {
                    "enum": ["portezuelo"],
                    "type": "string",
                    "title": "Portezuelo"
                  },
                  {
                    "enum": ["quillón"],
                    "type": "string",
                    "title": "Quillón"
                  },
                  {
                    "enum": ["quirihue"],
                    "type": "string",
                    "title": "Quirihue"
                  },
                  {
                    "enum": ["ránquil"],
                    "type": "string",
                    "title": "Ránquil"
                  },
                  {
                    "enum": ["san carlos"],
                    "type": "string",
                    "title": "San Carlos"
                  },
                  {
                    "enum": ["san fabián"],
                    "type": "string",
                    "title": "San Fabián"
                  },
                  {
                    "enum": ["san ignacio"],
                    "type": "string",
                    "title": "San Ignacio"
                  },
                  {
                    "enum": ["san nicolás"],
                    "type": "string",
                    "title": "San Nicolás"
                  },
                  {
                    "enum": ["treguaco"],
                    "type": "string",
                    "title": "Treguaco"
                  },
                  {
                    "enum": ["yungay"],
                    "type": "string",
                    "title": "Yungay"
                  },
                  {
                    "enum": ["alto biobío"],
                    "type": "string",
                    "title": "Alto Biobío"
                  },
                  {
                    "enum": ["antuco"],
                    "type": "string",
                    "title": "Antuco"
                  },
                  {
                    "enum": ["arauco"],
                    "type": "string",
                    "title": "Arauco"
                  },
                  {
                    "enum": ["cabrero"],
                    "type": "string",
                    "title": "Cabrero"
                  },
                  {
                    "enum": ["cañete"],
                    "type": "string",
                    "title": "Cañete"
                  },
                  {
                    "enum": ["chiguayante"],
                    "type": "string",
                    "title": "Chiguayante"
                  },
                  {
                    "enum": ["concepción"],
                    "type": "string",
                    "title": "Concepción"
                  },
                  {
                    "enum": ["contulmo"],
                    "type": "string",
                    "title": "Contulmo"
                  },
                  {
                    "enum": ["coronel"],
                    "type": "string",
                    "title": "Coronel"
                  },
                  {
                    "enum": ["curanilahue"],
                    "type": "string",
                    "title": "Curanilahue"
                  },
                  {
                    "enum": ["florida"],
                    "type": "string",
                    "title": "Florida"
                  },
                  {
                    "enum": ["hualpén"],
                    "type": "string",
                    "title": "Hualpén"
                  },
                  {
                    "enum": ["hualqui"],
                    "type": "string",
                    "title": "Hualqui"
                  },
                  {
                    "enum": ["laja"],
                    "type": "string",
                    "title": "Laja"
                  },
                  {
                    "enum": ["lebu"],
                    "type": "string",
                    "title": "Lebu"
                  },
                  {
                    "enum": ["los álamos"],
                    "type": "string",
                    "title": "Los Álamos"
                  },
                  {
                    "enum": ["los ángeles"],
                    "type": "string",
                    "title": "Los Ángeles"
                  },
                  {
                    "enum": ["lota"],
                    "type": "string",
                    "title": "Lota"
                  },
                  {
                    "enum": ["mulchén"],
                    "type": "string",
                    "title": "Mulchén"
                  },
                  {
                    "enum": ["nacimiento"],
                    "type": "string",
                    "title": "Nacimiento"
                  },
                  {
                    "enum": ["negrete"],
                    "type": "string",
                    "title": "Negrete"
                  },
                  {
                    "enum": ["penco"],
                    "type": "string",
                    "title": "Penco"
                  },
                  {
                    "enum": ["quilaco"],
                    "type": "string",
                    "title": "Quilaco"
                  },
                  {
                    "enum": ["quilleco"],
                    "type": "string",
                    "title": "Quilleco"
                  },
                  {
                    "enum": ["san pedro de la paz"],
                    "type": "string",
                    "title": "San Pedro de la Paz"
                  },
                  {
                    "enum": ["san rosendo"],
                    "type": "string",
                    "title": "San Rosendo"
                  },
                  {
                    "enum": ["santa bárbara"],
                    "type": "string",
                    "title": "Santa Bárbara"
                  },
                  {
                    "enum": ["santa juana"],
                    "type": "string",
                    "title": "Santa Juana"
                  },
                  {
                    "enum": ["talcahuano"],
                    "type": "string",
                    "title": "Talcahuano"
                  },
                  {
                    "enum": ["tirúa"],
                    "type": "string",
                    "title": "Tirúa"
                  },
                  {
                    "enum": ["tomé"],
                    "type": "string",
                    "title": "Tomé"
                  },
                  {
                    "enum": ["tucapel"],
                    "type": "string",
                    "title": "Tucapel"
                  },
                  {
                    "enum": ["yumbel"],
                    "type": "string",
                    "title": "Yumbel"
                  },
                  {
                    "enum": ["angol"],
                    "type": "string",
                    "title": "Angol"
                  },
                  {
                    "enum": ["carahue"],
                    "type": "string",
                    "title": "Carahue"
                  },
                  {
                    "enum": ["cholchol"],
                    "type": "string",
                    "title": "Cholchol"
                  },
                  {
                    "enum": ["collipulli"],
                    "type": "string",
                    "title": "Collipulli"
                  },
                  {
                    "enum": ["cunco"],
                    "type": "string",
                    "title": "Cunco"
                  },
                  {
                    "enum": ["curacautín"],
                    "type": "string",
                    "title": "Curacautín"
                  },
                  {
                    "enum": ["curarrehue"],
                    "type": "string",
                    "title": "Curarrehue"
                  },
                  {
                    "enum": ["ercilla"],
                    "type": "string",
                    "title": "Ercilla"
                  },
                  {
                    "enum": ["freire"],
                    "type": "string",
                    "title": "Freire"
                  },
                  {
                    "enum": ["galvarino"],
                    "type": "string",
                    "title": "Galvarino"
                  },
                  {
                    "enum": ["gorbea"],
                    "type": "string",
                    "title": "Gorbea"
                  },
                  {
                    "enum": ["lautaro"],
                    "type": "string",
                    "title": "Lautaro"
                  },
                  {
                    "enum": ["loncoche"],
                    "type": "string",
                    "title": "Loncoche"
                  },
                  {
                    "enum": ["lonquimay"],
                    "type": "string",
                    "title": "Lonquimay"
                  },
                  {
                    "enum": ["los sauces"],
                    "type": "string",
                    "title": "Los Sauces"
                  },
                  {
                    "enum": ["lumaco"],
                    "type": "string",
                    "title": "Lumaco"
                  },
                  {
                    "enum": ["melipeuco"],
                    "type": "string",
                    "title": "Melipeuco"
                  },
                  {
                    "enum": ["nueva imperial"],
                    "type": "string",
                    "title": "Nueva Imperial"
                  },
                  {
                    "enum": ["padre las casas"],
                    "type": "string",
                    "title": "Padre las Casas"
                  },
                  {
                    "enum": ["perquenco"],
                    "type": "string",
                    "title": "Perquenco"
                  },
                  {
                    "enum": ["pitrufquén"],
                    "type": "string",
                    "title": "Pitrufquén"
                  },
                  {
                    "enum": ["pucón"],
                    "type": "string",
                    "title": "Pucón"
                  },
                  {
                    "enum": ["purén"],
                    "type": "string",
                    "title": "Purén"
                  },
                  {
                    "enum": ["renaico"],
                    "type": "string",
                    "title": "Renaico"
                  },
                  {
                    "enum": ["saavedra"],
                    "type": "string",
                    "title": "Saavedra"
                  },
                  {
                    "enum": ["temuco"],
                    "type": "string",
                    "title": "Temuco"
                  },
                  {
                    "enum": ["teodoro schmidt"],
                    "type": "string",
                    "title": "Teodoro Schmidt"
                  },
                  {
                    "enum": ["toltén"],
                    "type": "string",
                    "title": "Toltén"
                  },
                  {
                    "enum": ["traiguén"],
                    "type": "string",
                    "title": "Traiguén"
                  },
                  {
                    "enum": ["victoria"],
                    "type": "string",
                    "title": "Victoria"
                  },
                  {
                    "enum": ["vilcún"],
                    "type": "string",
                    "title": "Vilcún"
                  },
                  {
                    "enum": ["villarrica"],
                    "type": "string",
                    "title": "Villarrica"
                  },
                  {
                    "enum": ["corral"],
                    "type": "string",
                    "title": "Corral"
                  },
                  {
                    "enum": ["futrono"],
                    "type": "string",
                    "title": "Futrono"
                  },
                  {
                    "enum": ["la unión"],
                    "type": "string",
                    "title": "La Unión"
                  },
                  {
                    "enum": ["lago ranco"],
                    "type": "string",
                    "title": "Lago Ranco"
                  },
                  {
                    "enum": ["lanco"],
                    "type": "string",
                    "title": "Lanco"
                  },
                  {
                    "enum": ["los lagos"],
                    "type": "string",
                    "title": "Los Lagos"
                  },
                  {
                    "enum": ["mariquina"],
                    "type": "string",
                    "title": "Mariquina"
                  },
                  {
                    "enum": ["máfil"],
                    "type": "string",
                    "title": "Máfil"
                  },
                  {
                    "enum": ["paillaco"],
                    "type": "string",
                    "title": "Paillaco"
                  },
                  {
                    "enum": ["panguipulli"],
                    "type": "string",
                    "title": "Panguipulli"
                  },
                  {
                    "enum": ["río bueno"],
                    "type": "string",
                    "title": "Río Bueno"
                  },
                  {
                    "enum": ["valdivia"],
                    "type": "string",
                    "title": "Valdivia"
                  },
                  {
                    "enum": ["ancud"],
                    "type": "string",
                    "title": "Ancud"
                  },
                  {
                    "enum": ["calbuco"],
                    "type": "string",
                    "title": "Calbuco"
                  },
                  {
                    "enum": ["castro"],
                    "type": "string",
                    "title": "Castro"
                  },
                  {
                    "enum": ["chaitén"],
                    "type": "string",
                    "title": "Chaitén"
                  },
                  {
                    "enum": ["chonchi"],
                    "type": "string",
                    "title": "Chonchi"
                  },
                  {
                    "enum": ["cochamó"],
                    "type": "string",
                    "title": "Cochamó"
                  },
                  {
                    "enum": ["curaco de vélez"],
                    "type": "string",
                    "title": "Curaco de Vélez"
                  },
                  {
                    "enum": ["dalcahue"],
                    "type": "string",
                    "title": "Dalcahue"
                  },
                  {
                    "enum": ["fresia"],
                    "type": "string",
                    "title": "Fresia"
                  },
                  {
                    "enum": ["frutillar"],
                    "type": "string",
                    "title": "Frutillar"
                  },
                  {
                    "enum": ["futaleufú"],
                    "type": "string",
                    "title": "Futaleufú"
                  },
                  {
                    "enum": ["hualaihué"],
                    "type": "string",
                    "title": "Hualaihué"
                  },
                  {
                    "enum": ["llanquihue"],
                    "type": "string",
                    "title": "Llanquihue"
                  },
                  {
                    "enum": ["los muermos"],
                    "type": "string",
                    "title": "Los Muermos"
                  },
                  {
                    "enum": ["maullín"],
                    "type": "string",
                    "title": "Maullín"
                  },
                  {
                    "enum": ["osorno"],
                    "type": "string",
                    "title": "Osorno"
                  },
                  {
                    "enum": ["palena"],
                    "type": "string",
                    "title": "Palena"
                  },
                  {
                    "enum": ["puerto montt"],
                    "type": "string",
                    "title": "Puerto Montt"
                  },
                  {
                    "enum": ["puerto octay"],
                    "type": "string",
                    "title": "Puerto Octay"
                  },
                  {
                    "enum": ["puerto varas"],
                    "type": "string",
                    "title": "Puerto Varas"
                  },
                  {
                    "enum": ["puqueldón"],
                    "type": "string",
                    "title": "Puqueldón"
                  },
                  {
                    "enum": ["purranque"],
                    "type": "string",
                    "title": "Purranque"
                  },
                  {
                    "enum": ["puyehue"],
                    "type": "string",
                    "title": "Puyehue"
                  },
                  {
                    "enum": ["queilén"],
                    "type": "string",
                    "title": "Queilén"
                  },
                  {
                    "enum": ["quellón"],
                    "type": "string",
                    "title": "Quellón"
                  },
                  {
                    "enum": ["quemchi"],
                    "type": "string",
                    "title": "Quemchi"
                  },
                  {
                    "enum": ["quinchao"],
                    "type": "string",
                    "title": "Quinchao"
                  },
                  {
                    "enum": ["río negro"],
                    "type": "string",
                    "title": "Río Negro"
                  },
                  {
                    "enum": ["san juan de la costa"],
                    "type": "string",
                    "title": "San Juan de la Costa"
                  },
                  {
                    "enum": ["san pablo"],
                    "type": "string",
                    "title": "San Pablo"
                  },
                  {
                    "enum": ["aisén"],
                    "type": "string",
                    "title": "Aisén"
                  },
                  {
                    "enum": ["chile chico"],
                    "type": "string",
                    "title": "Chile Chico"
                  },
                  {
                    "enum": ["cisnes"],
                    "type": "string",
                    "title": "Cisnes"
                  },
                  {
                    "enum": ["cochrane"],
                    "type": "string",
                    "title": "Cochrane"
                  },
                  {
                    "enum": ["coihaique"],
                    "type": "string",
                    "title": "Coihaique"
                  },
                  {
                    "enum": ["guaitecas"],
                    "type": "string",
                    "title": "Guaitecas"
                  },
                  {
                    "enum": ["lago verde"],
                    "type": "string",
                    "title": "Lago Verde"
                  },
                  {
                    "enum": ["o’higgins"],
                    "type": "string",
                    "title": "O’Higgins"
                  },
                  {
                    "enum": ["río ibáñez"],
                    "type": "string",
                    "title": "Río Ibáñez"
                  },
                  {
                    "enum": ["tortel"],
                    "type": "string",
                    "title": "Tortel"
                  },
                  {
                    "enum": ["antártica"],
                    "type": "string",
                    "title": "Antártica"
                  },
                  {
                    "enum": ["cabo de hornos (ex navarino)"],
                    "type": "string",
                    "title": "Cabo de Hornos (Ex Navarino)"
                  },
                  {
                    "enum": ["laguna blanca"],
                    "type": "string",
                    "title": "Laguna Blanca"
                  },
                  {
                    "enum": ["natales"],
                    "type": "string",
                    "title": "Natales"
                  },
                  {
                    "enum": ["porvenir"],
                    "type": "string",
                    "title": "Porvenir"
                  },
                  {
                    "enum": ["primavera"],
                    "type": "string",
                    "title": "Primavera"
                  },
                  {
                    "enum": ["punta arenas"],
                    "type": "string",
                    "title": "Punta Arenas"
                  },
                  {
                    "enum": ["río verde"],
                    "type": "string",
                    "title": "Río Verde"
                  },
                  {
                    "enum": ["san gregorio"],
                    "type": "string",
                    "title": "San Gregorio"
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
              "country": {
                "enum": ["CL"]
              }
            }
          }
        ]
      }
    }
  };
  final uiSchema = {
    /* "boolean": {
      "radio": {"ui:widget": "radio"}
    } */
    "ui:order": [
      "short_name",
      "name",
      "tax_payer_registry",
      "birth_date",
      "father_name",
      "mother_name",
      "gender",
      "nationality",
      "country_birth",
      "state_birth",
      "state_birth_name",
      "professional_occupation",
      "wealths",
      "civil_state",
      "civil_state_type",
      "spouse_name",
      "educational_level",
      "PPE",
      "ppe_occupation",
      "institution_name",
      "document",
      "phone",
      "email",
      "address"
    ]
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
