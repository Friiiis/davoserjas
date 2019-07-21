import 'package:davoserjas/Model.dart';
import 'package:davoserjas/rulespage/RulesPage.dart';
import 'package:davoserjas/settingspage/SettingsPage.dart';
import 'package:davoserjas/startpage/StartPage.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:davoserjas/ColorPicker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ColorPicker colorPicker = ColorPicker();
  final Model model = Model();
  PageController pageController;

  int currentIndex = 0;

  void bottomNavigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // testModel();

    return Scaffold(
      backgroundColor: colorPicker.getPrimary(),
      body: body(),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        onItemSelected: (index) {
          bottomNavigationTapped(index);
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(FeatherIcons.plus),
            title: Text('Pointtæller'),
            activeColor: colorPicker.getStartPageColor(),
            inactiveColor: colorPicker.getPrimaryFont(),
          ),
          BottomNavyBarItem(
            icon: Icon(FeatherIcons.bookOpen),
            title: Text('Regler'),
            activeColor: colorPicker.getRulesPageColor(),
            inactiveColor: colorPicker.getPrimaryFont(),
          ),
          BottomNavyBarItem(
            icon: Icon(FeatherIcons.settings),
            title: Text('Indstillinger'),
            activeColor: colorPicker.getSettingsPageColor(),
            inactiveColor: colorPicker.getPrimaryFont(),
          ),
        ],
      ),
    );
  }

  Widget body() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: <Widget>[
        StartPage(
          model: model,
        ),
        RulesPage(needScaffoldAndBackButton: false,),
        SettingsPage(
          model: model,
        ),
      ],
    );
  }
}
