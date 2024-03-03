import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyframe/src/keyframe.dart';
import 'package:keyframe/src/timeline.dart';

void main() {
  test('timeline ...', () async {
    final timeline = Timeline(
      properties: [
        KeyframeProperty<Size>([
          Keyframe(0, const Size(100, 100)),
          Keyframe(1, const Size(200, 200)),
        ]),
        KeyframeProperty<Color>([
          Keyframe(0, Colors.blue),
          Keyframe(1, Colors.red),
        ]),
      ],
    );

    final value = timeline.lerp(0.5);
    expect(value<Size>(), const Size(150, 150));
    expect(value<Color>(), Color.lerp(Colors.blue, Colors.red, 0.5));
  });

  test('timeline one', () async {
    final timeline = Timeline(
      properties: [
        KeyframeProperty<double>([
          Keyframe(0, 10),
          //Keyframe(1, 1),
        ]),
      ],
    );

    final value = timeline.lerp(0.5);
    expect(value<double>(), 10.0);
  });
}
