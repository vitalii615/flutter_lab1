import 'package:flutter/material.dart';

class MatchListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const MatchListTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.sports_soccer, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
