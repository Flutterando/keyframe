abstract class PropertyKey {
  const PropertyKey();
}

/// A property that is identified from its [type] only.
class TypedPropertyKey extends PropertyKey {
  const TypedPropertyKey(this.type);

  final Type type;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is TypedPropertyKey && other.type == type;
  }

  @override
  int get hashCode => runtimeType.hashCode ^ type.hashCode;
}

/// A property that is identified from its [type] and a [name].
class NamedAndTypedPropertyKey extends PropertyKey {
  const NamedAndTypedPropertyKey(this.type, this.name);
  final String name;
  final Type type;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is NamedAndTypedPropertyKey && other.name == name && other.type == type;
  }

  @override
  int get hashCode => runtimeType.hashCode ^ type.hashCode ^ name.hashCode;
}
