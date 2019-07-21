import 'package:davoserjas/Model.dart';
import 'package:davoserjas/startpage/GameStarted.dart';
import 'package:davoserjas/startpage/SetupGame.dart';
import 'package:flutter/material.dart';
import 'package:davoserjas/ColorPicker.dart';
import 'package:davoserjas/Header.dart';

class StartPage extends StatefulWidget {
  final Model model;

  const StartPage({Key key, this.model}) : super(key: key);

  @override
  StartPageState createState() => StartPageState(model);
}

class StartPageState extends State<StartPage> with AutomaticKeepAliveClientMixin {
  final Model model;
  ColorPicker colorPicker = ColorPicker();
  PageController pageController;

  StartPageState(this.model);

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Header(
          title: "Pointtæller",
          color: colorPicker.getStartPageColor(),
          fontColor: colorPicker.getStartPageFontColor(),
          showBackButton: false,
        ),
        Expanded(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: <Widget>[
              SetupGamePage(
                model: model,
                parentPageController: pageController,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
