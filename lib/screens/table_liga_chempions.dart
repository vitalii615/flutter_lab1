import 'package:flutter/material.dart';
import 'package:my_project_lab1/api/api_service.dart';  
import 'package:my_project_lab1/api/models_league_standings.dart'; 

class TableLigaChempionsScreen extends StatelessWidget {
  const TableLigaChempionsScreen({super.key});

  Future<TableLigaChempions> fetchStandings() async {
    return await FootballApiService.fetchStandings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ліга Чемпіонів - Таблиця'),
        centerTitle: true,
      ),
      body: FutureBuilder<TableLigaChempions>(
        future: fetchStandings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Помилка при завантаженні даних'));
          } else if (!snapshot.hasData || snapshot.data!.standings.isEmpty) {
            return const Center(child: Text('Немає даних для відображення'));
          } else {
            final standings = snapshot.data!.standings;
            return ListView.builder(
              itemCount: standings.length,
              itemBuilder: (context, index) {
                final team = standings[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Text('${team.position}'),
                    title: Text(team.teamName),
                    subtitle: Text(
                        'Matches: ${team.playedGames} | Points: ${team.points} | +/-: ${team.goalDifference} | Goals: ${team.goalsFor}',),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
