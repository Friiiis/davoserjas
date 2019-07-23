/**
 * Rules contains the Davoserjas ruleset
 */
class Rules {

  int getPoints(int currentRound){
    if (currentRound == 1) {
      return _getPointsRoundOne();
    } else if (currentRound == 2) {
      return _getPointsRoundTwo();
    } else if (currentRound == 3) {
      return _getPointsRoundThree();
    } else if (currentRound == 4) {
      return _getPointsRoundFour();
    } else if (currentRound == 5) {
      return _getPointsRoundFive();
    } else if (currentRound == 7) {
      return _getPointsRoundSeven();
    } else {
      return 0;
    }
  }

  int _getPointsRoundOne(){
    return 5;
  }

  int _getPointsRoundTwo(){
    return 5;
  }

  int _getPointsRoundThree(){
    return 10;
  }

  int _getPointsRoundFour(){
    return 25;
  }

  int _getPointsRoundFive(){
    return 50;
  }

  int _getPointsRoundSeven(){
    return 5;
  }

  int getAmount(int currentRound, int amountOfPlayers){
    if (currentRound == 1) {
      return _getAmountRoundOne(amountOfPlayers);
    } else if (currentRound == 2) {
      return _getAmountRoundTwo();
    } else if (currentRound == 3) {
      return _getAmountRoundThree();
    } else if (currentRound == 4) {
      return _getAmountRoundFour();
    } else if (currentRound == 5) {
      return _getAmountRoundFive();
    } else if (currentRound == 7) {
      return _getAmountRoundSeven();
    } else {
      return 0;
    }
  }

  int _getAmountRoundOne(int amountOfPlayers){
    if (amountOfPlayers == 3) {
      return 17;
    } else if (amountOfPlayers == 5) {
      return 10;
    } else {
      return 13;
    }
  }

  int _getAmountRoundTwo(){
    return 26;
  }

  int _getAmountRoundThree(){
    return 13;
  }

  int _getAmountRoundFour(){
    return 4;
  }

  int _getAmountRoundFive(){
    return 2;
  }

  int _getAmountRoundSeven(){
    return 156;
  }

  int getRoundSevenPositionPoints(int amountOfPlayers, int position) {
    if (amountOfPlayers == 3) {
      return (position - 1) * 50;
    } else if (amountOfPlayers == 4) {
      return (position - 1) * 40;
    } else if (amountOfPlayers == 5) {
      return (position - 1) * 30;
    }
  }

  String getRulesDescripstionForPageSix(int round){
    if (round == 1) {
      return "Antal stik: ";
    } else if (round == 2) {
      return "Antal sorte kort: ";
    } else if (round == 3) {
      return "Antal ruder: ";
    } else if (round == 4) {
      return "Antal damer: ";
    } else if (round == 5) {
      return "Klør konge/sidste stik: ";
    }
  }

}