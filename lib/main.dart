import 'package:flutter/material.dart';
import 'package:mobile_app/providers/app_state.dart'; // Manages global application state.
import 'package:mobile_app/screens/home_screen.dart'; // Displays the home screen.
import 'package:mobile_app/screens/settings_screen.dart'; // Displays the settings screen.
import 'package:provider/provider.dart'; // For state management.
import 'package:flutter_localizations/flutter_localizations.dart'; // Enables localization.
import 'package:mobile_app/l10n/app_localizations.dart'; // Provides localized strings.

void main() {
  // Application entry point; sets up the app with state management.
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(), // Initializes the application state.
      child: const MyApp(), // The root application widget.
    ),
  );
}

// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(
      context,
    ); // Accesses the application state.
    return MaterialApp(
      title: 'IoT App', // Application title.
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ), // Default light theme.
      darkTheme: ThemeData.dark(useMaterial3: true), // Dark theme.
      themeMode: appState.currentThemeMode, // Sets the current theme mode.
      locale: appState.currentLocale, // Sets the current locale.
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ], // Supported languages.
      localizationsDelegates: const [
        AppLocalizations.delegate, // Provides localized app strings.
        GlobalMaterialLocalizations
            .delegate, // Provides localized Material design components.
        GlobalWidgetsLocalizations
            .delegate, // Provides localized basic widgets.
        GlobalCupertinoLocalizations
            .delegate, // Provides localized Cupertino (iOS-style) widgets.
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales
            .first; // Defaults to the first supported locale.
      },
      home: const MainPage(), // The initial screen of the app.
    );
  }
}

// The main page with bottom navigation.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Index of the currently selected navigation item.

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), // Displays the home screen content.
    SettingsScreen(), // Displays the settings screen content.
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Updates the selected navigation item index.
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    ), // Displays the widget for the selected tab.
    bottomNavigationBar: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label:
              AppLocalizations.of(
                context,
              )!.things, // Localized label for the home screen.
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label:
              AppLocalizations.of(
                context,
              )!.settings, // Localized label for the settings screen.
        ),
      ],
      currentIndex: _selectedIndex, // Highlights the currently selected item.
      selectedItemColor: Colors.blue, // Color of the selected item.
      onTap: _onItemTapped, // Handles navigation item taps.
    ),
  );
}
