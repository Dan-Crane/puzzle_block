import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:puzzle_block/game/wood_pazzle.dart';

void main() {
  final woodPazzle = WoodPazzle();

  runApp(
    GameWidget(game: woodPazzle),
  );
}
