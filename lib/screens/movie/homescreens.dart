import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robinhoodtv/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:robinhoodtv/cubits/cubits.dart';
import 'package:robinhoodtv/data/data.dart';
import 'package:robinhoodtv/widgets/widgets.dart';
import 'package:robinhoodtv/models/content_model.dart';

class HomeScreen extends StatefulWidget {
  final bool isMovie;
  const HomeScreen({Key key, this.isMovie = true}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState(isMovie);
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;
  final bool isMovie;

  _HomeScreenState(this.isMovie);

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
              scroolOffSet: scrollOffSet,
            );
          },
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent: MovieContent),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey('MovieRomance'),
                title: 'Romance',
                contentlist: Movieromance,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey('MovieComedy'),
              title: 'Comedy',
              contentList: Moviecomedy,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey('MovieAction'),
              title: 'Action',
              contentList: Movieaction,
              isOriginals: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                key: PageStorageKey('Moviescience'),
                title: 'Science Fiction',
                contentList: Moviescience,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
