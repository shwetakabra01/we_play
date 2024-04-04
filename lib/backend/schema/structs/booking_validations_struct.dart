// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BookingValidationsStruct extends FFFirebaseStruct {
  BookingValidationsStruct({
    bool? turfSize,
    bool? sport,
    bool? numberOfTurfs,
    bool? date,
    bool? time,
    bool? participantCount,
    bool? formValid,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _turfSize = turfSize,
        _sport = sport,
        _numberOfTurfs = numberOfTurfs,
        _date = date,
        _time = time,
        _participantCount = participantCount,
        _formValid = formValid,
        super(firestoreUtilData);

  // "turfSize" field.
  bool? _turfSize;
  bool get turfSize => _turfSize ?? false;
  set turfSize(bool? val) => _turfSize = val;
  bool hasTurfSize() => _turfSize != null;

  // "sport" field.
  bool? _sport;
  bool get sport => _sport ?? false;
  set sport(bool? val) => _sport = val;
  bool hasSport() => _sport != null;

  // "numberOfTurfs" field.
  bool? _numberOfTurfs;
  bool get numberOfTurfs => _numberOfTurfs ?? false;
  set numberOfTurfs(bool? val) => _numberOfTurfs = val;
  bool hasNumberOfTurfs() => _numberOfTurfs != null;

  // "date" field.
  bool? _date;
  bool get date => _date ?? false;
  set date(bool? val) => _date = val;
  bool hasDate() => _date != null;

  // "time" field.
  bool? _time;
  bool get time => _time ?? false;
  set time(bool? val) => _time = val;
  bool hasTime() => _time != null;

  // "participantCount" field.
  bool? _participantCount;
  bool get participantCount => _participantCount ?? false;
  set participantCount(bool? val) => _participantCount = val;
  bool hasParticipantCount() => _participantCount != null;

  // "formValid" field.
  bool? _formValid;
  bool get formValid => _formValid ?? false;
  set formValid(bool? val) => _formValid = val;
  bool hasFormValid() => _formValid != null;

  static BookingValidationsStruct fromMap(Map<String, dynamic> data) =>
      BookingValidationsStruct(
        turfSize: data['turfSize'] as bool?,
        sport: data['sport'] as bool?,
        numberOfTurfs: data['numberOfTurfs'] as bool?,
        date: data['date'] as bool?,
        time: data['time'] as bool?,
        participantCount: data['participantCount'] as bool?,
        formValid: data['formValid'] as bool?,
      );

  static BookingValidationsStruct? maybeFromMap(dynamic data) => data is Map
      ? BookingValidationsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'turfSize': _turfSize,
        'sport': _sport,
        'numberOfTurfs': _numberOfTurfs,
        'date': _date,
        'time': _time,
        'participantCount': _participantCount,
        'formValid': _formValid,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'turfSize': serializeParam(
          _turfSize,
          ParamType.bool,
        ),
        'sport': serializeParam(
          _sport,
          ParamType.bool,
        ),
        'numberOfTurfs': serializeParam(
          _numberOfTurfs,
          ParamType.bool,
        ),
        'date': serializeParam(
          _date,
          ParamType.bool,
        ),
        'time': serializeParam(
          _time,
          ParamType.bool,
        ),
        'participantCount': serializeParam(
          _participantCount,
          ParamType.bool,
        ),
        'formValid': serializeParam(
          _formValid,
          ParamType.bool,
        ),
      }.withoutNulls;

  static BookingValidationsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      BookingValidationsStruct(
        turfSize: deserializeParam(
          data['turfSize'],
          ParamType.bool,
          false,
        ),
        sport: deserializeParam(
          data['sport'],
          ParamType.bool,
          false,
        ),
        numberOfTurfs: deserializeParam(
          data['numberOfTurfs'],
          ParamType.bool,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.bool,
          false,
        ),
        time: deserializeParam(
          data['time'],
          ParamType.bool,
          false,
        ),
        participantCount: deserializeParam(
          data['participantCount'],
          ParamType.bool,
          false,
        ),
        formValid: deserializeParam(
          data['formValid'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'BookingValidationsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BookingValidationsStruct &&
        turfSize == other.turfSize &&
        sport == other.sport &&
        numberOfTurfs == other.numberOfTurfs &&
        date == other.date &&
        time == other.time &&
        participantCount == other.participantCount &&
        formValid == other.formValid;
  }

  @override
  int get hashCode => const ListEquality().hash([
        turfSize,
        sport,
        numberOfTurfs,
        date,
        time,
        participantCount,
        formValid
      ]);
}

BookingValidationsStruct createBookingValidationsStruct({
  bool? turfSize,
  bool? sport,
  bool? numberOfTurfs,
  bool? date,
  bool? time,
  bool? participantCount,
  bool? formValid,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BookingValidationsStruct(
      turfSize: turfSize,
      sport: sport,
      numberOfTurfs: numberOfTurfs,
      date: date,
      time: time,
      participantCount: participantCount,
      formValid: formValid,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BookingValidationsStruct? updateBookingValidationsStruct(
  BookingValidationsStruct? bookingValidations, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    bookingValidations
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBookingValidationsStructData(
  Map<String, dynamic> firestoreData,
  BookingValidationsStruct? bookingValidations,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (bookingValidations == null) {
    return;
  }
  if (bookingValidations.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && bookingValidations.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final bookingValidationsData =
      getBookingValidationsFirestoreData(bookingValidations, forFieldValue);
  final nestedData =
      bookingValidationsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      bookingValidations.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBookingValidationsFirestoreData(
  BookingValidationsStruct? bookingValidations, [
  bool forFieldValue = false,
]) {
  if (bookingValidations == null) {
    return {};
  }
  final firestoreData = mapToFirestore(bookingValidations.toMap());

  // Add any Firestore field values
  bookingValidations.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBookingValidationsListFirestoreData(
  List<BookingValidationsStruct>? bookingValidationss,
) =>
    bookingValidationss
        ?.map((e) => getBookingValidationsFirestoreData(e, true))
        .toList() ??
    [];
