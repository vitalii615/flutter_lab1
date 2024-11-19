import 'package:flutter/material.dart';
import 'match_list_tile.dart';

class CollapsibleTour extends StatefulWidget {
  final String tourName;
  final List<Map<String, String>> matches;
  final bool isOpen;
  final void Function(String) onToggle; // тип функції як void Function(String)

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
    // Отримуємо розміри екрана
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => widget.onToggle(widget.tourName),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02, // вертикальний відступ
              horizontal: screenWidth * 0.03, // горизонтальний відступ
            ),
            color: widget.isOpen ? Colors.blue[800] : Colors.blue,
            child: Text(
              widget.tourName,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.045, 
              ),
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
