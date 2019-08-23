import 'package:davoserjas/Header.dart';
import 'package:davoserjas/Model.dart';
import 'package:davoserjas/Player.dart';
import 'package:davoserjas/Rules.dart';
import 'package:davoserjas/rulespage/RulesPage.dart';
import 'package:davoserjas/startpage/Leaderboard.dart';
import 'package:davoserjas/startpage/RoundSix.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:davoserjas/ColorPicker.dart';
import 'Leaderboard.dart';

/**
 * GameStarted contains the pages that is shown in round 1-5 and 7. 
 */
class GameStartedPage extends StatefulWidget {
  final Model model;
  final int currentRound;

  const GameStartedPage({Key key, this.model, this.currentRound})
      : super(key: key);

  @override
  GameStartedPageState createState() =>
      GameStartedPageState(model, currentRound);
}

/**
 * @param pointsPerTick: the amount of points one tick will give on a specific round.
 *  For instance, in round 2: pointsPerTick == 5, round 5: pointsPerTick == 50
 * @param amountOfTicks: how many ticks is given in a specifik round.
 *  For instance, in round 2: amountOfTicks == 26, round 5: pointsPerTick == 2
 * @param tempPlayers: temporary List of players that will be used to assign
 *  points to Model.players when the user navigates to the next round.
 * @param roundSevenDropdownValues: is only used on round 7. Contains the dropdown
 *  values (all player names) 
 */
class GameStartedPageState extends State<GameStartedPage> {
  final Model model;
  final int currentRound;

  ColorPicker colorPicker = ColorPicker();
  Rules rules = Rules();
  int pointsPerTick;
  int amountOfTicks;
  int givenAmount = 0;
  List<Player> tempPlayers = List<Player>();
  List<String> roundSevenDropdownValues;

  GameStartedPageState(this.model, this.currentRound);

  void incrementPoints(Player player) {
    if (givenAmount < amountOfTicks) {
      setState(() {
        player.addPoints(pointsPerTick);
        givenAmount++;
      });
    }
  }

  void reducePoints(Player player) {
    if (givenAmount > 0) {
      setState(() {
        if (player.removePoints(pointsPerTick)) {
          givenAmount--;
        }
      });
    }
  }

