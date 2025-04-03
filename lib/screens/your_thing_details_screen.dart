import 'package:flutter/material.dart';

// Displays the details for a generic "My Thing" device.
class YourThingDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>
  thing; // The data representing the "My Thing" device.

  const YourThingDetailsScreen({super.key, required this.thing});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(thing['name'] as String ?? 'My Thing'),
    ), // AppBar displaying the name of the device.
    body: const Center(
      child: Text(
        'Details for Your Thing will be displayed here.',
      ), // Placeholder text indicating where the device details will be shown.
    ),
  );
}
