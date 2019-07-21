import 'package:davoserjas/Model.dart';
import 'package:flutter/material.dart';
import 'package:davoserjas/ColorPicker.dart';
import 'package:davoserjas/Header.dart';

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
              paragraph("Generelle regler", "Lorem ipsum"),
              paragraph("Runde 1: ingen stik", "5 point per stik."),
              paragraph("Runde 2: ingen sorte kort", "5 point per sort kort."),
              paragraph("Runde 3: ingen ruder", "10 point per ruder."),
              paragraph("Runde 4: ingen damer", "25 point per dame."),
              paragraph("Runde 5: ingen klør konge og sidste stik",
                  "50 point for klør konge og det sidste stik i runden."),
              paragraph("Runde 6: alle tidligere runder",
                  "Alle ovenstående runder kombineret."),
              paragraph(
                  "Runde 7: kabalen", 'Hver gang en spiller melder "pas" tildeles spilleren 5 point. \nSpilleren der først har smidt alle sine kort får 0 point. Ved tre spillere er forskellen mellem slutpositionerne 50 point, ved fire spillere er forskellen 40 og ved fem spillere er forskellen 30.'),
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
