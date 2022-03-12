import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:puzzle_block/game/figures/tap_area.dart';

class FigureDraggable extends Component with Draggable {
  late final TapArea _area;
  final List<void Function(DragStartInfo)> dragStart = [];
  final List<void Function(DragUpdateInfo)> dragUpdate = [];
  final List<void Function(DragEndInfo)> dragEnd = [];

  FigureDraggable({required TapArea area}) {
    _area = area;
  }

  @override
  bool onDragStart(DragStartInfo info) {
    for (final foo in dragStart) {
      foo.call(info);
    }

    return false;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    for (final foo in dragUpdate) {
      foo.call(info);
    }

    return false;
  }

  @override
  bool onDragEnd(DragEndInfo info) {
    for (final foo in dragEnd) {
      foo.call(info);
    }

    return false;
  }

  @override
  bool containsPoint(Vector2 point) {
    return _area.toAbsoluteRect().contains(point.toOffset());
  }

  @override
  void onRemove() {
    dragStart.clear();
    dragUpdate.clear();
    dragEnd.clear();

    super.onRemove();
  }
}
