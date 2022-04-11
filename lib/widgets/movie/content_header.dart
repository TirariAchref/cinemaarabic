import 'package:flutter/material.dart';
import 'package:robinhoodtv/data/data.dart';
import 'package:robinhoodtv/models/models.dart';
import 'package:robinhoodtv/screens/screen.dart';
import 'package:robinhoodtv/widgets/movie/vertical_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({Key key, this.featuredContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(featuredContent.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 550.0,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
        ),
        Positioned(
          bottom: 110,
          child: SizedBox(
            width: 250.0,
            child: Image.network(featuredContent.titleImageUrl),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _PlayButton(
                con: featuredContent,
                UrlVideo: featuredContent.videoUrl,
              ),
              VerticalIconButton(
                icon: Icons.info_outline,
                title: 'info',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InstanceScreen(
                            sintelContent1: featuredContent,
                          )),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _PlayButton extends StatelessWidget {
  final String UrlVideo;
  final Content con;
  const _PlayButton({Key key, this.UrlVideo, this.con}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0),
      onPressed: () async {
        SharedPreferences perfs = await SharedPreferences.getInstance();
        if (Moviehistorique.contains(con.name)) {
          Moviehistorique.remove(con.name);
        }
        Moviehistorique.add(con.name);

        perfs.setStringList('moviehistory', Moviehistorique);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VideoPlayer(
                    URL: UrlVideo,
                  )),
        );
      },
      color: Colors.white,
      icon: const Icon(
        Icons.play_arrow,
        size: 30.0,
      ),
      label: const Text(
        'Play',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
