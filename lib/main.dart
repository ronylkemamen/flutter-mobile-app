import 'package:flutter/material.dart';
import 'package:mobile_app/providers/app_state.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_app/l10n/app_localizations.dart'; // Create this folder and file

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return MaterialApp(
      title: 'IoT App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: appState.currentThemeMode,
      locale: appState.currentLocale,
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
        return supportedLocales.first; // Default to English if not supported
      },
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.things, // Use localized text
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settings, // Use localized text
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
