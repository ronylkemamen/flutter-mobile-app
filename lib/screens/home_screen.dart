import 'package:flutter/material.dart';
import 'package:mobile_app/screens/temperature_sensor_details_screen.dart';
import 'package:mobile_app/screens/your_thing_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Updated list of things with type and dummy data
  final List<Map<String, dynamic>> _things = [
    {
      'name': 'Temperature Sensor 1',
      'type': 'Temperature Sensor',
      'clientAttributes': {'Serial Number': 'TS-001'},
      'serverAttributes': {'Location': 'Living Room'},
      'telemetryData': {'temperature': '22.5 °C'},
    },
    {
      'name': 'My Special Device',
      'type': 'Your Thing',
      'clientAttributes': {'ID': 'YD-001'},
      'serverAttributes': {'Status': 'Online'},
      'telemetryData': {'value': '100'},
    },
    {
      'name': 'Temperature Sensor 2',
      'type': 'Temperature Sensor',
      'clientAttributes': {'Serial Number': 'TS-002'},
      'serverAttributes': {'Location': 'Bedroom'},
      'telemetryData': {'temperature': '24.0 °C'},
    },
  ];
  String _filterType = 'All';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('My Things'),
      actions: [
        PopupMenuButton<String>(
          onSelected: (String result) {
            setState(() {
              _filterType = result;
            });
          },
          itemBuilder:
              (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(value: 'All', child: Text('All')),
                const PopupMenuItem<String>(
                  value: 'Temperature Sensor',
                  child: Text('Temperature Sensor'),
                ),
                const PopupMenuItem<String>(
                  value: 'Your Thing',
                  child: Text('Your Thing'),
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
              subtitle: Text('Type: ${thing['type']}'),
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
                } else if (thing['type'] == 'Your Thing') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => YourThingDetailsScreen(thing: thing),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Details not available for this type.'),
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
      case 'Your Thing':
        return const Icon(Icons.home);
      default:
        return const Icon(Icons.device_unknown); // Default icon
    }
  }
}
