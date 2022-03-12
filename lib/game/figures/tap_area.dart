import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TapArea extends RectangleHitbox {
  TapArea({
    Vector2? position,
    Vector2? size,
  }) : super(position: position, size: size);

  @override
  CollisionType get collisionType => CollisionType.inactive;

  @override
  bool get debugMode => true;

  @override
  Color get debugColor => const Color.fromARGB(199, 0, 199, 50);
}
