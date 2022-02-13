import 'package:flame/game.dart';
import 'package:puzzle_block/game/cell.dart';

typedef CellBuilder = BaseCell Function(Vector2, Vector2);

class GridGenerator {
  static Iterable<Iterable<BaseCell>> generateCells({
    required int row,
    required int column,
    required Vector2 cellSize,
    CellBuilder builder = emptyCellBuilder,
  }) sync* {
    var rowOffset = Vector2.zero();

    for (var i = 0; i < row; i++) {
      yield Iterable.generate(
        row,
        (index) {
          final position = Vector2(cellSize.x * index, rowOffset.y);
          return builder(position, cellSize);
        },
      );

      rowOffset.add(Vector2(0, cellSize.y));
    }
  }

  static BaseCell emptyCellBuilder(Vector2 position, Vector2 size) {
    return CellEmpty(position: position, size: size);
  }

  static BaseCell marbleCellBuilder(Vector2 position, Vector2 size) {
    return CellMarble(position: position, size: size);
  }
}
