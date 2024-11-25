class TableLigaChempions {
  List<TeamStandings> standings;

  TableLigaChempions({required this.standings});

  factory TableLigaChempions.fromJson(Map<String, dynamic> json) {
    final standingsList = json['standings'][0]['table'] as List<dynamic>;
    final List<TeamStandings> standings = standingsList
        .map((teamData) => TeamStandings.fromJson(teamData as Map<String, dynamic>))
        .toList();
    return TableLigaChempions(standings: standings);
  }

  Map<String, dynamic> toJson() {
    return {
      'standings': standings.map((team) => team.toJson()).toList(),
    };
  }
}


class TeamStandings {
  int position;
  String teamName;
  int playedGames;
  int points;
  int goalDifference;
  int goalsFor;

  TeamStandings({
    required this.position,
    required this.teamName,
    required this.playedGames,
    required this.points,
    required this.goalDifference,
    required this.goalsFor,
  });

  factory TeamStandings.fromJson(Map<String, dynamic> json) {
    return TeamStandings(
      position: json['position'] as int, // В тип int
      teamName: json['team']['name'] as String, 
      playedGames: json['playedGames'] as int,  
      points: json['points'] as int,  
      goalDifference: json['goalDifference'] as int,  
      goalsFor: json['goalsFor'] as int,  
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'teamName': teamName,
      'playedGames': playedGames,
      'points': points,
      'goalDifference': goalDifference,
      'goalsFor': goalsFor,
    };
  }
}
