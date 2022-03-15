import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:puzzle_block/game/cell.dart';
import 'package:puzzle_block/game/grid/grid_generator.dart';

typedef Cells = List<List<BaseCell>>;

class GridConroller extends ChangeNotifier {
  /// Cell matrix
  late final Cells grid;

  /// Reference to the cell that is stored in the [grid]
  final List<BaseCell> cellsToAdd = [];

  /// Reference to the cell that is stored in the [grid]
  final List<BaseCell> cellsToRemove = [];

  late final int _column;
  late final int _row;
  late final Vector2 _cellCize;
  late final CellBuilder _cellBuilder;

  Vector2 get cellSize => _cellCize;

  GridConroller({
    int? column,
    int? row,
    Vector2? gridSize,
    CellBuilder cellBuilder = GridGenerator.emptyCellBuilder,
  }) {
    _column = column ?? 4;
    _row = row ?? 4;
    _cellCize = gridSize != null
        ? Vector2(gridSize.x / _column, gridSize.y / _row)
        : Vector2.zero();
    _cellBuilder = cellBuilder;
  }

  /// [position] must fall within size of the [grid].
  bool canInsert(Vector2 position, List<List<BaseCell>> figure) {
    var result = false;

    // Position is out of bounds
    if (position.y > _row ||
        position.x > _column ||
        position.y < 0 ||
        position.x < 0) return result;
    // The figure is out of bounds of the matrix
    if ((position.y + figure.length) > _row ||
        (position.x + figure[0].length) > _column) return result;

    var rootCurrentRow = position.y.toInt();
    var rootCurrentColumn = position.x.toInt();

    result = true;

    for (var i = 0; i < figure.length; i++) {
      for (var k = 0; k < figure[0].length; k++) {
        final cellInFigure = figure[i][k];
        final cellInRoot = grid[rootCurrentRow][rootCurrentColumn];

        final isFigureCellEmpty = cellInFigure is CellEmpty;
        final isRootCellEmpty = cellInRoot is CellEmpty;
        if (!isFigureCellEmpty && !isRootCellEmpty) {
          result = false;
          break;
        }

        rootCurrentColumn++;
      }
      if (!result) break;

      rootCurrentColumn = position.x.toInt();
      rootCurrentRow++;
    }

    return result;
  }

  /// Must call after [canInsert].
  void insert(Vector2 position, List<List<BaseCell>> figure) {
    var rootCurrentRow = position.y.toInt();
    var rootCurrentColumn = position.x.toInt();

    for (var y = 0; y < figure.length; y++) {
      for (var k = 0; k < figure[0].length; k++) {
        // dont work with link
        final cellInFigure = figure[y][k].copyWith();
        final cellInGrid = grid[rootCurrentRow][rootCurrentColumn];

        if (cellInFigure is! CellEmpty && cellInGrid is CellEmpty) {
          cellInFigure
            ..position = cellInGrid.position
            ..size = cellInGrid.size;
          grid[rootCurrentRow][rootCurrentColumn] = cellInFigure;

          cellsToRemove.add(cellInGrid);
          cellsToAdd.add(cellInFigure);
        }
        rootCurrentColumn++;
      }

      rootCurrentColumn = position.x.toInt();
      rootCurrentRow++;
    }
    notifyListeners();
    cellsToRemove.clear();
    cellsToAdd.clear();
  }

  void check() {
    final colsToRemove = [];
    final rowsToRemove = [];

    for (var y = 0; y < _row; y++) {
      var toRemove = true;
      for (var x = 0; x < _column; x++) {
        final cell = grid[y][x];
        if (cell is CellEmpty) {
          toRemove = false;
          break;
        }
      }
      if (toRemove) rowsToRemove.add(y);
    }

    for (var x = 0; x < _column; x++) {
      var toRemove = true;
      for (var y = 0; y < _row; y++) {
        final cell = grid[y][x];
        if (cell is CellEmpty) {
          toRemove = false;
          break;
        }
      }
      if (toRemove) colsToRemove.add(x);
    }

    for (var i = 0; i < colsToRemove.length; i++) {
      var x = colsToRemove[i];
      for (var y = 0; y < _column; y++) {
        final oldCell = grid[y][x];
        final newCell = CellEmpty(
          position: oldCell.position,
          size: oldCell.size,
        );
        grid[y][x] = newCell;
        cellsToRemove.add(oldCell);
        cellsToAdd.add(newCell);
      }
    }

    for (var i = 0; i < rowsToRemove.length; i++) {
      var y = rowsToRemove[i];
      for (var x = 0; x < _row; x++) {
        final oldCell = grid[y][x];
        if (cellsToRemove.contains(oldCell) || cellsToAdd.contains(oldCell)) {
          continue;
        }
        final newCell = CellEmpty(
          position: oldCell.position,
          size: oldCell.size,
        );
        grid[y][x] = newCell;
        cellsToRemove.add(oldCell);
        cellsToAdd.add(newCell);
      }
    }

    notifyListeners();
    cellsToRemove.clear();
    cellsToAdd.clear();
  }

  void init() {
    final generatedGrid = GridGenerator.generateCells(
      row: _row,
      column: _column,
      cellSize: _cellCize,
      builder: _cellBuilder,
    );

    grid = [for (final row in generatedGrid) row.toList()];
    cellsToAdd.addAll([for (final row in grid) ...row]);

    notifyListeners();
    cellsToRemove.clear();
    cellsToAdd.clear();
  }
}
