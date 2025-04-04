import 'dart:convert';

import 'package:mobile_app/models/sensor.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/utils/constants.dart';

Future getSensors() async {
  try {
    print("go fetch the data");
    // Envoie les données via une requête POST
    final response = await http.get(Uri.parse(MOBILE_API_URL + "devices"));
	

    if (response.statusCode == 200) {
      // Si la requête est réussie, affiche la réponse
      print('Données envoyées avec succès : ${jsonDecode(response.body)}');

    } else {
      // Si la requête échoue, affiche l'erreur
      print('Erreur lors de l\'envoi des données : ${response.statusCode}');
    }
    return jsonDecode(response.body);
  } catch (e) {
    print('Erreur : $e');
    return [];
  }
}
