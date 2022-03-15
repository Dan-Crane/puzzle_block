import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:puzzle_block/game/figures/cell_renderer.dart';
import 'package:puzzle_block/game/grid/grid.dart';

class FigureCollision extends PositionComponent with CollisionCallbacks {
  Grid? _grid;

  bool get inBoard => _grid != null;
  Grid? get grid => _grid;

  @override
  bool get debugMode => true;
  @override
  Color get debugColor => const Color.fromARGB(255, 85, 255, 0);

  FigureCollision({required CellRenderer cellRenderer}) {
    size = cellRenderer.size;
    position = cellRenderer.position;
  }

  @override
  Future<void>? onLoad() {
    add(RectangleHitbox()..collisionType = CollisionType.passive);

    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is! Grid) return;

    _grid = other;

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is! Grid) return;

    if (!_isInBoard(other)) _grid = null;

    super.onCollisionEnd(other);
  }

  bool _isInBoard(Grid grid) {
    final offset = absolutePosition.toOffset();
    final boardPositionRect = grid.position.toPositionedRect(grid.size);

    return boardPositionRect.contains(offset);
  }
}
