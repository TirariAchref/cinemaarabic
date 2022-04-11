import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Serie {
  final String name;
  final String imageUrl;
  final String titleImageUrl;
  final LinkedHashMap<Object, Object> saison;
  final String description;
  final Color color;
  final String categorie;

  const Serie({
    this.name,
    this.imageUrl,
    this.titleImageUrl,
    this.saison,
    this.description,
    this.color,
    this.categorie,
  });
}
