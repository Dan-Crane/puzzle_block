import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/input.dart';
import 'package:flutter/animation.dart';
import 'package:puzzle_block/game/figures/figure_component.dart';
import 'package:puzzle_block/game/figures/figure_draggable.dart';

class FigureMovement extends Component {
  late final FigureComponent figureComponent;
  late final FigureDraggable figureDraggable;

  late final Vector2 _startPoint;

  FigureMovement({
    required this.figureComponent,
    required this.figureDraggable,
  }) {
    _startPoint = figureComponent.position.clone();
    figureDraggable.dragUpdate.add(moveTo);
  }

  void moveTo(DragUpdateInfo dragUpdateInfo) {
    figureComponent.position += dragUpdateInfo.delta.game;
  }

  void moveBack() {
    final effect = MoveEffect.to(
      _startPoint,
      EffectController(duration: 0.3, curve: Curves.easeIn),
    );
    figureComponent.add(effect);
  }

  @override
  void onRemove() {
    figureDraggable.dragUpdate.remove(moveTo);
    super.onRemove();
  }
}
