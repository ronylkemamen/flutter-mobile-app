import 'package:flutter/material.dart';
import 'package:mobile_app/screens/temperature_sensor_details_screen.dart';
import 'package:mobile_app/screens/your_thing_details_screen.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Updated list of things with type and dummy data
  final List<Map<String, dynamic>> _things = [
    {
      'name': 'Temperature Sensor',
      'type': 'Temperature Sensor',
      'clientAttributes': {'Serial Number': 'TS-001'},
      'serverAttributes': {'Location': 'Living Room'},
      'telemetryData': {'temperature': '22.5 °C'},
    },
    {
      'name': 'My Thing',
      'type': 'My Thing',
      'clientAttributes': {'ID': 'YD-001'},
      'serverAttributes': {'Status': 'Online'},
      'telemetryData': {'value': '100'},
    },
  ];
  String _filterType = 'All';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(AppLocalizations.of(context)!.things!),
      actions: [
        PopupMenuButton<String>(
          onSelected: (String result) {
            setState(() {
              _filterType = result;
            });
          },
          itemBuilder:
              (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'All',
                  child: Text(AppLocalizations.of(context)!.all!),
                ),
                const PopupMenuItem<String>(
                  value: 'Temperature Sensor',
                  child: Text('Temperature Sensor'),
                ),
                const PopupMenuItem<String>(
                  value: 'My Thing',
                  child: Text('My Thing'),
                ),
              ],
          child: const Icon(Icons.filter_list),
        ),
      ],
    ),
    body: ListView.builder(
      itemCount: _things.length,
      itemBuilder: (context, index) {
        final thing = _things[index];
        if (_filterType == 'All' || thing['type'] == _filterType) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: _getIconForThingType(
                thing['type'] as String,
              ), // Added leading icon
              title: Text(thing['name'] as String),
              subtitle: Text(
                '${AppLocalizations.of(context)!.type}: ${thing['type']}',
              ),
              onTap: () {
                if (thing['type'] == 'Temperature Sensor') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              TemperatureSensorDetailsScreen(thing: thing),
                    ),
                  );
                } else if (thing['type'] == 'My Thing') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => YourThingDetailsScreen(thing: thing),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.detailsNotAvailable!,
                      ),
                    ),
                  );
                }
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    ),
  );

  // Helper function to get the icon based on the thing type
  Widget _getIconForThingType(String type) {
    switch (type) {
      case 'Temperature Sensor':
        return const Icon(Icons.thermostat);
      case 'My Thing':
        return const Icon(Icons.home);
      default:
        return const Icon(Icons.device_unknown); // Default icon
    }
  }
}
