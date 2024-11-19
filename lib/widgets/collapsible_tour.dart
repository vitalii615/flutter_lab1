import 'package:flutter/material.dart';
import 'match_list_tile.dart';

class CollapsibleTour extends StatefulWidget {
  final String tourName;
  final List<Map<String, String>> matches;
  final bool isOpen;
  final Function(String) onToggle;

  const CollapsibleTour({
    super.key,
    required this.tourName,
    required this.matches,
    required this.isOpen,
    required this.onToggle,
  });

  @override
  _CollapsibleTourState createState() => _CollapsibleTourState();
}

class _CollapsibleTourState extends State<CollapsibleTour> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => widget.onToggle(widget.tourName),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            color: widget.isOpen ? Colors.blue[800] : Colors.blue,
            child: Text(
              widget.tourName,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        if (widget.isOpen)
          ...widget.matches.map((match) => MatchListTile(
                title: match['title']!,
                subtitle: match['date']!,
              )),
      ],
    );
  }
}
