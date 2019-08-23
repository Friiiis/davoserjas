import 'package:davoserjas/ColorPicker.dart';
import 'package:davoserjas/Header.dart';
import 'package:davoserjas/Model.dart';
import 'package:davoserjas/Player.dart';
import 'package:flutter/material.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';

class Leaderboard extends StatelessWidget {
  final Model model;
  final int round;
  bool showHomeButton;
  List<Player> leaderboard;
  ColorPicker colorPicker = ColorPicker();
  int additionalFirstPlaces;

  Leaderboard({Key key, this.model, this.round, this.showHomeButton})
      : super(key: key);

  void getLeaderboard() {
    leaderboard = model.getLeaderboardAtRound(round);
    if (round != 1) {
      leaderboard.sort((a, b) => a.getPoints().compareTo(b.getPoints()));
    }
  }

  //checks if more than one person is first place
  int numberOfAdditionalFirstPlaces() {
    int firstPlaces = 0;
    for (var i = 1; i < leaderboard.length; i++) {
      if (leaderboard[i].getPoints() == leaderboard[i - 1].getPoints()) {
        firstPlaces++;
      } else {
        break;
      }
    }
    return firstPlaces;
  }

  @override
  Widget build(BuildContext context) {
    if (showHomeButton == null) {
      showHomeButton = false;
    }

    getLeaderboard();
    additionalFirstPlaces = numberOfAdditionalFirstPlaces();

    return Scaffold(
      backgroundColor: colorPicker.getPrimary(),
      body: Column(
        children: <Widget>[
          Header(
            title: "Pointtavle",
            color: colorPicker.getLeaderboardColor(),
            fontColor: colorPicker.getLeaderboardFontColor(),
            showBackButton: true,
          ),
          players(),
          showHomeButton ? homeButton(context) : Container(),
        ],
      ),
    );
  }

  Widget players() {
    return Flexible(
      child: ListView.builder(
        itemCount: leaderboard.length,
        itemBuilder: (context, i) {
          if (leaderboard[i].getName() == null) {
            return Container();
          } else {
            return playerTile(leaderboard[i], i);
          }
        },
      ),
    );
  }

  Widget playerTile(Player player, int position) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
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
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  FeatherIcons.award,
                  color: getColor(position),
                  size: 28,
                ),
              ),
              Container(
                width: 225,
                child: Text(
                  player.getName(),
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              player.getPoints().toString(),
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(int position) {
    if (position <= additionalFirstPlaces) {
      return colorPicker.getLeaderboardColor();
    } else {
      return colorPicker.getPrimary();
    }
  }

  Widget homeButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        color: colorPicker.getStartPageColor(),
        disabledColor: colorPicker.getDisabledColor(),
        child: Text(
          "Tilbage til start",
          style: TextStyle(
            fontSize: 16,
            color: colorPicker.getStartPageFontColor(),
          ),
        ),
        onPressed: () {
          for (var i = 0; i < 8; i++) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
