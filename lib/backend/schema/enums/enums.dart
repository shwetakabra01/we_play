import 'package:collection/collection.dart';

enum ApplicationRule {
  TIME_BETWEEN,
  MIN_HOURS,
}

enum Discount {
  PERCENTAGE,
  FLAT,
}

enum UserRole {
  ADMIN,
  USER,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (ApplicationRule):
      return ApplicationRule.values.deserialize(value) as T?;
    case (Discount):
      return Discount.values.deserialize(value) as T?;
    case (UserRole):
      return UserRole.values.deserialize(value) as T?;
    default:
      return null;
  }
}
