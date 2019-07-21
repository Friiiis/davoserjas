import 'Player.dart';

class Model {
  List<Player> players = List<Player>();
  List<List<Player>> roundData = List<List<Player>>();

  void addPlayer(String name, int id) {
    for (Player player in players) {
      if (name == player.getName()) {
        throw Exception("Player " + name + " already exists");
      }
      if (id == player.getId()) {
        throw Exception("Player id already exists: " + id.toString());
      }
    }
    Player player = Player(name, id);
    players.add(player);
  }

  void addPointsToPlayer(String name, int points) {
    for (Player player in players) {
      if (name == player.getName()) {
        player.addPoints(points);
      }
    }
  }

  int getPointsFromPlayerName(String name) {
    for (Player player in players) {
      if (name == player.getName()) {
        return player.getPoints();
      }
    }
    return -1;
  }

  void reset() {
    players = List<Player>();
  }

  String toString() {
    String s1 = "Number of players: " + players.length.toString() + "\n";
    for (Player player in players) {
      s1 = s1 +
          player.getName() +
          ": " +
          player.getPoints().toString() +
          " points" +
          "\n";
    }
    return s1;
  }

  void addRoundData(List<Player> list, int round) {
    roundData[round] = list;
  }

  List<Player> getRoundData(int round) {
    return roundData[round];
  }

  List<Player> getLeaderboardAtRound(int round) {
    List<Player> list = players;
    for (Player player in list) {
      player.resetPoints();
      for (var i = 0; i < round; i++) {
        player.addPoints(player.getRoundPoints(i));
      }
    }
    return list;
  }

  void sortPlayersById(){
    players.sort((a, b) => a.getId().compareTo(b.getId()));
  }

}
