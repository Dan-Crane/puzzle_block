import 'package:flame/game.dart';
import 'package:puzzle_block/game/cell.dart';
import 'package:puzzle_block/game/grid/grid.dart';

class WoodPazzle extends FlameGame {
  @override
  bool get debugMode => true;

  @override
  Future<void>? onLoad() async {
    final grid = Grid(
      position: Vector2(100, 100),
      row: 4,
      column: 4,
      size: Vector2(500, 500),
    );

    add(grid);

    final cells = [
      [
        CellMarble(
          position: Vector2(0, 0),
        ),
        CellMarble(
          position: Vector2(50, 0),
        )
      ],
      [
        CellEmpty(
          position: Vector2(0, 50),
        ),
        CellMarble(
          position: Vector2(50, 50),
        ),
      ],
    ];
    // final cells = [for (var list in generatedCells) list.toList()];

    Future.delayed(Duration(milliseconds: 500), () {
      // print(grid.children.length);
    });
    final pos = Vector2(0, 0);
    final a = grid.canInsert(pos, cells);
    if (a) {
      // print('==== can insert $a');
      Future.delayed(Duration(milliseconds: 1000), () {
        grid.insert(pos, cells);
        // print('==== insert');
      });
      Future.delayed(Duration(milliseconds: 2000), () {
        grid.check();
        // print('==== check');
      });
    }
    Future<bool>.delayed(Duration(milliseconds: 3000), () {
      final res = grid.canInsert(pos, cells);
      // print('==== can insert $res');
      return res;
    }).then((value) {
      // return;
      if (value) {
        Future.delayed(Duration(milliseconds: 4000), () {
          grid.insert(pos, cells);
          // print('==== insert');
        });
        Future.delayed(Duration(milliseconds: 5000), () {
          grid.check();
          // print('==== check');
        });
      }
    });

    return super.onLoad();
  }
}
