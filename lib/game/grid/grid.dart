import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:puzzle_block/game/grid/grid_controller.dart';

class Grid extends PositionComponent {
  late final GridConroller gridConroller;

  @override
  bool get debugMode => true;
  @override
  Color get debugColor => Color.fromARGB(255, 26, 237, 7);

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
    for (final cell in gridConroller.cellsToRemove) {
      cell.removeFromParent();
    }
    for (final cell in gridConroller.cellsToAdd) {
      cell.changeParent(this);
      if (cell.parent != null) {
      } else {
        add(cell);
      }
    }
  }

  @override
  void onRemove() {
    gridConroller.removeListener(_updateCells);
    super.onRemove();
  }
}
