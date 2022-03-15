import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:puzzle_block/game/figure_board/figure_board.dart';
import 'package:puzzle_block/game/figures/figure_collision.dart';
import 'package:puzzle_block/game/figures/figure_component.dart';
import 'package:puzzle_block/game/figures/figure_draggable.dart';
import 'package:puzzle_block/game/figures/figure_movement.dart';
import 'package:puzzle_block/game/figures/figure_scale.dart';

class InsertingFigure extends Component {
  late final FigureMovement figureMovement;
  late final FigureDraggable figureDraggable;
  late final FigureCollision figureCollision;
  late final FigureScale figureScale;
  late final FigureComponent figureComponent;
  late final RemoveFigureDelegate removeDelegate;

  InsertingFigure({
    required this.figureMovement,
    required this.figureDraggable,
    required this.figureCollision,
    required this.figureScale,
    required this.figureComponent,
    required this.removeDelegate,
  }) {
    figureDraggable.dragEnd.add(_dragEnd);
  }

  void _dragEnd(DragEndInfo dragEndInfo) {
    final grid = figureCollision.grid;

    if (figureCollision.inBoard && grid != null) {
      final insertPosition = grid.toLocal(
        figureCollision.absolutePositionOfAnchor(Anchor.topLeft),
      );
      final insertPoint = Vector2(
        insertPosition.x / grid.gridConroller.cellSize.x,
        insertPosition.y / grid.gridConroller.cellSize.y,
      )..round();
      final canInsert = grid.gridConroller.canInsert(
        insertPoint,
        figureComponent.cells,
      );

      if (canInsert) {
        final gridController = grid.gridConroller;

        gridController.insert(insertPoint, figureComponent.cells);
        removeDelegate.onRemoveFigure(figureComponent);

        // TODO! edit check method
        Future.delayed(const Duration(milliseconds: 300), () {
          gridController.check();
        });
      } else {
        _reset();
      }
    } else {
      _reset();
    }
  }

  void _reset() {
    figureMovement.moveBack();
    figureScale.reset();
  }
}
