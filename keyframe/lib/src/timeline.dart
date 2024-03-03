import 'dart:developer' as developer;

import 'package:flutter/animation.dart';
import 'package:keyframe/src/keyframe.dart';

class Timeline extends Tween<KeyframeValue> {
  final String? name;
  final List<KeyframeProperty> _properties;

  Timeline({this.name, required List<KeyframeProperty> properties})
      : _properties = properties,
        super(
          begin: KeyframeValue.evaluate(properties, 0),
          end: KeyframeValue.evaluate(properties, 1),
        ) {
    if (developer.extensionStreamHasListener) {
      developer.postEvent('ext.keyframe', {
        'test': 'dsfdfd',
      });
    }
  }

  @override
  KeyframeValue lerp(double t) {
    if (t <= 0) {
      return begin!;
    }
    if (t >= 1) {
      return end!;
    }

    return KeyframeValue.evaluate(
      _properties,
      t,
    );
  }
}
