import 'package:flutter/material.dart';
import '../api/api_service.dart';  
import '../api/models_league_standings.dart'; 

class TableLigaChempionsScreen extends StatelessWidget {
  Future<TableLigaChempions> fetchStandings() async {
    return await FootballApiService.fetchStandings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ліга Чемпіонів - Таблиця'),
        centerTitle: true,
      ),
      body: FutureBuilder<TableLigaChempions>(
        future: fetchStandings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Помилка при завантаженні даних'));
          } else if (!snapshot.hasData || snapshot.data!.standings.isEmpty) {
            return Center(child: Text('Немає даних для відображення'));
          } else {
            var standings = snapshot.data!.standings;
            return ListView.builder(
              itemCount: standings.length,
              itemBuilder: (context, index) {
                var team = standings[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Text('${team.position}'),
                    title: Text(team.teamName),
                    subtitle: Text(
                        'Matches: ${team.playedGames} | Points: ${team.points} | +/-: ${team.goalDifference} | Goals: ${team.goalsFor}'),
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
