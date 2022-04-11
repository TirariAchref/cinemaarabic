import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robinhoodtv/models/models.dart';
import 'package:robinhoodtv/screens/movie/instancescreen.dart';
import 'package:robinhoodtv/screens/screen.dart';
import 'package:robinhoodtv/screens/serie/instancescreenserie.dart';

class PreviewsAnime extends StatelessWidget {
  final String title;
  final List<Anime> contentlist;

  const PreviewsAnime({Key key, this.title, this.contentlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 165.0,
          child: ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final Anime content = contentlist[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InstanceScreenAnime(
                            sintelContent1: content,
                          )),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      height: 130.0,
                      width: 130.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(content.imageUrl),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: content.color, width: 4.0),
                      ),
                    ),
                    Container(
                      height: 130.0,
                      width: 130.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.black87,
                            Colors.black45,
                            Colors.transparent
                          ],
                          stops: [0, 0.25, 1],
                          begin: Alignment(0.0, 1.0),
                          end: Alignment(0.0, -1.0),
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: content.color, width: 4.0),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: SizedBox(
                          height: 60.0,
                          child: Image.network(content.titleImageUrl),
                        ))
                  ],
                ),
              );
            },
            itemCount: contentlist.length,
          ),
        )
      ],
    );
  }
}
