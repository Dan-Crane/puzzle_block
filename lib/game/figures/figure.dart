import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:puzzle_block/game/cell.dart';
import 'package:puzzle_block/game/grid/grid_controller.dart';

class Figure extends PositionComponent with Draggable {
  // @override
  // bool get debugMode => true;
  @override
  Color get debugColor => Color.fromARGB(255, 21, 27, 192);
  final Cells gridFigure;
  late final Vector2 cellSize;

  Figure({
    Vector2? position,
    required this.gridFigure,
    Vector2? cellSize,
    Vector2? size,
  }) : super(
          position: position,
          size: size,
        ) {
    this.cellSize = cellSize ?? Vector2(20, 20);
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    _init();
  }

  @override
  bool onDragStart(int pointerId, DragStartInfo info) {
    return true;
  }

  @override
  bool onDragEnd(int pointerId, DragEndInfo info) {
    removeFromParent();
    return true;
  }

  @override
  bool onDragCancel(int pointerId) {
    return true;
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    position = position + info.delta.game;
    return false;
  }

  void _init() async {
    final a = toLocal(center);

    final width = gridFigure[0].length * cellSize.y / 2;
    final height = gridFigure.length * cellSize.x / 2;

    print('==== width $width');
    print('==== heigth $height');
    var positionOffset = Vector2(a.x - width, a.y - height);

    for (var x = 0; x < gridFigure.length; x++) {
      for (var y = 0; y < gridFigure[0].length; y++) {
        final cell = gridFigure[x][y]
          ..size = cellSize
          ..position = positionOffset;

        if (cell is! CellEmpty) add(cell);

        positionOffset = Vector2(
          positionOffset.x + cellSize.x,
          positionOffset.y,
        );
      }
      positionOffset = Vector2(a.x - width, positionOffset.y + cellSize.y);
    }
  }
}

/*
      +
    + +
*/
final figure1 = [
  [CellEmpty(), CellMarble()],
  [CellMarble(), CellMarble()],
];
/* 
    + + + +
*/
final figure2 = [
  [CellMarble(), CellMarble(), CellMarble(), CellMarble()],
];

/* 
    + + + 
        +
        +
*/
final figure3 = [
  [CellMarble(), CellMarble(), CellMarble(), CellMarble()],
  [CellEmpty(), CellEmpty(), CellEmpty(), CellMarble()],
  [CellEmpty(), CellEmpty(), CellEmpty(), CellMarble()],
  [CellEmpty(), CellEmpty(), CellEmpty(), CellMarble()],
];
