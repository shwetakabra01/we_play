// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TurfStruct extends FFFirebaseStruct {
  TurfStruct({
    String? size,
    int? numberOfTurfs,
    double? cost,
    int? players,
    int? turfId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _size = size,
        _numberOfTurfs = numberOfTurfs,
        _cost = cost,
        _players = players,
        _turfId = turfId,
        super(firestoreUtilData);

  // "size" field.
  String? _size;
  String get size => _size ?? '';
  set size(String? val) => _size = val;
  bool hasSize() => _size != null;

  // "numberOfTurfs" field.
  int? _numberOfTurfs;
  int get numberOfTurfs => _numberOfTurfs ?? 0;
  set numberOfTurfs(int? val) => _numberOfTurfs = val;
  void incrementNumberOfTurfs(int amount) =>
      _numberOfTurfs = numberOfTurfs + amount;
  bool hasNumberOfTurfs() => _numberOfTurfs != null;

  // "cost" field.
  double? _cost;
  double get cost => _cost ?? 0.0;
  set cost(double? val) => _cost = val;
  void incrementCost(double amount) => _cost = cost + amount;
  bool hasCost() => _cost != null;

  // "players" field.
  int? _players;
  int get players => _players ?? 0;
  set players(int? val) => _players = val;
  void incrementPlayers(int amount) => _players = players + amount;
  bool hasPlayers() => _players != null;

  // "turfId" field.
  int? _turfId;
  int get turfId => _turfId ?? 0;
  set turfId(int? val) => _turfId = val;
  void incrementTurfId(int amount) => _turfId = turfId + amount;
  bool hasTurfId() => _turfId != null;

  static TurfStruct fromMap(Map<String, dynamic> data) => TurfStruct(
        size: data['size'] as String?,
        numberOfTurfs: castToType<int>(data['numberOfTurfs']),
        cost: castToType<double>(data['cost']),
        players: castToType<int>(data['players']),
        turfId: castToType<int>(data['turfId']),
      );

  static TurfStruct? maybeFromMap(dynamic data) =>
      data is Map ? TurfStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'size': _size,
        'numberOfTurfs': _numberOfTurfs,
        'cost': _cost,
        'players': _players,
        'turfId': _turfId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'size': serializeParam(
          _size,
          ParamType.String,
        ),
        'numberOfTurfs': serializeParam(
          _numberOfTurfs,
          ParamType.int,
        ),
        'cost': serializeParam(
          _cost,
          ParamType.double,
        ),
        'players': serializeParam(
          _players,
          ParamType.int,
        ),
        'turfId': serializeParam(
          _turfId,
          ParamType.int,
        ),
      }.withoutNulls;

  static TurfStruct fromSerializableMap(Map<String, dynamic> data) =>
      TurfStruct(
        size: deserializeParam(
          data['size'],
          ParamType.String,
          false,
        ),
        numberOfTurfs: deserializeParam(
          data['numberOfTurfs'],
          ParamType.int,
          false,
        ),
        cost: deserializeParam(
          data['cost'],
          ParamType.double,
          false,
        ),
        players: deserializeParam(
          data['players'],
          ParamType.int,
          false,
        ),
        turfId: deserializeParam(
          data['turfId'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'TurfStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TurfStruct &&
        size == other.size &&
        numberOfTurfs == other.numberOfTurfs &&
        cost == other.cost &&
        players == other.players &&
        turfId == other.turfId;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([size, numberOfTurfs, cost, players, turfId]);
}

TurfStruct createTurfStruct({
  String? size,
  int? numberOfTurfs,
  double? cost,
  int? players,
  int? turfId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TurfStruct(
      size: size,
      numberOfTurfs: numberOfTurfs,
      cost: cost,
      players: players,
      turfId: turfId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TurfStruct? updateTurfStruct(
  TurfStruct? turf, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    turf
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTurfStructData(
  Map<String, dynamic> firestoreData,
  TurfStruct? turf,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (turf == null) {
    return;
  }
  if (turf.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && turf.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final turfData = getTurfFirestoreData(turf, forFieldValue);
  final nestedData = turfData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = turf.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTurfFirestoreData(
  TurfStruct? turf, [
  bool forFieldValue = false,
]) {
  if (turf == null) {
    return {};
  }
  final firestoreData = mapToFirestore(turf.toMap());

  // Add any Firestore field values
  turf.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTurfListFirestoreData(
  List<TurfStruct>? turfs,
) =>
    turfs?.map((e) => getTurfFirestoreData(e, true)).toList() ?? [];
