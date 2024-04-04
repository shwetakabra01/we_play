// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CreateEventResultStruct extends FFFirebaseStruct {
  CreateEventResultStruct({
    String? eventId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _eventId = eventId,
        super(firestoreUtilData);

  // "eventId" field.
  String? _eventId;
  String get eventId => _eventId ?? '';
  set eventId(String? val) => _eventId = val;
  bool hasEventId() => _eventId != null;

  static CreateEventResultStruct fromMap(Map<String, dynamic> data) =>
      CreateEventResultStruct(
        eventId: data['eventId'] as String?,
      );

  static CreateEventResultStruct? maybeFromMap(dynamic data) => data is Map
      ? CreateEventResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'eventId': _eventId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'eventId': serializeParam(
          _eventId,
          ParamType.String,
        ),
      }.withoutNulls;

  static CreateEventResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CreateEventResultStruct(
        eventId: deserializeParam(
          data['eventId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CreateEventResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CreateEventResultStruct && eventId == other.eventId;
  }

  @override
  int get hashCode => const ListEquality().hash([eventId]);
}

CreateEventResultStruct createCreateEventResultStruct({
  String? eventId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CreateEventResultStruct(
      eventId: eventId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CreateEventResultStruct? updateCreateEventResultStruct(
  CreateEventResultStruct? createEventResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    createEventResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCreateEventResultStructData(
  Map<String, dynamic> firestoreData,
  CreateEventResultStruct? createEventResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (createEventResult == null) {
    return;
  }
  if (createEventResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && createEventResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final createEventResultData =
      getCreateEventResultFirestoreData(createEventResult, forFieldValue);
  final nestedData =
      createEventResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = createEventResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCreateEventResultFirestoreData(
  CreateEventResultStruct? createEventResult, [
  bool forFieldValue = false,
]) {
  if (createEventResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(createEventResult.toMap());

  // Add any Firestore field values
  createEventResult.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCreateEventResultListFirestoreData(
  List<CreateEventResultStruct>? createEventResults,
) =>
    createEventResults
        ?.map((e) => getCreateEventResultFirestoreData(e, true))
        .toList() ??
    [];
