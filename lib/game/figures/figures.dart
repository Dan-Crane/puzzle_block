import 'package:puzzle_block/game/cell.dart';

/*
    + +
*/
final figure0 = [
  [CellMarble(), CellMarble()],
];

/*
      +
    + +
*/
final figure1 = [
  [CellEmpty(), CellMarble()],
  [CellMarble(), CellMarble()],
];

/*
    + +
    + +
*/
final figure4 = [
  [CellMarble(), CellMarble()],
  [CellMarble(), CellMarble()],
];

/* 
    + + + +
*/
final figure2 = [
  [CellMarble(), CellMarble(), CellMarble(), CellMarble()],
];

/* 
    + + + +
          +
          +
          +
*/
final figure3 = [
  [CellMarble(), CellMarble(), CellMarble(), CellMarble()],
  [CellEmpty(), CellEmpty(), CellEmpty(), CellMarble()],
  [CellEmpty(), CellEmpty(), CellEmpty(), CellMarble()],
  [CellEmpty(), CellEmpty(), CellEmpty(), CellMarble()],
];

/*
    +
    +
    +
    +
*/
final figure5 = [
  [CellMarble()],
  [CellMarble()],
  [CellMarble()],
  [CellMarble()],
];
