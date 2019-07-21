import 'package:davoserjas/Model.dart';
import 'package:flutter/material.dart';
import 'package:davoserjas/ColorPicker.dart';
import 'package:davoserjas/Header.dart';

class SettingsPage extends StatefulWidget {
  final Model model;

  const SettingsPage({Key key, this.model}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState(model);
}

class SettingsPageState extends State<SettingsPage> {
  final Model model;
  ColorPicker colorPicker = ColorPicker();

  SettingsPageState(this.model);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Header(
          title: "Indstillinger",
          color: colorPicker.getSettingsPageColor(),
          fontColor: colorPicker.getSettingsPageFontColor(),
          showBackButton: false,
        ),
      ],
    );
  }
}
