import 'package:davoserjas/Model.dart';
import 'package:davoserjas/startpage/Leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';

class Header extends StatelessWidget {
  final String title;
  final Color color;
  final Color fontColor;
  final bool showBackButton;

  const Header(
      {Key key, this.title, this.color, this.fontColor, this.showBackButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 105,
      width: double.infinity,
      padding: EdgeInsets.only(top: 55, bottom: 15),
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w300,
                color: fontColor,
              ),
            ),
          ),
          showBackButton
              ? Positioned(
                  top: -10,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        FeatherIcons.arrowLeftCircle,
                        color: fontColor,
                        size: 28,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
