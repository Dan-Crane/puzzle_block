import 'package:flame/components.dart';
import 'package:puzzle_block/game/figures/cell_renderer.dart';
import 'package:puzzle_block/game/figures/figure_collision.dart';
import 'package:puzzle_block/game/figures/figure_draggable.dart';
import 'package:puzzle_block/game/figures/figure_movement.dart';
import 'package:puzzle_block/game/figures/figure_scale.dart';
import 'package:puzzle_block/game/figures/inserting_figure.dart';
import 'package:puzzle_block/game/figures/tap_area.dart';
import 'package:puzzle_block/game/grid/grid_controller.dart';
import 'package:puzzle_block/game/wood_pazzle.dart';

class FigureComponent extends PositionComponent with HasGameRef<WoodPazzle> {
  late final Cells cells;

  @override
  bool get debugMode => true;

  FigureComponent({
    Vector2? position,
    required this.cells,
  }) : super(position: position, size: Vector2.all(100), anchor: Anchor.center);

  @override
  Future<void>? onLoad() {
    final cellRenderer = CellRenderer(
      sizeBounding: size,
      cells: cells,
    )..addToParent(this);
    final tapArea = TapArea(
      position: cellRenderer.position,
      size: cellRenderer.size,
    )..addToParent(this);
    final figureDraggable = FigureDraggable(
      area: tapArea,
    )..addToParent(this);
    final figureMovement = FigureMovement(
      figureComponent: this,
      figureDraggable: figureDraggable,
    )..addToParent(this);
    final figureScale = FigureScale(
      figureDraggable: figureDraggable,
    )..addToParent(this);
    final figureCollision = FigureCollision(
      cellRenderer: cellRenderer,
    )..addToParent(this);

    InsertingFigure(
      figureMovement: figureMovement,
      figureDraggable: figureDraggable,
      figureCollision: figureCollision,
      figureScale: figureScale,
      figureComponent: this,
    ).addToParent(this);

    return super.onLoad();
  }
}
