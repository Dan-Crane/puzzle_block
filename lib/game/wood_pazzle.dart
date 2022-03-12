import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:puzzle_block/game/figures/figures.dart';
import 'package:puzzle_block/game/figures/figure_component.dart';
import 'package:puzzle_block/game/grid/grid.dart';

class WoodPazzle extends FlameGame with HasDraggables, HasCollisionDetection {
  @override
  Future<void>? onLoad() async {
    final grid = Grid(
      position: Vector2(0, 200),
      row: 4,
      column: 4,
      size: Vector2(400, 400),
    );

    final a = FigureComponent(
      cells: figure1,
      position: Vector2(50, 100),
    );
    final a2 = FigureComponent(
      cells: figure2,
      position: Vector2(150, 100),
    );
    final a3 = FigureComponent(
      cells: figure5,
      position: Vector2(250, 100),
    );
    final a4 = FigureComponent(
      cells: figure4,
      position: Vector2(350, 100),
    );
    add(grid);
    add(a);
    add(a2);
    add(a3);
    add(a4);

    return super.onLoad();
  }
}
