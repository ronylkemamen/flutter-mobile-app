import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:async';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
      'location': 'Location',
      'status': 'Status',
      'serialNumber': 'Serial Number',
      'id': 'ID',
      'detailsNotAvailable': 'Details not available for this type.',
      'clientAttributes': 'Client Attributes',
      'serverAttributes': 'Server Attributes',
      'telemetryData': 'Telemetry Data',
      'refreshRate': 'Refresh Rate',
      'manual': 'Manual',
      'seconds': 'seconds',
      'viewTelemetryHistory': 'View Telemetry History',
      'telemetryHistory': 'Telemetry History',
      'historyFor': 'History for:',
      'historicalTelemetryGraph': 'Historical Telemetry Graph',
      'graphWillBeHere': 'Graph will be here',
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
      'location': 'Emplacement',
      'status': 'Statut',
      'serialNumber': 'Numéro de série',
      'id': 'ID',
      'detailsNotAvailable': 'Détails non disponibles pour ce type.',
      'clientAttributes': 'Attributs Client',
      'serverAttributes': 'Attributs Serveur',
      'telemetryData': 'Données de Télémétrie',
      'refreshRate': 'Taux de Rafraîchissement',
      'manual': 'Manuel',
      'seconds': 'secondes',
      'viewTelemetryHistory': 'Voir l\'Historique de la Télémétrie',
      'telemetryHistory': 'Historique de la Télémétrie',
      'historyFor': 'Historique pour :',
      'historicalTelemetryGraph': 'Graphique Historique de la Télémétrie',
      'graphWillBeHere': 'Le graphique sera ici',
    },
  };

  String? get all {
    return _localizedValues[locale.languageCode]?['all'];
  }

  String? get type {
    return _localizedValues[locale.languageCode]?['type'];
  }

  String? get things {
    return _localizedValues[locale.languageCode]?['things'];
  }

  String? get settings {
    return _localizedValues[locale.languageCode]?['settings'];
  }

  String? get language {
    return _localizedValues[locale.languageCode]?['language'];
  }

  String? get theme {
    return _localizedValues[locale.languageCode]?['theme'];
  }

  String? get systemDefault {
    return _localizedValues[locale.languageCode]?['systemDefault'];
  }

  String? get light {
    return _localizedValues[locale.languageCode]?['light'];
  }

  String? get dark {
    return _localizedValues[locale.languageCode]?['dark'];
  }

  String? get temperatureUnit {
    return _localizedValues[locale.languageCode]?['temperatureUnit'];
  }

  String? get celsius {
    return _localizedValues[locale.languageCode]?['celsius'];
  }

  String? get fahrenheit {
    return _localizedValues[locale.languageCode]?['fahrenheit'];
  }

  String? get temperature {
    return _localizedValues[locale.languageCode]?['temperature'];
  }

  String? get location {
    return _localizedValues[locale.languageCode]?['location'];
  }

  String? get status {
    return _localizedValues[locale.languageCode]?['status'];
  }

  String? get serialNumber {
    return _localizedValues[locale.languageCode]?['serialNumber'];
  }

  String? get id {
    return _localizedValues[locale.languageCode]?['id'];
  }

  String? get detailsNotAvailable {
    return _localizedValues[locale.languageCode]?['detailsNotAvailable'];
  }

  String? get clientAttributes {
    return _localizedValues[locale.languageCode]?['clientAttributes'];
  }

  String? get serverAttributes {
    return _localizedValues[locale.languageCode]?['serverAttributes'];
  }

  String? get telemetryData {
    return _localizedValues[locale.languageCode]?['telemetryData'];
  }

  String? get refreshRate {
    return _localizedValues[locale.languageCode]?['refreshRate'];
  }

  String? get manual {
    return _localizedValues[locale.languageCode]?['manual'];
  }

  String? get seconds {
    return _localizedValues[locale.languageCode]?['seconds'];
  }

  String? get viewTelemetryHistory {
    return _localizedValues[locale.languageCode]?['viewTelemetryHistory'];
  }

  String? get telemetryHistory {
    return _localizedValues[locale.languageCode]?['telemetryHistory'];
  }

  String? get historyFor {
    return _localizedValues[locale.languageCode]?['historyFor'];
  }

  String? get historicalTelemetryGraph {
    return _localizedValues[locale.languageCode]?['historicalTelemetryGraph'];
  }

  String? get graphWillBeHere {
    return _localizedValues[locale.languageCode]?['graphWillBeHere'];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
