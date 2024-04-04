// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ScoreDetailsStruct extends FFFirebaseStruct {
  ScoreDetailsStruct({
    DocumentReference? player,
    DocumentReference? team,
    DateTime? datetime,
    String? timer,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _player = player,
        _team = team,
        _datetime = datetime,
        _timer = timer,
        super(firestoreUtilData);

  // "player" field.
  DocumentReference? _player;
  DocumentReference? get player => _player;
  set player(DocumentReference? val) => _player = val;
  bool hasPlayer() => _player != null;

  // "team" field.
  DocumentReference? _team;
  DocumentReference? get team => _team;
  set team(DocumentReference? val) => _team = val;
  bool hasTeam() => _team != null;

  // "datetime" field.
  DateTime? _datetime;
  DateTime? get datetime => _datetime;
  set datetime(DateTime? val) => _datetime = val;
  bool hasDatetime() => _datetime != null;

  // "timer" field.
  String? _timer;
  String get timer => _timer ?? '';
  set timer(String? val) => _timer = val;
  bool hasTimer() => _timer != null;

  static ScoreDetailsStruct fromMap(Map<String, dynamic> data) =>
      ScoreDetailsStruct(
        player: data['player'] as DocumentReference?,
        team: data['team'] as DocumentReference?,
        datetime: data['datetime'] as DateTime?,
        timer: data['timer'] as String?,
      );

  static ScoreDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? ScoreDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'player': _player,
        'team': _team,
        'datetime': _datetime,
        'timer': _timer,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'player': serializeParam(
          _player,
          ParamType.DocumentReference,
        ),
        'team': serializeParam(
          _team,
          ParamType.DocumentReference,
        ),
        'datetime': serializeParam(
          _datetime,
          ParamType.DateTime,
        ),
        'timer': serializeParam(
          _timer,
          ParamType.String,
        ),
      }.withoutNulls;

  static ScoreDetailsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ScoreDetailsStruct(
        player: deserializeParam(
          data['player'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        team: deserializeParam(
          data['team'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['teams'],
        ),
        datetime: deserializeParam(
          data['datetime'],
          ParamType.DateTime,
          false,
        ),
        timer: deserializeParam(
          data['timer'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ScoreDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ScoreDetailsStruct &&
        player == other.player &&
        team == other.team &&
        datetime == other.datetime &&
        timer == other.timer;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([player, team, datetime, timer]);
}

ScoreDetailsStruct createScoreDetailsStruct({
  DocumentReference? player,
  DocumentReference? team,
  DateTime? datetime,
  String? timer,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ScoreDetailsStruct(
      player: player,
      team: team,
      datetime: datetime,
      timer: timer,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ScoreDetailsStruct? updateScoreDetailsStruct(
  ScoreDetailsStruct? scoreDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    scoreDetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addScoreDetailsStructData(
  Map<String, dynamic> firestoreData,
  ScoreDetailsStruct? scoreDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (scoreDetails == null) {
    return;
  }
  if (scoreDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && scoreDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final scoreDetailsData =
      getScoreDetailsFirestoreData(scoreDetails, forFieldValue);
  final nestedData =
      scoreDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = scoreDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getScoreDetailsFirestoreData(
  ScoreDetailsStruct? scoreDetails, [
  bool forFieldValue = false,
]) {
  if (scoreDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(scoreDetails.toMap());

  // Add any Firestore field values
  scoreDetails.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getScoreDetailsListFirestoreData(
  List<ScoreDetailsStruct>? scoreDetailss,
) =>
    scoreDetailss?.map((e) => getScoreDetailsFirestoreData(e, true)).toList() ??
    [];
