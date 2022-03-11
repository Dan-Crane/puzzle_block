import 'package:flame/components.dart';
import 'package:puzzle_block/game/cell.dart';
import 'package:puzzle_block/game/grid/grid_controller.dart';

class CellRenderer extends Component {
  late final Cells cells;
  late final Vector2 sizeBounding;
  late final Vector2 cellSize;

  CellRenderer({
    required this.cells,
    required this.sizeBounding,
    Vector2? cellSize,
  }) {
    this.cellSize = cellSize ?? Vector2.all(20);
  }

  @override
  Future<void>? onLoad() {
    init();
    return super.onLoad();
  }

  void init() {
    final figureSize = Vector2(
      cells[0].length * cellSize.y,
      cells.length * cellSize.x,
    );
    Vector2 initPosition = (sizeBounding - figureSize) / 2;
    var positionOffset = initPosition;

    for (var x = 0; x < cells.length; x++) {
      for (var y = 0; y < cells[0].length; y++) {
        final cell = cells[x][y]
          ..size = cellSize
          ..position = positionOffset;

        if (cell is! CellEmpty) add(cell);

        positionOffset = Vector2(
          positionOffset.x + cellSize.x,
          positionOffset.y,
        );
      }
      positionOffset = Vector2(initPosition.x, positionOffset.y + cellSize.y);
    }
  }
}
