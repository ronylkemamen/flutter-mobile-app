import 'package:flutter/material.dart';

class YourThingDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> thing;

  const YourThingDetailsScreen({super.key, required this.thing});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(thing['name'] as String ?? 'My Thing')),
    body: const Center(
      child: Text('Details for Your Thing will be displayed here.'),
    ),
  );
}
