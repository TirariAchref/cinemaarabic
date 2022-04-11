import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robinhoodtv/cubits/cubits.dart';
import 'package:robinhoodtv/data/data.dart';
import 'package:robinhoodtv/models/content_model.dart';
import 'package:robinhoodtv/models/models.dart';
import 'package:robinhoodtv/widgets/serie/content_header_serie.dart';
import 'package:robinhoodtv/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen.dart';

class InstanceScreenAnime extends StatefulWidget {
  final Anime sintelContent1;

  const InstanceScreenAnime({Key key, this.sintelContent1}) : super(key: key);
  @override
  _InstanceScreenState createState() => _InstanceScreenState(sintelContent1);
}

class _InstanceScreenState extends State<InstanceScreenAnime> {
  final Anime sintelContent1;
  ScrollController _scrollController;
  List<Object> _nbrserie;
  Map<Object, Object> map = <Object, Object>{};
  List<Object> _nbrepisode;
  List<Object> _nbrvideourl;
  int x = 0;
  @override
  void initState() {
    _nbrserie = sintelContent1.saison.keys.toList();

    map = sintelContent1.saison[_nbrserie[0]];
    _nbrepisode = map.keys.toList();
    _nbrvideourl = map.values.toList();

    print(_nbrepisode);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _InstanceScreenState(this.sintelContent1);
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          sintelContent1.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        leading: BackButton(color: Colors.grey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              Container(
                child: ContentHeaderAnime(featuredContent: sintelContent1),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        sintelContent1.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(08.0),
                    child: Container(
                      child: Text(
                        sintelContent1.description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _nbrserie.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _nbrserie[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            new Container(
                              padding: const EdgeInsets.all(5.0),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: _nbrepisode.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return new Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              _nbrepisode[index],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            _PlayButton(
                                              an: sintelContent1,
                                              UrlVideo: _nbrvideourl[index]
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      },
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final String UrlVideo;
  final Anime an;

  const _PlayButton({Key key, this.UrlVideo, this.an}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0),
      onPressed: () async {
        SharedPreferences perfs = await SharedPreferences.getInstance();
        if (Animehistorique.contains(an.name)) {
          Animehistorique.remove(an.name);
        }
        Animehistorique.add(an.name);

        perfs.setStringList('animehistory', Animehistorique);
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
