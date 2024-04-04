// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class IconDescriptionStruct extends FFFirebaseStruct {
  IconDescriptionStruct({
    String? icon,
    String? description,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _icon = icon,
        _description = description,
        super(firestoreUtilData);

  // "icon" field.
  String? _icon;
  String get icon => _icon ?? '';
  set icon(String? val) => _icon = val;
  bool hasIcon() => _icon != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;
  bool hasDescription() => _description != null;

  static IconDescriptionStruct fromMap(Map<String, dynamic> data) =>
      IconDescriptionStruct(
        icon: data['icon'] as String?,
        description: data['description'] as String?,
      );

  static IconDescriptionStruct? maybeFromMap(dynamic data) => data is Map
      ? IconDescriptionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'icon': _icon,
        'description': _description,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'icon': serializeParam(
          _icon,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
      }.withoutNulls;

  static IconDescriptionStruct fromSerializableMap(Map<String, dynamic> data) =>
      IconDescriptionStruct(
        icon: deserializeParam(
          data['icon'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'IconDescriptionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is IconDescriptionStruct &&
        icon == other.icon &&
        description == other.description;
  }

  @override
  int get hashCode => const ListEquality().hash([icon, description]);
}

IconDescriptionStruct createIconDescriptionStruct({
  String? icon,
  String? description,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    IconDescriptionStruct(
      icon: icon,
      description: description,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

IconDescriptionStruct? updateIconDescriptionStruct(
  IconDescriptionStruct? iconDescription, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    iconDescription
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addIconDescriptionStructData(
  Map<String, dynamic> firestoreData,
  IconDescriptionStruct? iconDescription,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (iconDescription == null) {
    return;
  }
  if (iconDescription.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && iconDescription.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final iconDescriptionData =
      getIconDescriptionFirestoreData(iconDescription, forFieldValue);
  final nestedData =
      iconDescriptionData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = iconDescription.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getIconDescriptionFirestoreData(
  IconDescriptionStruct? iconDescription, [
  bool forFieldValue = false,
]) {
  if (iconDescription == null) {
    return {};
  }
  final firestoreData = mapToFirestore(iconDescription.toMap());

  // Add any Firestore field values
  iconDescription.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getIconDescriptionListFirestoreData(
  List<IconDescriptionStruct>? iconDescriptions,
) =>
    iconDescriptions
        ?.map((e) => getIconDescriptionFirestoreData(e, true))
        .toList() ??
    [];
