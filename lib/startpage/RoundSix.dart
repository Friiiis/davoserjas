import 'package:davoserjas/Header.dart';
import 'package:davoserjas/Model.dart';
import 'package:davoserjas/Player.dart';
import 'package:davoserjas/Rules.dart';
import 'package:davoserjas/rulespage/RulesPage.dart';
import 'package:davoserjas/startpage/GameStarted.dart';
import 'package:davoserjas/startpage/Leaderboard.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:davoserjas/ColorPicker.dart';

import 'Leaderboard.dart';

class RoundSixPage extends StatefulWidget {
  final Model model;
  final int currentRound;

  const RoundSixPage({Key key, this.model, this.currentRound})
      : super(key: key);

  @override
  RoundSixPageState createState() => RoundSixPageState(model, currentRound);
}

class RoundSixPageState extends State<RoundSixPage> {
  final Model model;
  final int currentRound;

  ColorPicker colorPicker = ColorPicker();
  Rules rules = Rules();
  List<int> pointsPerTick = List<int>(6);
  List<int> amountOfTicks = List<int>(6);
  List<int> givenAmount = List<int>(6);
  List<Player> tempPlayers = List<Player>();
  List<bool> isExpandedList;

  RoundSixPageState(this.model, this.currentRound);

  void incrementPoints(Player player, int round) {
    if (givenAmount[round] < amountOfTicks[round]) {
      setState(() {
        // int currentPoints = player.getRoundPoints(round);
        player.setRoundPoint(
            round, player.getRoundPoints(round) + pointsPerTick[round]);
        givenAmount[round]++;
      });
    }
  }

  void reducePoints(Player player, int round) {
    if (givenAmount[round] > 0 && player.getRoundPoints(round) > 0) {
      setState(() {
        player.setRoundPoint(
            round, player.getRoundPoints(round) - pointsPerTick[round]);
        givenAmount[round]--;
      });
    }
  }

  bool validatePointsGiven() {
    bool validate = true;
    for (var i = 0; i < givenAmount.length; i++) {
      if (givenAmount[i] != amountOfTicks[i]) {
        validate = false;
      }
    }
    return validate;
  }

  nextRound() {
    if (validatePointsGiven()) {
      return () {
        for (Player tempPlayer in tempPlayers) {
          if (tempPlayer != null) {
            for (Player player in model.players) {
              if (tempPlayer.getName() == player.getName()) {
                player.setRoundPoint(
                    currentRound, tempPlayer.getTotalRoundPoints());
              }
            }
          }
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameStartedPage(
              currentRound: 7,
              model: model,
            ),
          ),
        );
      };
    } else {
      return null;
    }
  }

  @override
  void initState() {
    model.sortPlayersById();
    for (var i = 1; i < pointsPerTick.length; i++) {
      pointsPerTick[i] = rules.getPoints(i);
      amountOfTicks[i] = rules.getAmount(i, model.players.length);
      givenAmount[i] = 0;
    }
    for (Player player in model.players) {
      if (player != null) {
        tempPlayers.add(Player(player.getName(), player.getId()));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPicker.getPrimary(),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: content(),
          ),
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
        playersRoundSix(),
        amountGiven(),
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
            child: Icon(
              FeatherIcons.bookOpen,
              color: colorPicker.getRulesPageColor(),
              size: 28,
            ),
          ),
          Text(
            'Runde ' + currentRound.toString(),
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          InkWell(
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
            child: Icon(
              FeatherIcons.award,
              color: colorPicker.getLeaderboardColor(),
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget playersRoundSix() {
    if (isExpandedList == null) {
      isExpandedList = List<bool>(tempPlayers.length);
      for (var i = 0; i < tempPlayers.length; i++) {
        isExpandedList[i] = false;
      }
    }
    List<ExpansionPanel> list = List<ExpansionPanel>();

    int i = 0;
    tempPlayers.forEach((player) {
      var p = ExpansionPanel(
        isExpanded: isExpandedList[i],
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 35),
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 250,
                  child: Text(
                    player.getName(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  player.getTotalRoundPoints().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
        body: Column(
          children: <Widget>[
            playerTileRoundSix(player, 1),
            playerTileRoundSix(player, 2),
            playerTileRoundSix(player, 3),
            playerTileRoundSix(player, 4),
            playerTileRoundSix(player, 5),
          ],
        ),
      );
      list.add(p);
      i++;
    });

    return SafeArea(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            isExpandedList[index] = !isExpanded;
          });
        },
        children: list,
      ),
    );
  }

  Widget playerTileRoundSix(Player player, int round) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
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
              rules.getRulesDescripstionForPageSix(round),
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
                onTap: () => reducePoints(player, round),
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
                width: 25,
                alignment: Alignment(0, 0),
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  (player.getRoundPoints(round) / pointsPerTick[round])
                      .toInt()
                      .toString(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              InkWell(
                onTap: () => incrementPoints(player, round),
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
                  player.getRoundPoints(round).toString(),
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
    return Column(
      children: <Widget>[
        amountGivenTile(1),
        amountGivenTile(2),
        amountGivenTile(3),
        amountGivenTile(4),
        amountGivenTile(5),
      ],
    );
  }

  Widget amountGivenTile(int round) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            rules.getRulesDescripstionForPageSix(round),
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          Text(
            givenAmount[round].toString() +
                "/" +
                amountOfTicks[round].toString(),
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget navigationButtons() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: FlatButton(
              color: colorPicker.getStartPageColor(),
              disabledColor: colorPicker.getDisabledColor(),
              child: Text(
                'Næste runde',
                style: TextStyle(
                  fontSize: 16,
                  color: colorPicker.getStartPageFontColor(),
                ),
              ),
              onPressed: nextRound(),
            ),
          ),
        ],
      ),
    );
  }
}
