// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventParticipantWoStruct extends FFFirebaseStruct {
  EventParticipantWoStruct({
    String? userRef,
    bool? isActive,
    String? status,
    String? entryDate,
    double? amountPaid,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userRef = userRef,
        _isActive = isActive,
        _status = status,
        _entryDate = entryDate,
        _amountPaid = amountPaid,
        super(firestoreUtilData);

  // "userRef" field.
  String? _userRef;
  String get userRef => _userRef ?? '';
  set userRef(String? val) => _userRef = val;
  bool hasUserRef() => _userRef != null;

  // "isActive" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  set isActive(bool? val) => _isActive = val;
  bool hasIsActive() => _isActive != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;
  bool hasStatus() => _status != null;

  // "entryDate" field.
  String? _entryDate;
  String get entryDate => _entryDate ?? '';
  set entryDate(String? val) => _entryDate = val;
  bool hasEntryDate() => _entryDate != null;

  // "amountPaid" field.
  double? _amountPaid;
  double get amountPaid => _amountPaid ?? 0.0;
  set amountPaid(double? val) => _amountPaid = val;
  void incrementAmountPaid(double amount) => _amountPaid = amountPaid + amount;
  bool hasAmountPaid() => _amountPaid != null;

  static EventParticipantWoStruct fromMap(Map<String, dynamic> data) =>
      EventParticipantWoStruct(
        userRef: data['userRef'] as String?,
        isActive: data['isActive'] as bool?,
        status: data['status'] as String?,
        entryDate: data['entryDate'] as String?,
        amountPaid: castToType<double>(data['amountPaid']),
      );

  static EventParticipantWoStruct? maybeFromMap(dynamic data) => data is Map
      ? EventParticipantWoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'userRef': _userRef,
        'isActive': _isActive,
        'status': _status,
        'entryDate': _entryDate,
        'amountPaid': _amountPaid,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userRef': serializeParam(
          _userRef,
          ParamType.String,
        ),
        'isActive': serializeParam(
          _isActive,
          ParamType.bool,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'entryDate': serializeParam(
          _entryDate,
          ParamType.String,
        ),
        'amountPaid': serializeParam(
          _amountPaid,
          ParamType.double,
        ),
      }.withoutNulls;

  static EventParticipantWoStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      EventParticipantWoStruct(
        userRef: deserializeParam(
          data['userRef'],
          ParamType.String,
          false,
        ),
        isActive: deserializeParam(
          data['isActive'],
          ParamType.bool,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        entryDate: deserializeParam(
          data['entryDate'],
          ParamType.String,
          false,
        ),
        amountPaid: deserializeParam(
          data['amountPaid'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'EventParticipantWoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EventParticipantWoStruct &&
        userRef == other.userRef &&
        isActive == other.isActive &&
        status == other.status &&
        entryDate == other.entryDate &&
        amountPaid == other.amountPaid;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([userRef, isActive, status, entryDate, amountPaid]);
}

EventParticipantWoStruct createEventParticipantWoStruct({
  String? userRef,
  bool? isActive,
  String? status,
  String? entryDate,
  double? amountPaid,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EventParticipantWoStruct(
      userRef: userRef,
      isActive: isActive,
      status: status,
      entryDate: entryDate,
      amountPaid: amountPaid,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EventParticipantWoStruct? updateEventParticipantWoStruct(
  EventParticipantWoStruct? eventParticipantWo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    eventParticipantWo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEventParticipantWoStructData(
  Map<String, dynamic> firestoreData,
  EventParticipantWoStruct? eventParticipantWo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (eventParticipantWo == null) {
    return;
  }
  if (eventParticipantWo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && eventParticipantWo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final eventParticipantWoData =
      getEventParticipantWoFirestoreData(eventParticipantWo, forFieldValue);
  final nestedData =
      eventParticipantWoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      eventParticipantWo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEventParticipantWoFirestoreData(
  EventParticipantWoStruct? eventParticipantWo, [
  bool forFieldValue = false,
]) {
  if (eventParticipantWo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(eventParticipantWo.toMap());

  // Add any Firestore field values
  eventParticipantWo.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEventParticipantWoListFirestoreData(
  List<EventParticipantWoStruct>? eventParticipantWos,
) =>
    eventParticipantWos
        ?.map((e) => getEventParticipantWoFirestoreData(e, true))
        .toList() ??
    [];
