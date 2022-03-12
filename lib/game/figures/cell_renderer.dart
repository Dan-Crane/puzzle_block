import 'package:flame/components.dart';
import 'package:puzzle_block/game/cell.dart';
import 'package:puzzle_block/game/grid/grid_controller.dart';

class CellRenderer extends PositionComponent {
  late final Cells _cells;
  late final Vector2 sizeBounding;
  late final Vector2 cellSize;

  CellRenderer({
    required Cells cells,
    required this.sizeBounding,
    Vector2? cellSize,
  }) {
    _cells = cells;
    this.cellSize = cellSize ?? Vector2.all(20);
  }

  @override
  Future<void>? onLoad() {
    init();
    return super.onLoad();
  }

  void init() {
    final figureSize = Vector2(
      _cells[0].length * cellSize.y,
      _cells.length * cellSize.x,
    );
    size = figureSize;
    position = (sizeBounding - figureSize) / 2;
    var positionOffset = Vector2.zero();

    for (var x = 0; x < _cells.length; x++) {
      for (var y = 0; y < _cells[0].length; y++) {
        final cell = _cells[x][y]
          ..size = cellSize
          ..position = positionOffset;

        if (cell is! CellEmpty) add(cell);

        positionOffset = Vector2(
          positionOffset.x + cellSize.x,
          positionOffset.y,
        );
      }
      positionOffset = Vector2(0, positionOffset.y + cellSize.y);
    }
  }
}
