import 'package:davoserjas/Model.dart';
import 'package:davoserjas/rulespage/RulesPage.dart';
import 'package:davoserjas/settingspage/SettingsPage.dart';
import 'package:davoserjas/startpage/StartPage.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:davoserjas/ColorPicker.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

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

  /**
   * is called when the user taps the bottomnavigation
   */
  void bottomNavigationTapped(int index) {
    // setState(() {
    //  currentIndex = index; 
    // });
    pageController.jumpToPage(index);
  }

  Color getActiveIconColor(int index) {
    if (index == 0) {
      return colorPicker.getStartPageColor();
    } else if (index == 1) {
      return colorPicker.getRulesPageColor();
    } else if (index == 2) {
      return colorPicker.getSettingsPageColor();
    }
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPicker.getPrimary(),
      body: body(),
      bottomNavigationBar: bottomNav(),
    );
  }

  /**
   * returns the body of the outer Scaffold. Only contains a PageView with the different pages
   */
  Widget body() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: <Widget>[
        StartPage(
          model: model,
        ),
        RulesPage(
          needScaffoldAndBackButton: false,
        ),
        SettingsPage(
          model: model,
        ),
      ],
    );
  }

  Widget bottomNav() {
    return BottomNavyBar(
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
        // BottomNavyBarItem(
        //   icon: Icon(FeatherIcons.settings),
        //   title: Text('Indstillinger'),
        //   activeColor: colorPicker.getSettingsPageColor(),
        //   inactiveColor: colorPicker.getPrimaryFont(),
        // ),
      ],
    );
  }

  Widget bottomNavBar() {
    return TitledBottomNavigationBar(
      currentIndex: currentIndex,
      indicatorColor: getActiveIconColor(currentIndex),
      activeColor: getActiveIconColor(currentIndex),
      items: [
        TitledNavigationBarItem(
          title: 'Home',
          icon: FeatherIcons.plus,
        ),
        TitledNavigationBarItem(
          title: 'Regler',
          icon: FeatherIcons.bookOpen,
        ),
        TitledNavigationBarItem(
          title: 'Indstillinger',
          icon: FeatherIcons.settings,
        ),
      ],
      onTap: (index) {
        bottomNavigationTapped(index);
      },
    );
  }
}
