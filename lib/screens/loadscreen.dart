import 'dart:async';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:robinhoodtv/data/data.dart';
import 'package:robinhoodtv/models/models.dart';
import 'package:robinhoodtv/screens/screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplachScreen(),
    );
  }
}

class SplachScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SplachScreen> {
  final _database = FirebaseDatabase.instance.reference();

  StreamSubscription _dailySpecial;

  @override
  void initState() {
    _pushdata();
    _activateListenerMovie();
    _activateListenerSerie();
    _activateListenerAnime();

    Timer(Duration(seconds: 5), () {
      if (Moviecomedy.isNotEmpty) {
        _loadall();
        _loadhistory();

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NavScreen(
                    cureentIndex: 0,
                  )),
        );
      } else {}
    });
  }

  @override
  void dispose() {
    _dailySpecial.cancel();

    super.dispose();
  }

  void _loadall() {
    Movies = Movieaction + Moviecomedy + Movieromance + Moviescience;
    Series = Serieaction + Seriecomedy + Seriescience + Serieromance;
    Animes = Animeaction + Animecomedy + Animeromance + Animescience;
  }

  Future<void> _loadhistory() async {
    final prefs = await SharedPreferences.getInstance();

    Moviehistorique = prefs.getStringList('moviehistory');
    Seriehistorique = prefs.getStringList('seriehistory');
    Animehistorique = prefs.getStringList('animehistory');
    if (Moviehistorique == null) {
      Moviehistorique = [];
    }
    if (Seriehistorique == null) {
      Seriehistorique = [];
    }
    if (Animehistorique == null) {
      Animehistorique = [];
    }
  }

  void _pushdata() {
    final Listt = <Object, Object>{
      'equipe1': 'EST',
      'equipe2': 'CA',
      'imageequipe1':
          'https://upload.wikimedia.org/wikipedia/fr/6/6b/EST_New_Logo_2012.png',
      'imageequipe2':
          'https://upload.wikimedia.org/wikipedia/fr/thumb/3/33/Logo_Club_africain.svg/1200px-Logo_Club_africain.svg.png',
      'time': '13:00',
      'server': ['a', 'jf', 'zf'],
    };
    _database
        .child('event')
        .push()
        .set(Listt)
        .then((_) => print('done'))
        .catchError((e) => print(e));
  }

  void _activateListenerMovie() {
    final _descriptionRef = _database.child("movies");
    _descriptionRef.once().then((DataSnapshot snapshot) {
      snapshot.value.forEach((key, values) {
        final LinkedHashMap<Object, Object> map = values;
        final cont = Content(
          name: map['name'].toString(),
          imageUrl: map['imageUrl'].toString(),
          titleImageUrl: map['titleImageUrl'].toString(),
          videoUrl: map['videoUrl'].toString(),
          description: map['description'].toString(),
          color: Colors.redAccent,
          categorie: map['categorie'].toString(),
        );

        if (map['categorie'].toString() == 'romance') {
          Movieromance.add(cont);
        } else if (map['categorie'].toString() == 'comedy') {
          Moviecomedy.add(cont);
        } else if (map['categorie'].toString() == 'action') {
          Movieaction.add(cont);
        } else if (map['categorie'].toString() == 'science') {
          Moviescience.add(cont);
        }

        MovieContent = cont;
      });
    });
  }

  _activateListenerSerie() {
    final _descriptionRef = _database.child("series");
    _descriptionRef.once().then((DataSnapshot snapshot) {
      snapshot.value.forEach((key, values) {
        final LinkedHashMap<Object, Object> map = values;
        final ser = Serie(
          name: map['name'].toString(),
          imageUrl: map['imageUrl'].toString(),
          titleImageUrl: map['titleImageUrl'].toString(),
          saison: map['saison'],
          description: map['description'].toString(),
          color: Colors.redAccent,
          categorie: map['categorie'].toString(),
        );
        if (map['categorie'].toString() == 'romance') {
          Serieromance.add(ser);
        } else if (map['categorie'].toString() == 'comedy') {
          Seriecomedy.add(ser);
        } else if (map['categorie'].toString() == 'action') {
          Serieaction.add(ser);
        } else if (map['categorie'].toString() == 'science') {
          Seriescience.add(ser);
        }
        SerieContent = ser;
      });
    });
  }

  _activateListenerAnime() {
    final _descriptionRef = _database.child("anime");
    _descriptionRef.once().then((DataSnapshot snapshot) {
      snapshot.value.forEach((key, values) {
        final LinkedHashMap<Object, Object> map = values;
        final ser = Anime(
          name: map['name'].toString(),
          imageUrl: map['imageUrl'].toString(),
          titleImageUrl: map['titleImageUrl'].toString(),
          saison: map['saison'],
          description: map['description'].toString(),
          color: Colors.redAccent,
          categorie: map['categorie'].toString(),
        );
        if (map['categorie'].toString() == 'romance') {
          Animeromance.add(ser);
        } else if (map['categorie'].toString() == 'comedy') {
          Animecomedy.add(ser);
        } else if (map['categorie'].toString() == 'action') {
          Animeaction.add(ser);
        } else if (map['categorie'].toString() == 'science') {
          Animescience.add(ser);
        }
        AnimeContent = ser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/netflix_logo0.png',
              height: 120,
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
