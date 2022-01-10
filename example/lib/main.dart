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
        "title": "direccion de residencia",
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
          }
        ]
      }
    }
  };
  /* final json = {
    "type": "object",
    "title": "Tus datos",
    "required": [
      "first_name",
      "last_name",
      "nationality",
      "profession",
      "birthday",
      "gender",
      "selected_PEP"
    ],
    "properties": {
      "gender": {
        "type": "boolean",
        "title": "Género",
        "default": "false",
        "enumNames": ["Sí", "No"]
      },
      "birthday": {
        "type": "string",
        "title": "Fecha de nacimiento",
        "format": "date"
      },
      "last_name": {"type": "string", "title": "Apellido", "maxLength": 150},
      "first_name": {"type": "string", "title": "Nombre", "maxLength": 30},
      "profession": {
        "type": "string",
        "oneOf": [
          {
            "enum": ["Trader"],
            "type": "string",
            "title": "trader"
          },
          {
            "enum": ["Inversionista"],
            "type": "string",
            "title": "investor"
          },
          {
            "enum": ["Estudiante"],
            "type": "string",
            "title": "student"
          },
          {
            "enum": ["Ama de casa"],
            "type": "string",
            "title": "housewife"
          },
          {
            "enum": ["Contador(a)"],
            "type": "string",
            "title": "accountant"
          },
          {
            "enum": ["Actor / Actriz"],
            "type": "string",
            "title": "actor_actress"
          },
          {
            "enum": ["Auxiliar de Vuelo"],
            "type": "string",
            "title": "air_hostess"
          },
          {
            "enum": ["Arqueólogo(a)"],
            "type": "string",
            "title": "archaeologist"
          },
          {
            "enum": ["Arquitecto(a)"],
            "type": "string",
            "title": "architect"
          },
          {
            "enum": ["Astronauta"],
            "type": "string",
            "title": "astronaut"
          },
          {
            "enum": ["Panadero (a)"],
            "type": "string",
            "title": "baker"
          },
          {
            "enum": ["Biólogo (a)"],
            "type": "string",
            "title": "biologist"
          },
          {
            "enum": ["Albañil / Maestro(a) Construcción"],
            "type": "string",
            "title": "bricklayer"
          },
          {
            "enum": ["Conductor(a) / Transportista"],
            "type": "string",
            "title": "driver"
          },
          {
            "enum": ["Empresario(a)"],
            "type": "string",
            "title": "businessman"
          },
          {
            "enum": ["Carnicero(a)"],
            "type": "string",
            "title": "butcher"
          },
          {
            "enum": ["Portero / Conserje"],
            "type": "string",
            "title": "caretaker_janitor_porter"
          },
          {
            "enum": ["Carpintero(a)"],
            "type": "string",
            "title": "carpenter"
          },
          {
            "enum": ["Cajero(a)"],
            "type": "string",
            "title": "cashier"
          },
          {
            "enum": ["Auxiliar de limpieza"],
            "type": "string",
            "title": "cleaner"
          },
          {
            "enum": ["Payaso"],
            "type": "string",
            "title": "clown"
          },
          {
            "enum": ["Zapatero(a)"],
            "type": "string",
            "title": "cobbler"
          },
          {
            "enum": ["Cocinero(a) / Chef"],
            "type": "string",
            "title": "cook_chef"
          },
          {
            "enum": ["Químico(a) "],
            "type": "string",
            "title": "chemist"
          },
          {
            "enum": ["Bailarín(a)"],
            "type": "string",
            "title": "dancer"
          },
          {
            "enum": ["Decorador (a)"],
            "type": "string",
            "title": "decorator"
          },
          {
            "enum": ["Dentista"],
            "type": "string",
            "title": "dentist"
          },
          {
            "enum": ["Diseñador(a)"],
            "type": "string",
            "title": "designer"
          },
          {
            "enum": ["Médico(a)"],
            "type": "string",
            "title": "physician"
          },
          {
            "enum": ["Modista"],
            "type": "string",
            "title": "dressmaker"
          },
          {
            "enum": ["Recolector de Basura"],
            "type": "string",
            "title": "dustman"
          },
          {
            "enum": ["Economista"],
            "type": "string",
            "title": "economist"
          },
          {
            "enum": ["Electricista"],
            "type": "string",
            "title": "electrician"
          },
          {
            "enum": ["Ingeniero(a)"],
            "type": "string",
            "title": "engineer"
          },
          {
            "enum": ["Granjero / Agricultor"],
            "type": "string",
            "title": "farmer"
          },
          {
            "enum": ["Bombero(a)"],
            "type": "string",
            "title": "fireman"
          },
          {
            "enum": ["Pescador(a)"],
            "type": "string",
            "title": "fisherman"
          },
          {
            "enum": ["Florista"],
            "type": "string",
            "title": "florist"
          },
          {
            "enum": ["Feriante"],
            "type": "string",
            "title": "fruiterer"
          },
          {
            "enum": ["Jardinero(a)"],
            "type": "string",
            "title": "gardener"
          },
          {
            "enum": ["Geólogo(a)"],
            "type": "string",
            "title": "geologist"
          },
          {
            "enum": ["Peluquero(a) / Estilista"],
            "type": "string",
            "title": "hairdresser"
          },
          {
            "enum": ["Joyero(a)"],
            "type": "string",
            "title": "jeweller"
          },
          {
            "enum": ["Periodista"],
            "type": "string",
            "title": "journalist"
          },
          {
            "enum": ["Juez"],
            "type": "string",
            "title": "judge"
          },
          {
            "enum": ["Abogado(a)"],
            "type": "string",
            "title": "lawyer"
          },
          {
            "enum": ["Bibliotecario(a)"],
            "type": "string",
            "title": "librarian"
          },
          {
            "enum": ["Socorrista"],
            "type": "string",
            "title": "life_guard"
          },
          {
            "enum": ["Cartero(a)"],
            "type": "string",
            "title": "mailman_postman"
          },
          {
            "enum": ["Mecánico(a)"],
            "type": "string",
            "title": "mechanic"
          },
          {
            "enum": ["Meteorólogo"],
            "type": "string",
            "title": "meteorologist"
          },
          {
            "enum": ["Minero(a) Criptomonedas"],
            "type": "string",
            "title": "cryptocurrency_miner"
          },
          {
            "enum": ["Minero(a) de Minerales"],
            "type": "string",
            "title": "mineral_miner"
          },
          {
            "enum": ["Modelo(a)"],
            "type": "string",
            "title": "model"
          },
          {
            "enum": ["Niñera(o)"],
            "type": "string",
            "title": "nanny_nursemaid"
          },
          {
            "enum": ["Monja"],
            "type": "string",
            "title": "nun"
          },
          {
            "enum": ["Enfermero(a)"],
            "type": "string",
            "title": "nurse"
          },
          {
            "enum": ["Pintor(a)"],
            "type": "string",
            "title": "painter"
          },
          {
            "enum": ["Pastelero(a) / Repostero(a)"],
            "type": "string",
            "title": "pastry_cook"
          },
          {
            "enum": ["Farmaceútico"],
            "type": "string",
            "title": "pharmacist"
          },
          {
            "enum": ["Fotógrafo(a)"],
            "type": "string",
            "title": "photographer"
          },
          {
            "enum": ["Físico"],
            "type": "string",
            "title": "physicist"
          },
          {
            "enum": ["Fontanero(a) / Gásfiter"],
            "type": "string",
            "title": "plumber"
          },
          {
            "enum": ["Policía / Carabinero"],
            "type": "string",
            "title": "policeman_policewoman"
          },
          {
            "enum": ["Político"],
            "type": "string",
            "title": "politician"
          },
          {
            "enum": ["Cura / Sacerdote"],
            "type": "string",
            "title": "priest"
          },
          {
            "enum": ["Profesor(a)"],
            "type": "string",
            "title": "professor_teacher"
          },
          {
            "enum": ["Programador(a) / Desarrollador(a)"],
            "type": "string",
            "title": "programmer"
          },
          {
            "enum": ["Psiquiatra"],
            "type": "string",
            "title": "psychiatrist"
          },
          {
            "enum": ["Psicólogo(a)"],
            "type": "string",
            "title": "psychologist"
          },
          {
            "enum": ["Recepcionista"],
            "type": "string",
            "title": "receptionist"
          },
          {
            "enum": ["Investigador(a) / Científico(a)"],
            "type": "string",
            "title": "researcher_scientist"
          },
          {
            "enum": ["Marinero(a)"],
            "type": "string",
            "title": "sailor"
          },
          {
            "enum": ["Vendedor(a)"],
            "type": "string",
            "title": "salesman"
          },
          {
            "enum": ["Secretario(a)"],
            "type": "string",
            "title": "secretary"
          },
          {
            "enum": ["Dependiente(a) de una tienda"],
            "type": "string",
            "title": "shop_assistant"
          },
          {
            "enum": ["Cantante / Músico"],
            "type": "string",
            "title": "singer"
          },
          {
            "enum": ["Trabajador social"],
            "type": "string",
            "title": "social_worker"
          },
          {
            "enum": ["Deportista"],
            "type": "string",
            "title": "sportsman"
          },
          {
            "enum": ["Cirujano(a)"],
            "type": "string",
            "title": "surgeon"
          },
          {
            "enum": ["Taxista"],
            "type": "string",
            "title": "taxi_driver"
          },
          {
            "enum": ["Telefonista / Telemarketing"],
            "type": "string",
            "title": "telephone_operator"
          },
          {
            "enum": ["Agente de viajes"],
            "type": "string",
            "title": "travel_agent"
          },
          {
            "enum": ["Veterinario(a)"],
            "type": "string",
            "title": "veterinarian"
          },
          {
            "enum": ["Camarero(a) / Mesero(a)"],
            "type": "string",
            "title": "waiter_waitress"
          },
          {
            "enum": ["Escritor(a)"],
            "type": "string",
            "title": "writer"
          },
          {
            "enum": ["Repartidor Delivery"],
            "type": "string",
            "title": "deliveryman"
          },
          {
            "enum": ["Conductor (Aplicación móvil)"],
            "type": "string",
            "title": "uber_driver"
          },
          {
            "enum": ["Piloto"],
            "type": "string",
            "title": "pilot"
          },
          {
            "enum": ["Administrativo(a)"],
            "type": "string",
            "title": "administrative"
          },
          {
            "enum": ["Funcionario(a) Público"],
            "type": "string",
            "title": "public_servant"
          },
          {
            "enum": ["Otro"],
            "type": "string",
            "title": "other"
          },
          {
            "enum": ["Atención a Cliente"],
            "type": "string",
            "title": "customer_care"
          },
          {
            "enum": ["Militar"],
            "type": "string",
            "title": "military"
          },
          {
            "enum": ["Gerente / Director(a)"],
            "type": "string",
            "title": "manager_officier"
          }
        ],
        "title": "Ocupación o profesión"
      },
      "nationality": {
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
        "title": "Nacionalidad"
      },
      "selected_PEP": {
        "type": "boolean",
        "title": "¿Eres una Persona Póliticamente Expuesta?",
        "default": "false",
        "enumNames": ["Sí", "No"]
      }
    }
  };
 */
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
