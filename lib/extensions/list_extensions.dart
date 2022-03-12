import 'package:flame/game.dart';
import 'package:puzzle_block/game/cell.dart';

extension GrigExtenstions on List<List<BaseCell>> {
  Iterable<List<BaseCell>> elementsByFigure(
    Vector2 position,
    List<List<BaseCell>> figure,
  ) sync* {
    final rootRow = length;
    final rootColumn = first.length;
    // Position is out of bounds
    if (position.y > rootRow || position.x > rootColumn) return;
    // The figure is out of bounds of the matrix
    if ((position.y + figure.length) > rootRow ||
        (position.x + figure[0].length) > rootColumn) return;

    var rootCurrentRow = position.y.toInt();
    var rootCurrentColumn = position.x.toInt();

    for (var i = 0; i < figure.length; i++) {
      for (var k = 0; k < figure[0].length; k++) {
        final cellInFigure = figure[i][k];
        final cellInRoot = this[rootCurrentRow][rootCurrentColumn];

        yield [cellInRoot, cellInFigure];
        rootCurrentColumn++;
      }

      rootCurrentColumn = position.x.toInt();
      rootCurrentRow++;
    }
  }
}
