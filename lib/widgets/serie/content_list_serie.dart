import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:robinhoodtv/models/models.dart';
import 'package:robinhoodtv/screens/movie/instancescreen.dart';
import 'package:robinhoodtv/screens/serie/instancescreenserie.dart';

class ContentListSerie extends StatelessWidget {
  final String title;
  final List<Serie> contentList;
  final bool isOriginals;

  const ContentListSerie(
      {Key key, this.title, this.contentList, this.isOriginals = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
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
            height: isOriginals ? 500.0 : 220.0,
            child: ListView.builder(
                itemCount: contentList.length,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext, int index) {
                  final Serie content = contentList[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InstanceScreenSerie(
                                sintelContent1: content,
                              )),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: isOriginals ? 400.0 : 200.0,
                      width: isOriginals ? 200.0 : 130.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(content.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
