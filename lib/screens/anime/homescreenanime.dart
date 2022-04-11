import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robinhoodtv/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:robinhoodtv/cubits/cubits.dart';
import 'package:robinhoodtv/cubits/cubits.dart';
import 'package:robinhoodtv/data/data.dart';
import 'package:robinhoodtv/widgets/serie/content_header_serie.dart';
import 'package:robinhoodtv/widgets/serie/content_list_serie.dart';
import 'package:robinhoodtv/widgets/serie/previews_serie.dart';
import 'package:robinhoodtv/widgets/widgets.dart';
import 'package:robinhoodtv/models/content_model.dart';

class HomeScreenAnime extends StatefulWidget {
  const HomeScreenAnime({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenAnime> {
  ScrollController _scrollController;
  double _scrolloffset = 0.0;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.bloc<AppBarCubit>().setOffSet(_scrollController.offset);
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffSet) {
            return CustomAppBar(
              key: PageStorageKey('animehomescreen'),
              scroolOffSet: scrollOffSet,
            );
          },
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeaderAnime(featuredContent: AnimeContent),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: PreviewsAnime(
                key: PageStorageKey('AnimeRomance'),
                title: 'Romance',
                contentlist: Animeromance,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentListAnime(
              key: PageStorageKey('AnimeComedy'),
              title: 'Comedy',
              contentList: Animecomedy,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentListAnime(
              key: PageStorageKey('AnimeAction'),
              title: 'Action',
              contentList: Animeaction,
              isOriginals: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentListAnime(
                key: PageStorageKey('Animescience'),
                title: 'Science Fiction',
                contentList: Animescience,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
