import 'package:flutter/material.dart';
import 'package:robinhoodtv/models/models.dart';
import 'package:robinhoodtv/screens/screen.dart';
import 'package:robinhoodtv/screens/serie/instancescreenserie.dart';
import 'package:robinhoodtv/widgets/movie/vertical_icon_button.dart';

class ContentHeaderAnime extends StatelessWidget {
  final Anime featuredContent;

  const ContentHeaderAnime({Key key, this.featuredContent}) : super(key: key);

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
              FlatButton.icon(
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
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InstanceScreenAnime(
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

  const _PlayButton({Key key, this.UrlVideo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoPlayer(
                  URL: UrlVideo,
                )),
      ),
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
