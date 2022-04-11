import 'package:flutter/material.dart';
import 'package:robinhoodtv/data/data.dart';
import 'package:robinhoodtv/models/models.dart';
import 'package:robinhoodtv/widgets/widgets.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key key}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<HistoryScreen> {
  ScrollController _scrollController;
  List<Content> allmovie = [];
  List<Serie> allserie = [];
  List<Anime> allanime = [];
  List<Content> Rallmovie = [];
  List<Serie> Rallserie = [];
  List<Anime> Rallanime = [];

  @override
  void initState() {
    _loadmovie();
    _loadserie();
    _loadanime();
    Rallmovie = allmovie.reversed.toList();
    Rallserie = allserie.reversed.toList();
    Rallanime = allanime.reversed.toList();

    super.initState();
  }

  void _loadmovie() {
    for (var a in Moviehistorique) {
      for (var x in Movies) {
        if (x.name == a) {
          allmovie.add(x);
        }
      }
    }
  }

  void _loadserie() {
    for (var a in Seriehistorique) {
      for (var x in Series) {
        if (x.name == a) {
          allserie.add(x);
        }
      }
    }
  }

  void _loadanime() {
    for (var a in Animehistorique) {
      for (var x in Animes) {
        if (x.name == a) {
          allanime.add(x);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPadding(padding: const EdgeInsets.only(top: 50.0)),
          SliverToBoxAdapter(
            child: Rallmovie.isEmpty
                ? null
                : ContentList(
                    key: PageStorageKey('Movie'),
                    title: 'Movie',
                    contentList: Rallmovie,
                  ),
          ),
          SliverToBoxAdapter(
            child: Rallserie.isEmpty
                ? null
                : ContentListSerie(
                    key: PageStorageKey('serie'),
                    title: 'Serie',
                    contentList: Rallserie,
                  ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: Rallanime.isEmpty
                  ? null
                  : ContentListAnime(
                      key: PageStorageKey('anime'),
                      title: 'Anime',
                      contentList: Rallanime,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
