import 'package:flutter/material.dart';
import 'package:mobile_app/providers/app_state.dart'; // Manages application-wide state.
import 'package:mobile_app/screens/home_screen.dart'; // Displays the list of IoT devices.
import 'package:mobile_app/screens/settings_screen.dart'; // Allows users to configure app settings.
import 'package:provider/provider.dart'; // For state management.
import 'package:flutter_localizations/flutter_localizations.dart'; // For localization.
import 'package:mobile_app/l10n/app_localizations.dart'; // Provides localized strings.

void main() {
  // Entry point of the application.
  runApp(
    // Provides AppState to the entire app.
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

// Root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return MaterialApp(
      title: 'IoT App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: appState.currentThemeMode, // Sets theme based on AppState.
      locale: appState.currentLocale, // Sets locale based on AppState.
      supportedLocales: const [Locale('en'), Locale('fr')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first; // Default to English.
      },
      home: const MainPage(), // Sets the initial screen.
    );
  }
}

// Main page with bottom navigation.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Index of the selected tab.

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
    bottomNavigationBar: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppLocalizations.of(context)!.things, // Localized label.
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: AppLocalizations.of(context)!.settings, // Localized label.
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    ),
  );
}
