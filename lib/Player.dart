/**
 * Player class represent the players of the game, and holds player specific information
 */
class Player {
  final String name;
  final int id;
  int points = 0;
  List<int> roundPoints = List<int>(8);

  Player(this.name, this.id){
    for (var i = 0; i < 8; i++) {
      roundPoints[i] = 0;
    }
  }

  void addPoints(int addedPoints) {
    points = points + addedPoints;
  }

  void setPoints(int pointsSet) {
    points = pointsSet;
  }

  bool removePoints(int removedPoints) {
    if (points - removedPoints < 0) {
      points = 0;
      return false;
    } else {
      points = points - removedPoints;
      return true;
    }
  }

  void resetPoints(){
    points = 0;
  }

  void setRoundPoint(int round, int points){
    roundPoints[round] = points;
  }

  String getName() {
    return name;
  }

  int getPoints() {
    return points;
  }

  int getRoundPoints(int round){
    return roundPoints[round];
  }

  int getId() {
    return id;
  }

  int getTotalRoundPoints() {
    int i = 0;
    for (int k in roundPoints) {
      i += k;
    }
    return i;
  }
}
