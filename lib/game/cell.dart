import 'package:flame/components.dart';

class CellEmpty extends BaseCell {
  CellEmpty({
    Vector2? position,
    Vector2? size,
  }) : super(position: position, size: size);

  @override
  String get asset => 'cell_empty';
}

class CellMarble extends BaseCell {
  CellMarble({
    Vector2? position,
    Vector2? size,
  }) : super(position: position, size: size);

  @override
  String get asset => 'cell_marble';
}

abstract class BaseCell extends SpriteComponent {
  String get asset;

  BaseCell({
    Vector2? position,
    Vector2? size,
  }) : super(position: position, size: size ?? Vector2(20.0, 20.0));

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    sprite = await Sprite.load('$asset.png');
  }
}