  nextRound() {
    if (validateRound()) {
      return () {
        if (currentRound == 7) {
          for (Player tempPlayer in tempPlayers) {
            tempPlayer.setRoundPoint(
                7,
                rules.getRoundSevenPositionPoints(
                    tempPlayers.length,
                    roundSevenDropdownValues.indexOf(tempPlayer.getName()) +
                        1));
          }
        }

        for (Player tempPlayer in tempPlayers) {
          if (tempPlayer != null) {
            for (Player player in model.players) {
              if (tempPlayer.getName() == player.getName()) {
                player.setRoundPoint(currentRound,
                    tempPlayer.getPoints() + tempPlayer.getRoundPoints(7));
              }
            }
          }
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            if (currentRound == 5) {
              return RoundSixPage(
                currentRound: 6,
                model: model,
              );
            } else if (currentRound == 7) {
              return Leaderboard(
                model: model,
                round: 8,
                showHomeButton: true,
              );
            } else {
              return GameStartedPage(
                currentRound: currentRound + 1,
                model: model,
              );
            }
          }),
        );
      };
    } else {
      return null;
    }
  }

  /**
   * Validates if all points has been given in a round. In the first 5 rounds,
   * this returns true, if givenAmount == amountOfTicks. In round seven a check 
   * is performed to check if all dropdowns contains different values.
   */
  bool validateRound() {
    if (currentRound < 7) {
      return givenAmount == amountOfTicks;
    } else {
      bool b = true;
      for (var first in roundSevenDropdownValues) {
        int i = 0;
        for (var second in roundSevenDropdownValues) {
          if (first == second) {
            i++;
            if (i == 2) {
              return false;
            }
          }
        }
      }
      return b;
    }
  }

  @override
  void initState() {
    model.sortPlayersById();
    pointsPerTick = rules.getPoints(currentRound);
    amountOfTicks = rules.getAmount(currentRound, model.players.length);

    for (Player player in model.players) {
      if (player != null) {
        tempPlayers.add(Player(player.getName(), player.getId()));
      }
    }

    roundSevenDropdownValues = List<String>(tempPlayers.length);
    for (var i = 0; i < roundSevenDropdownValues.length; i++) {
      roundSevenDropdownValues[i] = tempPlayers[0].getName();
      print(roundSevenDropdownValues[i]);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPicker.getPrimary(),
      body: Stack(
        children: <Widget>[
          content(),
          Header(
            color: colorPicker.getStartPageColor(),
            fontColor: colorPicker.getStartPageFontColor(),
            showBackButton: true,
            title: "Pointtæller",
          ),
        ],
      ),
    );
  }

  Widget content() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 105),
        ),
        rulesAndLeaderboard(context),
        players(),
        currentRound == 7 ? roundSevenPosition() : amountGiven(),
        navigationButtons(),
      ],
    );
  }

  Widget rulesAndLeaderboard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RulesPage(
                    needScaffoldAndBackButton: true,
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(
                FeatherIcons.bookOpen,
                color: colorPicker.getRulesPageColor(),
                size: 28,
              ),
            ),
          ),
          Text(
            'Runde ' + currentRound.toString(),
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Leaderboard(
                    model: model,
                    round: currentRound,
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(
                FeatherIcons.award,
                color: colorPicker.getLeaderboardColor(),
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget players() {
    return Flexible(
      fit: FlexFit.tight,
      child: ListView.builder(
        itemCount: tempPlayers.length,
        itemBuilder: (context, i) {
          if (tempPlayers[i] == null || tempPlayers[i].getName() == null) {
            return Container();
          } else {
            return playerTile(tempPlayers[i]);
          }
        },
      ),
    );
  }

  Widget playerTile(Player player) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black26,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 200,
            child: Text(
              player.getName(),
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                onTap: () => reducePoints(player),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    FeatherIcons.minus,
                    color: colorPicker.getPrimaryFont(),
                    size: 20,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                width: 25,
                alignment: Alignment(0, 0),
                child: Text(
                  (player.getPoints() / pointsPerTick).toInt().toString(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                onTap: () => incrementPoints(player),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    FeatherIcons.plus,
                    color: colorPicker.getPrimaryFont(),
                    size: 20,
                  ),
                ),
              ),
              Container(
                alignment: Alignment(1, 0),
                margin: EdgeInsets.only(left: 15),
                width: 35,
                child: Text(
                  player.getPoints().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget amountGiven() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Center(
        child: Text(
          "Point givet: " +
              givenAmount.toString() +
              "/" +
              amountOfTicks.toString(),
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  Widget roundSevenPosition() {
    var tiles = List<Widget>();
    int i = 1;
    for (var player in tempPlayers) {
      tiles.add(roundSevenPositionTile(i));
      i++;
    }

    return Column(
      children: tiles,
    );
  }

  Widget roundSevenPositionTile(int position) {
    List<DropdownMenuItem<String>> list = List();

    for (Player player in tempPlayers) {
      var item = DropdownMenuItem<String>(
        value: player.getName(),
        child: Text(player.getName()),
      );
      list.add(item);
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            position.toString() +
                ". plads (" +
                rules
                    .getRoundSevenPositionPoints(tempPlayers.length, position)
                    .toString() +
                " point):",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Container(
            width: 175,
            child: DropdownButton(
              items: list,
              isExpanded: true,
              value: roundSevenDropdownValues[position - 1],
              style: TextStyle(
                fontSize: 20,
                color: colorPicker.getPrimaryFont(),
              ),
              onChanged: (String name) {
                setState(() {
                  roundSevenDropdownValues[position - 1] = name;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget navigationButtons() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        color: colorPicker.getStartPageColor(),
        disabledColor: colorPicker.getDisabledColor(),
        child: Text(
          currentRound < 7 ? 'Næste runde' : 'Afslut spil',
          style: TextStyle(
            fontSize: 16,
            color: colorPicker.getStartPageFontColor(),
          ),
        ),
        onPressed: nextRound(),
      ),
    );
  }
}
