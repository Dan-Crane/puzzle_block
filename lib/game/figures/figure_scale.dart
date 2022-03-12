import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/input.dart';
import 'package:flutter/widgets.dart';
import 'package:puzzle_block/game/figures/figure_draggable.dart';

class FigureScale extends Component {
  late final FigureDraggable figureDraggable;

  final _controller = EffectController(
    duration: 0.2,
    curve: Curves.easeOut,
  );

  FigureScale({required this.figureDraggable}) {
    figureDraggable.dragStart.add(zoom);
  }

  void zoom(DragStartInfo dragStartInfo) => parent?.add(_createEffect(2.0));

  void reset() => parent?.add(_createEffect(1.0));

  ScaleEffect _createEffect(double scaleFactor) {
    _removeEffect();
    _controller.setToStart();

    return ScaleEffect.to(Vector2.all(scaleFactor), _controller);
  }

  void _removeEffect() => parent?.children
      .cast<Component?>()
      .firstWhere((c) => c is ScaleEffect, orElse: () => null)
      ?.removeFromParent();

  @override
  void onRemove() {
    figureDraggable.dragStart.remove(zoom);

    super.onRemove();
  }
}
