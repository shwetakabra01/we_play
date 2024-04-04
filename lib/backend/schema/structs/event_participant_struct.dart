// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventParticipantStruct extends FFFirebaseStruct {
  EventParticipantStruct({
    DocumentReference? userRef,
    DateTime? entryDate,
    bool? isActive,
    String? status,
    String? role,
    double? amountPaid,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userRef = userRef,
        _entryDate = entryDate,
        _isActive = isActive,
        _status = status,
        _role = role,
        _amountPaid = amountPaid,
        super(firestoreUtilData);

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  set userRef(DocumentReference? val) => _userRef = val;
  bool hasUserRef() => _userRef != null;

  // "entryDate" field.
  DateTime? _entryDate;
  DateTime? get entryDate => _entryDate;
  set entryDate(DateTime? val) => _entryDate = val;
  bool hasEntryDate() => _entryDate != null;

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

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  set role(String? val) => _role = val;
  bool hasRole() => _role != null;

  // "amountPaid" field.
  double? _amountPaid;
  double get amountPaid => _amountPaid ?? 0.0;
  set amountPaid(double? val) => _amountPaid = val;
  void incrementAmountPaid(double amount) => _amountPaid = amountPaid + amount;
  bool hasAmountPaid() => _amountPaid != null;

  static EventParticipantStruct fromMap(Map<String, dynamic> data) =>
      EventParticipantStruct(
        userRef: data['userRef'] as DocumentReference?,
        entryDate: data['entryDate'] as DateTime?,
        isActive: data['isActive'] as bool?,
        status: data['status'] as String?,
        role: data['role'] as String?,
        amountPaid: castToType<double>(data['amountPaid']),
      );

  static EventParticipantStruct? maybeFromMap(dynamic data) => data is Map
      ? EventParticipantStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'userRef': _userRef,
        'entryDate': _entryDate,
        'isActive': _isActive,
        'status': _status,
        'role': _role,
        'amountPaid': _amountPaid,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userRef': serializeParam(
          _userRef,
          ParamType.DocumentReference,
        ),
        'entryDate': serializeParam(
          _entryDate,
          ParamType.DateTime,
        ),
        'isActive': serializeParam(
          _isActive,
          ParamType.bool,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'role': serializeParam(
          _role,
          ParamType.String,
        ),
        'amountPaid': serializeParam(
          _amountPaid,
          ParamType.double,
        ),
      }.withoutNulls;

  static EventParticipantStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      EventParticipantStruct(
        userRef: deserializeParam(
          data['userRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        entryDate: deserializeParam(
          data['entryDate'],
          ParamType.DateTime,
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
        role: deserializeParam(
          data['role'],
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
  String toString() => 'EventParticipantStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EventParticipantStruct &&
        userRef == other.userRef &&
        entryDate == other.entryDate &&
        isActive == other.isActive &&
        status == other.status &&
        role == other.role &&
        amountPaid == other.amountPaid;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([userRef, entryDate, isActive, status, role, amountPaid]);
}

EventParticipantStruct createEventParticipantStruct({
  DocumentReference? userRef,
  DateTime? entryDate,
  bool? isActive,
  String? status,
  String? role,
  double? amountPaid,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EventParticipantStruct(
      userRef: userRef,
      entryDate: entryDate,
      isActive: isActive,
      status: status,
      role: role,
      amountPaid: amountPaid,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EventParticipantStruct? updateEventParticipantStruct(
  EventParticipantStruct? eventParticipant, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    eventParticipant
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEventParticipantStructData(
  Map<String, dynamic> firestoreData,
  EventParticipantStruct? eventParticipant,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (eventParticipant == null) {
    return;
  }
  if (eventParticipant.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && eventParticipant.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final eventParticipantData =
      getEventParticipantFirestoreData(eventParticipant, forFieldValue);
  final nestedData =
      eventParticipantData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = eventParticipant.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEventParticipantFirestoreData(
  EventParticipantStruct? eventParticipant, [
  bool forFieldValue = false,
]) {
  if (eventParticipant == null) {
    return {};
  }
  final firestoreData = mapToFirestore(eventParticipant.toMap());

  // Add any Firestore field values
  eventParticipant.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEventParticipantListFirestoreData(
  List<EventParticipantStruct>? eventParticipants,
) =>
    eventParticipants
        ?.map((e) => getEventParticipantFirestoreData(e, true))
        .toList() ??
    [];
