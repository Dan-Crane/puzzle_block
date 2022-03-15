import 'dart:math';

import 'package:flame/components.dart';
import 'package:puzzle_block/game/cell.dart';
import 'package:puzzle_block/game/figures/figure_component.dart';
import 'package:puzzle_block/game/figures/figures.dart';
import 'package:puzzle_block/game/grid/grid_controller.dart';

abstract class RemoveFigureDelegate {
  void onRemoveFigure(FigureComponent figure);
}

class CellFactory {
  BaseCell create(BaseCell cell) => cell.copyWith();
}

class FigureBoard extends PositionComponent implements RemoveFigureDelegate {
  final _cellFactory = CellFactory();
  static const _maxLengthOfFigureList = 3;
  List<FigureComponent> _listFigure = [];
  final List<Cells> cellsCollection = [
    figure0,
    figure1,
    figure2,
    figure3,
    figure4,
    figure5,
  ];

  FigureBoard({Vector2? position, Vector2? size})
      : super(
          // TODO! responsive position
          position: position ?? Vector2(50, 50),
          // TODO! responsive size
          size: size ?? Vector2(300, 100),
        );

  @override
  Future<void>? onLoad() {
    updateFigureList();

    return super.onLoad();
  }

  void updateFigureList() {
    _listFigure = _newFigureList();
    addAll(_listFigure);
  }

  @override
  void onRemoveFigure(FigureComponent figure) {
    _listFigure.remove(figure);
    remove(figure);

    if (_listFigure.isNotEmpty) return;

    updateFigureList();
  }

  List<FigureComponent> _newFigureList() {
    final random = Random();
    var positionOffset = Vector2.zero();

    return List.generate(_maxLengthOfFigureList, (index) {
      final cells = _generateCellsForFigure(
        cellsCollection[random.nextInt(cellsCollection.length)],
      );
      final figure = FigureComponent(cells: cells, removeDelegate: this);
      figure.position = positionOffset + (figure.size / 2);
      positionOffset = Vector2(positionOffset.x + figure.size.x, 0);

      return figure;
    });
  }

  Cells _generateCellsForFigure(Cells cells) {
    return List.generate(
      cells.length,
      (x) => List<BaseCell>.generate(
        cells[0].length,
        (y) => _cellFactory.create(cells[x][y]),
      ),
    );
  }
}
