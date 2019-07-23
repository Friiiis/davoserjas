import 'Player.dart';

/**
 * The Model contains the data of the current session. Only one instance of Model is
 * made, and it is passed to all pages in the app.
 * @param player: list of PLayers of the current session
 * @param roundData: a 2D list. Contains a list of players for every round in the game.
 *  This means that every round's score is saved in this list.
 */
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

  /**
   * returns the points of the player with the given name
   */
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

  void addRoundData(List<Player> list, int round) {
    roundData[round] = list;
  }

  List<Player> getRoundData(int round) {
    return roundData[round];
  }

  /**
   * Returns the leaderboard at a specific round. Is used to show the 
   * score at a given time in the game
   */
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

  /**
   * Sorts the players by their ID 
   * This is used to restore the order that the user typed in the player names
   */
  void sortPlayersById(){
    players.sort((a, b) => a.getId().compareTo(b.getId()));
  }

  /**
   * Used for debugging: overrides the default toString and makes it possible
   * to print the current players and their points to the console
   */
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

}
