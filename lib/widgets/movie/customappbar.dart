import 'package:flutter/material.dart';
import 'package:robinhoodtv/assets.dart';
import 'package:robinhoodtv/screens/movie/homescreens.dart';
import 'package:robinhoodtv/screens/nav_screen.dart';
import 'package:robinhoodtv/screens/serie/homescreenserie.dart';

class CustomAppBar extends StatelessWidget {
  final double scroolOffSet;

  const CustomAppBar({Key key, this.scroolOffSet = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
      color:
          Colors.black.withOpacity((scroolOffSet / 350).clamp(0, 1).toDouble()),
      child: SafeArea(
        child: Row(
          children: [
            Image.asset(Assets.netflixLogo0),
            const SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _AppBarButton(
                    Title: 'Anime',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavScreen(
                                cureentIndex: 6,
                              )),
                    ),
                  ),
                  _AppBarButton(
                    Title: 'Movies',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavScreen(
                                cureentIndex: 0,
                              )),
                    ),
                  ),
                  _AppBarButton(
                    Title: 'Series',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavScreen(
                                cureentIndex: 5,
                              )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String Title;
  final Function onTap;

  const _AppBarButton({Key key, this.Title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        Title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
