import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:puzzle_block/game/grid/grid_controller.dart';

class Grid extends PositionComponent {
  late final GridConroller gridConroller;

  @override
  bool get debugMode => true;
  @override
  Color get debugColor => const Color.fromARGB(255, 26, 237, 7);

  Grid({
    int? row,
    int? column,
    required Vector2 position,
    Vector2? size,
  }) : super(position: position, size: size) {
    gridConroller = GridConroller(
      row: row,
      column: column,
      gridSize: size,
    )..addListener(_updateCells);
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    gridConroller.init();
    add(RectangleHitbox());
  }

  void _updateCells() {
    gridConroller.cellsToRemove.forEach(remove);
    gridConroller.cellsToAdd.forEach(add);
  }

  @override
  void onRemove() {
    gridConroller.removeListener(_updateCells);
    super.onRemove();
  }
}
