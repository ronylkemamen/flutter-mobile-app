import 'package:flutter/material.dart';
import 'package:mobile_app/models/sensor.dart';

class YourThingDetailsScreen extends StatelessWidget {
  final Sensor thing;

  const YourThingDetailsScreen({super.key, required this.thing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(thing.name as String ?? 'Your Thing')),
      body: const Center(
        child: Text('Details for Your Thing will be displayed here.'),
      ),
    );
  }
}
