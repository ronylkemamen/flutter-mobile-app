import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Provides the infrastructure for internationalizing Flutter applications.
import 'dart:async'; // Used for asynchronous operations, although not directly used in this version.

// Provides localized strings for the application based on the current locale.
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale; // The current locale of the application.

  // Static method to easily access the AppLocalizations instance from the current context.
  static AppLocalizations? of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  // Constant delegate that provides the AppLocalizations instance.
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Stores the localized values for different languages.
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'all': 'All',
      'type': 'Type',
      'things': 'Things',
      'settings': 'Settings',
      'language': 'Language',
      'theme': 'Theme',
      'systemDefault': 'System Default',
      'light': 'Light',
      'dark': 'Dark',
      'temperatureUnit': 'Temperature Unit',
      'celsius': 'Celsius',
      'fahrenheit': 'Fahrenheit',
      'temperature': 'Temperature',
      'humidity': 'Humidity',
      'location': 'Location',
      'status': 'Status',
      'IP Address': 'IP Address',
      'serialNumber': 'Serial Number',
      'id': 'ID',
      'detailsNotAvailable': 'Details not available for this type.',
      'clientAttributes': 'Client Attributes',
      'serverAttributes': 'Server Attributes',
      'telemetryData': 'Telemetry Data',
      'Location': 'Location',
      'Serial Number': 'Serial Number',
      'refreshRate': 'Refresh Rate',
      'manual': 'Manual',
      'seconds': 'seconds',
      'viewTelemetryHistory': 'View Telemetry History',
      'telemetryHistory': 'Telemetry History',
      'historyFor': 'History for:',
      'historicalTelemetryGraph': 'Historical Telemetry Graph',
      'graphWillBeHere': 'Graph will be here',
      'online': 'Online',
      'offline': 'Offline',
      'updateServerAttributes': 'Update Server Attributes',
      'bedroom1': 'Bedroom 1',
      'bedroom2': 'Bedroom 2',
      'diningRoom': 'Dining Room',
      'livingRoom1': 'Living Room 1',
      'livingRoom2': 'Living Room 2',
      'stairs': 'Stairs',
    },
    'fr': {
      'all': 'Tous',
      'type': 'Type',
      'things': 'Objets',
      'settings': 'Paramètres',
      'language': 'Langue',
      'theme': 'Thème',
      'systemDefault': 'Système par défaut',
      'light': 'Clair',
      'dark': 'Sombre',
      'temperatureUnit': 'Unité de température',
      'celsius': 'Celsius',
      'fahrenheit': 'Fahrenheit',
      'temperature': 'Température',
      'humidity': 'Humidité',
      'location': 'Emplacement',
      'status': 'Statut',
      'IP Address': 'Adresse IP',
      'serialNumber': 'Numéro de série',
      'id': 'ID',
      'detailsNotAvailable': 'Détails non disponibles pour ce type.',
      'clientAttributes': 'Attributs Client',
      'serverAttributes': 'Attributs Serveur',
      'telemetryData': 'Données de Télémétrie',
      'Location': 'Emplacement',
      'Serial Number': 'Numéro de série',
      'refreshRate': 'Taux de Rafraîchissement',
      'manual': 'Manuel',
      'seconds': 'secondes',
      'viewTelemetryHistory': 'Voir l\'Historique de la Télémétrie',
      'telemetryHistory': 'Historique de la Télémétrie',
      'historyFor': 'Historique pour :',
      'historicalTelemetryGraph': 'Graphique Historique de la Télémétrie',
      'graphWillBeHere': 'Le graphique sera ici',
      'stairs': 'Stairs',
      'online': 'En ligne',
      'offline': 'Hors ligne',
      'updateServerAttributes': 'Mettre à jour les Attributs Serveur',
      'bedroom1': 'Chambre 1',
      'bedroom2': 'Chambre 2',
      'diningRoom': 'Salle à Manger',
      'livingRoom1': 'Salon 1',
      'livingRoom2': 'Salon 2',
      'stairs': 'Escaliers',
    },
  };

  // Getter for the localized 'all' string.
  String? get all => _localizedValues[locale.languageCode]?['all'];

  // Getter for the localized 'type' string.
  String? get type => _localizedValues[locale.languageCode]?['type'];

  // Getter for the localized 'things' string.
  String? get things => _localizedValues[locale.languageCode]?['things'];

  // Getter for the localized 'settings' string.
  String? get settings => _localizedValues[locale.languageCode]?['settings'];

  // Getter for the localized 'language' string.
  String? get language => _localizedValues[locale.languageCode]?['language'];

  // Getter for the localized 'theme' string.
  String? get theme => _localizedValues[locale.languageCode]?['theme'];

  // Getter for the localized 'systemDefault' string.
  String? get systemDefault =>
      _localizedValues[locale.languageCode]?['systemDefault'];

  // Getter for the localized 'light' string.
  String? get light => _localizedValues[locale.languageCode]?['light'];

  // Getter for the localized 'dark' string.
  String? get dark => _localizedValues[locale.languageCode]?['dark'];

  // Getter for the localized 'temperatureUnit' string.
  String? get temperatureUnit =>
      _localizedValues[locale.languageCode]?['temperatureUnit'];

  // Getter for the localized 'celsius' string.
  String? get celsius => _localizedValues[locale.languageCode]?['celsius'];

  // Getter for the localized 'fahrenheit' string.
  String? get fahrenheit =>
      _localizedValues[locale.languageCode]?['fahrenheit'];

  // Getter for the localized 'temperature' string.
  String? get temperature =>
      _localizedValues[locale.languageCode]?['temperature'];

  // Getter for the localized 'humidity' string.
  String? get humidity => _localizedValues[locale.languageCode]?['humidity'];

  // Getter for the localized 'location' string.
  String? get location => _localizedValues[locale.languageCode]?['location'];

  // Getter for the localized 'status' string.
  String? get status => _localizedValues[locale.languageCode]?['status'];

  // Getter for the localized 'IP Address' string.
  String? get ipAddress => _localizedValues[locale.languageCode]?['IP Address'];

  // Getter for the localized 'serialNumber' string.
  String? get serialNumber =>
      _localizedValues[locale.languageCode]?['serialNumber'];

  // Getter for the localized 'id' string.
  String? get id => _localizedValues[locale.languageCode]?['id'];

  // Getter for the localized 'detailsNotAvailable' string.
  String? get detailsNotAvailable =>
      _localizedValues[locale.languageCode]?['detailsNotAvailable'];

  // Getter for the localized 'clientAttributes' string.
  String? get clientAttributes =>
      _localizedValues[locale.languageCode]?['clientAttributes'];

  // Getter for the localized 'serverAttributes' string.
  String? get serverAttributes =>
      _localizedValues[locale.languageCode]?['serverAttributes'];

  // Getter for the localized 'telemetryData' string.
  String? get telemetryData =>
      _localizedValues[locale.languageCode]?['telemetryData'];

  // Getter for the localized 'Location' string.
  String? get locationLabel =>
      _localizedValues[locale.languageCode]?['Location'];

  // Getter for the localized 'Serial Number' string.
  String? get serialNumberLabel =>
      _localizedValues[locale.languageCode]?['Serial Number'];

  // Getter for the localized 'refreshRate' string.
  String? get refreshRate =>
      _localizedValues[locale.languageCode]?['refreshRate'];

  // Getter for the localized 'manual' string.
  String? get manual => _localizedValues[locale.languageCode]?['manual'];

  // Getter for the localized 'seconds' string.
  String? get seconds => _localizedValues[locale.languageCode]?['seconds'];

  // Getter for the localized 'viewTelemetryHistory' string.
  String? get viewTelemetryHistory =>
      _localizedValues[locale.languageCode]?['viewTelemetryHistory'];

  // Getter for the localized 'telemetryHistory' string.
  String? get telemetryHistory =>
      _localizedValues[locale.languageCode]?['telemetryHistory'];

  // Getter for the localized 'historyFor' string.
  String? get historyFor =>
      _localizedValues[locale.languageCode]?['historyFor'];

  // Getter for the localized 'historicalTelemetryGraph' string.
  String? get historicalTelemetryGraph =>
      _localizedValues[locale.languageCode]?['historicalTelemetryGraph'];

  // Getter for the localized 'graphWillBeHere' string.
  String? get graphWillBeHere =>
      _localizedValues[locale.languageCode]?['graphWillBeHere'];

  // Getter for the localized 'online' string.
  String? get online => _localizedValues[locale.languageCode]?['online'];

  // Getter for the localized 'offline' string.
  String? get offline => _localizedValues[locale.languageCode]?['offline'];

  // Getter for the localized 'updateServerAttributes' string.
  String? get updateServerAttributes =>
      _localizedValues[locale.languageCode]?['updateServerAttributes'];

  // Getter for the localized 'bedroom1' string.
  String? get bedroom1 => _localizedValues[locale.languageCode]?['bedroom1'];

  // Getter for the localized 'bedroom2' string.
  String? get bedroom2 => _localizedValues[locale.languageCode]?['bedroom2'];

  // Getter for the localized 'diningRoom' string.
  String? get diningRoom =>
      _localizedValues[locale.languageCode]?['diningRoom'];

  // Getter for the localized 'livingRoom1' string.
  String? get livingRoom1 =>
      _localizedValues[locale.languageCode]?['livingRoom1'];

  // Getter for the localized 'livingRoom2' string.
  String? get livingRoom2 =>
      _localizedValues[locale.languageCode]?['livingRoom2'];

  // Getter for the localized 'stairs' string.
  String? get stairs => _localizedValues[locale.languageCode]?['stairs'];
}

// Implementation of the LocalizationsDelegate for AppLocalizations.
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  // Checks if the given locale is supported by this delegate.
  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'fr',
    ].contains(locale.languageCode); // Supports English and French.
  }

  // Loads the AppLocalizations instance for the given locale.
  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    return localizations;
  }

  // Determines if the delegate should reload the localizations (usually false for static localizations).
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
