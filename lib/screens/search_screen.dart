import 'package:flutter/material.dart';
import 'package:robinhoodtv/data/data.dart';
import 'package:robinhoodtv/models/models.dart';
import 'package:robinhoodtv/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  ScrollController _scrollController;
  List<Content> allmovie =
      Movieaction + Moviecomedy + Movieromance + Moviescience;
  List<Serie> allserie =
      Serieaction + Seriecomedy + Serieromance + Seriescience;
  List<Anime> allanime =
      Animeaction + Animecomedy + Animeromance + Animescience;
  List<Content> movie;
  List<Serie> serie;
  List<Anime> anime;
  @override
  void initState() {
    movie = allmovie;
    serie = allserie;
    anime = allanime;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: buildsearch(),
          ),
          SliverToBoxAdapter(
            child: movie.isEmpty
                ? null
                : ContentList(
                    key: PageStorageKey('Movie'),
                    title: 'Movie',
                    contentList: movie,
                  ),
          ),
          SliverToBoxAdapter(
            child: serie.isEmpty
                ? null
                : ContentListSerie(
                    key: PageStorageKey('serie'),
                    title: 'Serie',
                    contentList: serie,
                  ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: anime.isEmpty
                  ? null
                  : ContentListAnime(
                      key: PageStorageKey('anime'),
                      title: 'Anime',
                      contentList: anime,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildsearch() => SearchWidget(
        text: query,
        hintText: 'Title',
        onChanged: searchTitle,
      );
  void searchTitle(String query) {
    final movie = allmovie.where((element) {
      final titlelower = element.name.toLowerCase();
      final searchlower = query.toLowerCase();
      return titlelower.contains(searchlower);
    }).toList();
    final serie = allserie.where((element) {
      final titlelower = element.name.toLowerCase();
      final searchlower = query.toLowerCase();
      return titlelower.contains(searchlower);
    }).toList();
    final anime = allanime.where((element) {
      final titlelower = element.name.toLowerCase();
      final searchlower = query.toLowerCase();
      return titlelower.contains(searchlower);
    }).toList();
    setState(() {
      this.query = query;
      this.movie = movie;
      this.anime = anime;
      this.serie = serie;
    });
  }
}
