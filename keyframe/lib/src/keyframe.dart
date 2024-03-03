import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'properties.dart';

class KeyframeValue {
  const KeyframeValue._(
    this._values,
  );

  factory KeyframeValue.evaluate(List<KeyframeProperty> properties, double t) {
    final values = <PropertyKey, dynamic>{};

    for (var property in properties) {
      values[property.key] = property.evaluate(t);
    }

    return KeyframeValue._(values);
  }

  final Map<PropertyKey, dynamic> _values;

  /// Read one of the inner property from its type [T].
  ///
  /// The property can also be identified with an additional [name]. This can be useful when there are
  /// multiples properties of type [T].
  T call<T>([String? name]) {
    if (name == null) {
      return _values[TypedPropertyKey(T)];
    }

    final key = NamedAndTypedPropertyKey(T, name);

    if (!_values.containsKey(key)) {
      throw Exception('No property found with name `$name`');
    }

    return _values[key];
  }
}

class KeyframeProperty<T> {
  final String? name;
  final List<Keyframe<T>> keyframes;

  KeyframeProperty(
    List<Keyframe<T>> keyframes, {
    this.name,
  }) : keyframes = [
          ...keyframes,
        ]..sort((x, y) => x.time.compareTo(y.time));

  Type get type => T;

  PropertyKey get key {
    if (name != null) {
      return NamedAndTypedPropertyKey(type, name!);
    }
    return TypedPropertyKey(type);
  }

  T evaluate(double t) {
    if (t <= 0 || keyframes.length == 1) {
      return keyframes.first.value;
    }
    if (t >= 1) {
      return keyframes.last.value;
    }
    final afterIndex = keyframes.indexWhere((x) => t < x.time);
    if (afterIndex == -1) {
      return keyframes.last.value;
    }
    if (afterIndex == 0) {
      return keyframes.first.value;
    }

    final before = keyframes[afterIndex - 1];
    final after = keyframes[afterIndex];
    final intervalTime = (t - before.time) / (after.time - before.time);
    return _defaultLerp(
      before.value,
      after.value,
      after.curve.transform(intervalTime),
    );
  }
}

class Keyframe<T> {
  final double time;
  final T value;
  final Curve curve;

  Keyframe(
    this.time,
    this.value, {
    this.curve = Curves.linear,
  });
}

T _defaultLerp<T>(T begin, T end, double time) {
  final dynamic b = begin;
  final dynamic e = end;
  if (T == double) {
    return lerpDouble(b, e, time) as T;
  }
  if (T == Color) {
    return Color.lerp(b, e, time) as T;
  }
  if (T == Size) {
    return Size.lerp(b, e, time) as T;
  }
  if (T == Decoration) {
    return Decoration.lerp(b, e, time) as T;
  }
  if (T == Rect) {
    return Rect.lerp(b, e, time) as T;
  }
  if (T == EdgeInsets) {
    return EdgeInsets.lerp(b, e, time) as T;
  }
  if (T == RelativeRect) {
    return RelativeRect.lerp(b, e, time) as T;
  }
  if (T == Alignment) {
    return Alignment.lerp(b, e, time) as T;
  }
  if (T == TextStyle) {
    return TextStyle.lerp(b, e, time) as T;
  }
  if (T == Radius) {
    return Radius.lerp(b, e, time) as T;
  }
  if (T == BoxShadow) {
    return BoxShadow.lerp(b, e, time) as T;
  }
  if (T == BorderRadius) {
    return BorderRadius.lerp(b, e, time) as T;
  }
  if (T == Matrix4) {
    return Matrix4Tween(begin: b, end: e).transform(time) as T;
  }
  if (T == Border) {
    return Border.lerp(b, e, time) as T;
  }
  if (T == BorderSide) {
    return BorderSide.lerp(b, e, time) as T;
  }
  if (T == ShapeBorder) {
    return ShapeBorder.lerp(b, e, time) as T;
  }
  if (T == BoxConstraints) {
    return BoxConstraints.lerp(b, e, time) as T;
  }
  if (T == Duration) {
    return lerpDuration(b, e, time) as T;
  }
  if (T == Offset) {
    return Offset.lerp(b, e, time) as T;
  }
  if (T == KeyframeLerp) {
    return b.lerp(e, time);
  }

  throw Exception('Lerp not supported for begin type "$T"');
}

abstract class KeyframeLerp<T> {
  const KeyframeLerp();

  T lerp(T other, double time);
}
