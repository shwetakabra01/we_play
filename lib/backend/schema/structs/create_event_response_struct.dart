// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CreateEventResponseStruct extends FFFirebaseStruct {
  CreateEventResponseStruct({
    bool? success,
    String? code,
    CreateEventResultStruct? result,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _success = success,
        _code = code,
        _result = result,
        super(firestoreUtilData);

  // "success" field.
  bool? _success;
  bool get success => _success ?? false;
  set success(bool? val) => _success = val;
  bool hasSuccess() => _success != null;

  // "code" field.
  String? _code;
  String get code => _code ?? '';
  set code(String? val) => _code = val;
  bool hasCode() => _code != null;

  // "result" field.
  CreateEventResultStruct? _result;
  CreateEventResultStruct get result => _result ?? CreateEventResultStruct();
  set result(CreateEventResultStruct? val) => _result = val;
  void updateResult(Function(CreateEventResultStruct) updateFn) =>
      updateFn(_result ??= CreateEventResultStruct());
  bool hasResult() => _result != null;

  static CreateEventResponseStruct fromMap(Map<String, dynamic> data) =>
      CreateEventResponseStruct(
        success: data['success'] as bool?,
        code: data['code'] as String?,
        result: CreateEventResultStruct.maybeFromMap(data['result']),
      );

  static CreateEventResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? CreateEventResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'success': _success,
        'code': _code,
        'result': _result?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'success': serializeParam(
          _success,
          ParamType.bool,
        ),
        'code': serializeParam(
          _code,
          ParamType.String,
        ),
        'result': serializeParam(
          _result,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static CreateEventResponseStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CreateEventResponseStruct(
        success: deserializeParam(
          data['success'],
          ParamType.bool,
          false,
        ),
        code: deserializeParam(
          data['code'],
          ParamType.String,
          false,
        ),
        result: deserializeStructParam(
          data['result'],
          ParamType.DataStruct,
          false,
          structBuilder: CreateEventResultStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'CreateEventResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CreateEventResponseStruct &&
        success == other.success &&
        code == other.code &&
        result == other.result;
  }

  @override
  int get hashCode => const ListEquality().hash([success, code, result]);
}

CreateEventResponseStruct createCreateEventResponseStruct({
  bool? success,
  String? code,
  CreateEventResultStruct? result,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CreateEventResponseStruct(
      success: success,
      code: code,
      result: result ?? (clearUnsetFields ? CreateEventResultStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CreateEventResponseStruct? updateCreateEventResponseStruct(
  CreateEventResponseStruct? createEventResponse, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    createEventResponse
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCreateEventResponseStructData(
  Map<String, dynamic> firestoreData,
  CreateEventResponseStruct? createEventResponse,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (createEventResponse == null) {
    return;
  }
  if (createEventResponse.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && createEventResponse.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final createEventResponseData =
      getCreateEventResponseFirestoreData(createEventResponse, forFieldValue);
  final nestedData =
      createEventResponseData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      createEventResponse.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCreateEventResponseFirestoreData(
  CreateEventResponseStruct? createEventResponse, [
  bool forFieldValue = false,
]) {
  if (createEventResponse == null) {
    return {};
  }
  final firestoreData = mapToFirestore(createEventResponse.toMap());

  // Handle nested data for "result" field.
  addCreateEventResultStructData(
    firestoreData,
    createEventResponse.hasResult() ? createEventResponse.result : null,
    'result',
    forFieldValue,
  );

  // Add any Firestore field values
  createEventResponse.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCreateEventResponseListFirestoreData(
  List<CreateEventResponseStruct>? createEventResponses,
) =>
    createEventResponses
        ?.map((e) => getCreateEventResponseFirestoreData(e, true))
        .toList() ??
    [];
