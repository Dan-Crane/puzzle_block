import 'package:flame/components.dart';
import 'package:puzzle_block/game/cell.dart';
import 'package:puzzle_block/game/grid/grid_controller.dart';

class Grid extends PositionComponent {
  late final GridConroller gridConroller;

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
    );
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    gridConroller.addListener(_updateCells);
    // TODO! after first insert gridConroller.cellsToAdd is not empty
    _updateCells();
  }

  bool canInsert(Vector2 position, List<List<BaseCell>> figure) {
    return gridConroller.canInsert(position, figure);
  }

  void insert(Vector2 position, List<List<BaseCell>> figure) {
    gridConroller.insert(position, figure);
  }

  void check() {
    gridConroller.check();
  }

  void _updateCells() {
    for (final cell in gridConroller.cellsToRemove) {
      cell.removeFromParent();
    }
    for (final cell in gridConroller.cellsToAdd) {
      add(cell);
    }
  }

  @override
  void onRemove() {
    gridConroller.removeListener(_updateCells);
    super.onRemove();
  }
}
