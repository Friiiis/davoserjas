import 'package:davoserjas/Model.dart';
import 'package:davoserjas/Player.dart';
import 'package:davoserjas/startpage/GameStarted.dart';
import 'package:davoserjas/startpage/StartPage.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:davoserjas/ColorPicker.dart';

/**
 * SetupGame is the page where the user chooses amount of players and player names.
 */
class SetupGamePage extends StatefulWidget {
  final Model model;

  const SetupGamePage({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  SetupGamePageState createState() => SetupGamePageState(model);
}

class SetupGamePageState extends State<SetupGamePage> {
  final Model model;

  ColorPicker colorPicker = ColorPicker();

  int playerCount = 4;
  List<String> playerNames = List(5);

  SetupGamePageState(
    this.model,
  );

  void incrementPlayerCount() {
    setState(() {
      if (playerCount < 5) {
        playerCount++;
      }
    });
  }

  void reducePlayerCount() {
    setState(() {
      if (playerCount > 3) {
        playerCount--;
        playerNames[playerCount] = null;
      }
    });
  }

  void addNameToList(int index, String name) {
    if (name == "") {
      playerNames[index] = null;
    } else {
      playerNames[index] = name;
    }
    validateInputFields();
  }

  bool validateInputFields() {
    setState(() {});
    int counter = 0;
    playerNames.forEach((s) => {
          if (s == null || s == "")
            {
              counter++,
            }
        });
    if (5 - playerCount == counter) {
      // all input fields have been filled out
      return true;
    } else {
      // one or more input field is not filled out
      return false;
    }
  }

  /**
   * If validateInputFields() returns true, startButtonTapped() returns a function, that
   * navigates the user to the game's round 1 page. IF validateInputFields() is false,
   * then startButtonTapped() returns null - this will control wether or not the "Start button"
   * is disabled or not. 
   * The function catches exceptions that is thrown by the Model, if the one or more player names
   * is the same, and then shows the error to the user with a snackbar.
   */
  startButtonTapped() {
    if (validateInputFields()) {
      return () {
        try {
          model.reset();
          int i = 0;
          playerNames.forEach((s) {
            if (s != null) {
              debugPrint(s);
              model.addPlayer(s, i);
              i++;
            }
          });
          // model.addRoundData(tempList, 0);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameStartedPage(
                currentRound: 1,
                model: model,
              ),
            ),
          );
          FocusScope.of(context).unfocus();
        } catch (e) {
          String s = e.toString().replaceAll("Exception", "Error");
          final snackBar = SnackBar(content: Text(s));
          Scaffold.of(context).showSnackBar(snackBar);
        }
      };
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 25),
          child: Text(
            'Antal spillere',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        playerCounter(),
        playerInput(context),
        startButton(),
      ],
    );
  }

  Widget playerCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          onTap: () => reducePlayerCount(),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              FeatherIcons.minus,
              color: colorPicker.getPrimaryFont(),
              size: 35,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Text(
            playerCount.toString(),
            style: TextStyle(fontSize: 45),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          onTap: () => incrementPlayerCount(),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              FeatherIcons.plus,
              color: colorPicker.getPrimaryFont(),
              size: 35,
            ),
          ),
        ),
      ],
    );
  }

  Widget playerInput(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: playerCount,
        itemBuilder: (context, i) {
          var ii = i + 1;
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: TextField(
              style: TextStyle(
                fontSize: 18,
              ),
              cursorColor: colorPicker.getStartPageColor(),
              decoration: InputDecoration(
                hintText: 'Spiller ' + ii.toString(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: colorPicker.getStartPageColor(),
                  ),
                ),
              ),
              onChanged: (s) {
                addNameToList(i, s);
              },
            ),
          );
        },
      ),
    );
  }

  Widget startButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, top: 20),
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        color: colorPicker.getStartPageColor(),
        disabledColor: colorPicker.getDisabledColor(),
        child: Text(
          'Start spillet',
          style: TextStyle(
            fontSize: 16,
            color: colorPicker.getStartPageFontColor(),
          ),
        ),
        onPressed: startButtonTapped(),
      ),
    );
  }
}
