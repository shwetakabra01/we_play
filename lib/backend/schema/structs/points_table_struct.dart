// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PointsTableStruct extends FFFirebaseStruct {
  PointsTableStruct({
    String? teamName,
    String? teamIcon,
    int? played,
    int? won,
    int? lost,
    int? draw,
    int? gf,
    int? ga,
    int? gd,
    int? points,
    DocumentReference? teamRef,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _teamName = teamName,
        _teamIcon = teamIcon,
        _played = played,
        _won = won,
        _lost = lost,
        _draw = draw,
        _gf = gf,
        _ga = ga,
        _gd = gd,
        _points = points,
        _teamRef = teamRef,
        super(firestoreUtilData);

  // "teamName" field.
  String? _teamName;
  String get teamName => _teamName ?? '';
  set teamName(String? val) => _teamName = val;
  bool hasTeamName() => _teamName != null;

  // "teamIcon" field.
  String? _teamIcon;
  String get teamIcon => _teamIcon ?? '';
  set teamIcon(String? val) => _teamIcon = val;
  bool hasTeamIcon() => _teamIcon != null;

  // "played" field.
  int? _played;
  int get played => _played ?? 0;
  set played(int? val) => _played = val;
  void incrementPlayed(int amount) => _played = played + amount;
  bool hasPlayed() => _played != null;

  // "won" field.
  int? _won;
  int get won => _won ?? 0;
  set won(int? val) => _won = val;
  void incrementWon(int amount) => _won = won + amount;
  bool hasWon() => _won != null;

  // "lost" field.
  int? _lost;
  int get lost => _lost ?? 0;
  set lost(int? val) => _lost = val;
  void incrementLost(int amount) => _lost = lost + amount;
  bool hasLost() => _lost != null;

  // "draw" field.
  int? _draw;
  int get draw => _draw ?? 0;
  set draw(int? val) => _draw = val;
  void incrementDraw(int amount) => _draw = draw + amount;
  bool hasDraw() => _draw != null;

  // "gf" field.
  int? _gf;
  int get gf => _gf ?? 0;
  set gf(int? val) => _gf = val;
  void incrementGf(int amount) => _gf = gf + amount;
  bool hasGf() => _gf != null;

  // "ga" field.
  int? _ga;
  int get ga => _ga ?? 0;
  set ga(int? val) => _ga = val;
  void incrementGa(int amount) => _ga = ga + amount;
  bool hasGa() => _ga != null;

  // "gd" field.
  int? _gd;
  int get gd => _gd ?? 0;
  set gd(int? val) => _gd = val;
  void incrementGd(int amount) => _gd = gd + amount;
  bool hasGd() => _gd != null;

  // "points" field.
  int? _points;
  int get points => _points ?? 0;
  set points(int? val) => _points = val;
  void incrementPoints(int amount) => _points = points + amount;
  bool hasPoints() => _points != null;

  // "teamRef" field.
  DocumentReference? _teamRef;
  DocumentReference? get teamRef => _teamRef;
  set teamRef(DocumentReference? val) => _teamRef = val;
  bool hasTeamRef() => _teamRef != null;

  static PointsTableStruct fromMap(Map<String, dynamic> data) =>
      PointsTableStruct(
        teamName: data['teamName'] as String?,
        teamIcon: data['teamIcon'] as String?,
        played: castToType<int>(data['played']),
        won: castToType<int>(data['won']),
        lost: castToType<int>(data['lost']),
        draw: castToType<int>(data['draw']),
        gf: castToType<int>(data['gf']),
        ga: castToType<int>(data['ga']),
        gd: castToType<int>(data['gd']),
        points: castToType<int>(data['points']),
        teamRef: data['teamRef'] as DocumentReference?,
      );

  static PointsTableStruct? maybeFromMap(dynamic data) => data is Map
      ? PointsTableStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'teamName': _teamName,
        'teamIcon': _teamIcon,
        'played': _played,
        'won': _won,
        'lost': _lost,
        'draw': _draw,
        'gf': _gf,
        'ga': _ga,
        'gd': _gd,
        'points': _points,
        'teamRef': _teamRef,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'teamName': serializeParam(
          _teamName,
          ParamType.String,
        ),
        'teamIcon': serializeParam(
          _teamIcon,
          ParamType.String,
        ),
        'played': serializeParam(
          _played,
          ParamType.int,
        ),
        'won': serializeParam(
          _won,
          ParamType.int,
        ),
        'lost': serializeParam(
          _lost,
          ParamType.int,
        ),
        'draw': serializeParam(
          _draw,
          ParamType.int,
        ),
        'gf': serializeParam(
          _gf,
          ParamType.int,
        ),
        'ga': serializeParam(
          _ga,
          ParamType.int,
        ),
        'gd': serializeParam(
          _gd,
          ParamType.int,
        ),
        'points': serializeParam(
          _points,
          ParamType.int,
        ),
        'teamRef': serializeParam(
          _teamRef,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static PointsTableStruct fromSerializableMap(Map<String, dynamic> data) =>
      PointsTableStruct(
        teamName: deserializeParam(
          data['teamName'],
          ParamType.String,
          false,
        ),
        teamIcon: deserializeParam(
          data['teamIcon'],
          ParamType.String,
          false,
        ),
        played: deserializeParam(
          data['played'],
          ParamType.int,
          false,
        ),
        won: deserializeParam(
          data['won'],
          ParamType.int,
          false,
        ),
        lost: deserializeParam(
          data['lost'],
          ParamType.int,
          false,
        ),
        draw: deserializeParam(
          data['draw'],
          ParamType.int,
          false,
        ),
        gf: deserializeParam(
          data['gf'],
          ParamType.int,
          false,
        ),
        ga: deserializeParam(
          data['ga'],
          ParamType.int,
          false,
        ),
        gd: deserializeParam(
          data['gd'],
          ParamType.int,
          false,
        ),
        points: deserializeParam(
          data['points'],
          ParamType.int,
          false,
        ),
        teamRef: deserializeParam(
          data['teamRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['teams'],
        ),
      );

  @override
  String toString() => 'PointsTableStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PointsTableStruct &&
        teamName == other.teamName &&
        teamIcon == other.teamIcon &&
        played == other.played &&
        won == other.won &&
        lost == other.lost &&
        draw == other.draw &&
        gf == other.gf &&
        ga == other.ga &&
        gd == other.gd &&
        points == other.points &&
        teamRef == other.teamRef;
  }

  @override
  int get hashCode => const ListEquality().hash([
        teamName,
        teamIcon,
        played,
        won,
        lost,
        draw,
        gf,
        ga,
        gd,
        points,
        teamRef
      ]);
}

PointsTableStruct createPointsTableStruct({
  String? teamName,
  String? teamIcon,
  int? played,
  int? won,
  int? lost,
  int? draw,
  int? gf,
  int? ga,
  int? gd,
  int? points,
  DocumentReference? teamRef,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PointsTableStruct(
      teamName: teamName,
      teamIcon: teamIcon,
      played: played,
      won: won,
      lost: lost,
      draw: draw,
      gf: gf,
      ga: ga,
      gd: gd,
      points: points,
      teamRef: teamRef,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PointsTableStruct? updatePointsTableStruct(
  PointsTableStruct? pointsTable, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    pointsTable
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPointsTableStructData(
  Map<String, dynamic> firestoreData,
  PointsTableStruct? pointsTable,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (pointsTable == null) {
    return;
  }
  if (pointsTable.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && pointsTable.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final pointsTableData =
      getPointsTableFirestoreData(pointsTable, forFieldValue);
  final nestedData =
      pointsTableData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = pointsTable.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPointsTableFirestoreData(
  PointsTableStruct? pointsTable, [
  bool forFieldValue = false,
]) {
  if (pointsTable == null) {
    return {};
  }
  final firestoreData = mapToFirestore(pointsTable.toMap());

  // Add any Firestore field values
  pointsTable.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPointsTableListFirestoreData(
  List<PointsTableStruct>? pointsTables,
) =>
    pointsTables?.map((e) => getPointsTableFirestoreData(e, true)).toList() ??
    [];
