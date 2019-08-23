import 'package:davoserjas/Model.dart';
import 'package:flutter/material.dart';
import 'package:davoserjas/ColorPicker.dart';
import 'package:davoserjas/Header.dart';

/**
 * Page for displaying the rules of the game
 * RulesPage is displayed in two different places in the app: on the mainpage's PageView,
 * and when the game is on, and the user clicks the rules button. If the RulesPage is opened
 * from an ongoing game, then the backbutton needs to be visible. This is toggled by the 
 * param "needScaffoldAndBackButton".
 */
class RulesPage extends StatelessWidget {
  ColorPicker colorPicker = ColorPicker();

  final bool needScaffoldAndBackButton;

  RulesPage({Key key, this.needScaffoldAndBackButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (needScaffoldAndBackButton) {
      return Scaffold(
        backgroundColor: colorPicker.getPrimary(),
        body: mainBuild(),
      );
    } else {
      return mainBuild();
    }
  }

  Widget mainBuild() {
    return Column(
      children: <Widget>[
        Header(
          title: "Regler",
          color: colorPicker.getRulesPageColor(),
          fontColor: colorPicker.getRulesPageFontColor(),
          showBackButton: needScaffoldAndBackButton,
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              paragraph(
                  "Generelle regler",
                  "Følgende regler er blot én version af Davoserjas blandt mange. Det er disse regler der bruges til pointtælling i denne app." +
                      "\n\nSpillet går ud på at få så få point som muligt. Spillet er opdelt i 7 runder. De første seks runder spilles som normale kortspil, hvor hvert stik gives til spilleren, som har lagt det højeste kort. Man skal altid bekende kulør. Kongen er højst og esser er lavest. Hver runde har forskellige måder at tildele strafpoint på. De kan ses nedenfor." +
                      "\n\nRunde 7 spilles som en kabale. Det første kort der må lægges på bordet er 7'ere. Derefter kan man bygge videre på kabalen, ved at lægge enten en 8'er i samme kulør over 7'eren eller en 6'er i samme kulør under 7'eren. Herefter fortsætter kabalen fra 8'eren op til kongen, og fra 6'eren ned til esset. Hvis man ikke har mulighed for at bygge videre på kabalen, melder man pas, hvilket giver strafpoint" +
                      "\nDen spiller der bliver først færdig får 0 point. Pointene stiger jo dårligere position man får."),
              paragraph("Runde 1: ingen stik", "5 point per stik."),
              paragraph("Runde 2: ingen sorte kort", "5 point per sort kort."),
              paragraph("Runde 3: ingen ruder", "10 point per ruder."),
              paragraph("Runde 4: ingen damer", "25 point per dame."),
              paragraph("Runde 5: ingen klør konge og sidste stik",
                  "50 point for klør konge og det sidste stik i runden."),
              paragraph("Runde 6: alle tidligere runder",
                  "Alle ovenstående runder kombineret."),
              paragraph("Runde 7: kabalen",
                  'Hver gang en spiller melder "pas" tildeles spilleren 5 point. \nSpilleren der først har smidt alle sine kort får 0 point. Ved tre spillere er forskellen mellem slutpositionerne 50 point, ved fire spillere er forskellen 40 og ved fem spillere er forskellen 30.'),
            ],
          ),
        ),
      ],
    );
  }

  Widget paragraph(String title, String body) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 5),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              body,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
