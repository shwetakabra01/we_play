// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ActionResponseStruct extends FFFirebaseStruct {
  ActionResponseStruct({
    bool? success,
    String? code,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _success = success,
        _code = code,
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

  static ActionResponseStruct fromMap(Map<String, dynamic> data) =>
      ActionResponseStruct(
        success: data['success'] as bool?,
        code: data['code'] as String?,
      );

  static ActionResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? ActionResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'success': _success,
        'code': _code,
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
      }.withoutNulls;

  static ActionResponseStruct fromSerializableMap(Map<String, dynamic> data) =>
      ActionResponseStruct(
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
      );

  @override
  String toString() => 'ActionResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ActionResponseStruct &&
        success == other.success &&
        code == other.code;
  }

  @override
  int get hashCode => const ListEquality().hash([success, code]);
}

ActionResponseStruct createActionResponseStruct({
  bool? success,
  String? code,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ActionResponseStruct(
      success: success,
      code: code,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ActionResponseStruct? updateActionResponseStruct(
  ActionResponseStruct? actionResponse, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    actionResponse
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addActionResponseStructData(
  Map<String, dynamic> firestoreData,
  ActionResponseStruct? actionResponse,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (actionResponse == null) {
    return;
  }
  if (actionResponse.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && actionResponse.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final actionResponseData =
      getActionResponseFirestoreData(actionResponse, forFieldValue);
  final nestedData =
      actionResponseData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = actionResponse.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getActionResponseFirestoreData(
  ActionResponseStruct? actionResponse, [
  bool forFieldValue = false,
]) {
  if (actionResponse == null) {
    return {};
  }
  final firestoreData = mapToFirestore(actionResponse.toMap());

  // Add any Firestore field values
  actionResponse.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getActionResponseListFirestoreData(
  List<ActionResponseStruct>? actionResponses,
) =>
    actionResponses
        ?.map((e) => getActionResponseFirestoreData(e, true))
        .toList() ??
    [];
