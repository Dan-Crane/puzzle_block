import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:puzzle_block/game/cell.dart';
import 'package:puzzle_block/game/figures/figure.dart';
import 'package:puzzle_block/game/grid/grid.dart';

class WoodPazzle extends FlameGame with HasDraggables {
  // @override
  // bool get debugMode => true;

  @override
  Future<void>? onLoad() async {
    final grid = Grid(
      position: Vector2(100, 100),
      row: 4,
      column: 4,
      size: Vector2(500, 500),
    );

    // add(grid);

    final f1 = Figure(
      gridFigure: figure1,
      position: Vector2(100, 100),
      size: Vector2(100, 100),
    );
    final f2 = Figure(
      gridFigure: figure2,
      position: Vector2(200, 100),
      size: Vector2(100, 100),
    );
    final f3 = Figure(
      gridFigure: figure3,
      position: Vector2(300, 100),
      size: Vector2(100, 100),
    );
    add(f1);
    print('=== f1 ${f1.priority}');
    add(f2);
    print('=== f2 ${f2.priority}');

    add(f3);
    print('=== f3 ${f3.priority}');
    // print('==== figure position ${f.position}');
    // print(positionType);
    // final cells = [
    //   [
    //     CellMarble(
    //       position: Vector2(0, 0),
    //     ),
    //     CellMarble(
    //       position: Vector2(50, 0),
    //     )
    //   ],
    //   [
    //     CellEmpty(
    //       position: Vector2(0, 50),
    //     ),
    //     CellMarble(
    //       position: Vector2(50, 50),
    //     ),
    //   ],
    // ];
    // // final cells = [for (var list in generatedCells) list.toList()];

    // Future.delayed(Duration(milliseconds: 500), () {
    //   // print(grid.children.length);
    // });
    // final pos = Vector2(0, 0);
    // final a = grid.canInsert(pos, cells);
    // if (a) {
    //   // print('==== can insert $a');
    //   Future.delayed(Duration(milliseconds: 1000), () {
    //     grid.insert(pos, cells);
    //     // print('==== insert');
    //   });
    //   Future.delayed(Duration(milliseconds: 2000), () {
    //     grid.check();
    //     // print('==== check');
    //   });
    // }
    // Future<bool>.delayed(Duration(milliseconds: 3000), () {
    //   final res = grid.canInsert(pos, cells);
    //   // print('==== can insert $res');
    //   return res;
    // }).then((value) {
    //   // return;
    //   if (value) {
    //     Future.delayed(Duration(milliseconds: 4000), () {
    //       grid.insert(pos, cells);
    //       // print('==== insert');
    //     });
    //     Future.delayed(Duration(milliseconds: 5000), () {
    //       grid.check();
    //       // print('==== check');
    //     });
    //   }
    // });

    return super.onLoad();
  }
}
