import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:puzzle_block/game/figure_board/figure_board.dart';
import 'package:puzzle_block/game/grid/grid.dart';

class WoodPazzle extends FlameGame
    with HasDraggables, HasCollisionDetection, FPSCounter {
  @override
  bool get debugMode => true;

  @override
  Future<void>? onLoad() async {
    Grid(
      position: Vector2(0, 200),
      row: 4,
      column: 4,
      size: Vector2(400, 400),
    ).addToParent(this);
    FigureBoard().addToParent(this);

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    final fpsCount = fps(120);

    debugTextPaint.render(canvas, fpsCount.toString(), Vector2(0, 50));
    super.render(canvas);
  }
}
