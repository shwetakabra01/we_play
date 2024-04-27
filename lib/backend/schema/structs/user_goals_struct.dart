// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserGoalsStruct extends FFFirebaseStruct {
  UserGoalsStruct({
    DocumentReference? userRef,
    int? goals,
    DocumentReference? team,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userRef = userRef,
        _goals = goals,
        _team = team,
        super(firestoreUtilData);

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  set userRef(DocumentReference? val) => _userRef = val;
  bool hasUserRef() => _userRef != null;

  // "goals" field.
  int? _goals;
  int get goals => _goals ?? 0;
  set goals(int? val) => _goals = val;
  void incrementGoals(int amount) => _goals = goals + amount;
  bool hasGoals() => _goals != null;

  // "team" field.
  DocumentReference? _team;
  DocumentReference? get team => _team;
  set team(DocumentReference? val) => _team = val;
  bool hasTeam() => _team != null;

  static UserGoalsStruct fromMap(Map<String, dynamic> data) => UserGoalsStruct(
        userRef: data['userRef'] as DocumentReference?,
        goals: castToType<int>(data['goals']),
        team: data['team'] as DocumentReference?,
      );

  static UserGoalsStruct? maybeFromMap(dynamic data) => data is Map
      ? UserGoalsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'userRef': _userRef,
        'goals': _goals,
        'team': _team,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userRef': serializeParam(
          _userRef,
          ParamType.DocumentReference,
        ),
        'goals': serializeParam(
          _goals,
          ParamType.int,
        ),
        'team': serializeParam(
          _team,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static UserGoalsStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserGoalsStruct(
        userRef: deserializeParam(
          data['userRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        goals: deserializeParam(
          data['goals'],
          ParamType.int,
          false,
        ),
        team: deserializeParam(
          data['team'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['teams'],
        ),
      );

  @override
  String toString() => 'UserGoalsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserGoalsStruct &&
        userRef == other.userRef &&
        goals == other.goals &&
        team == other.team;
  }

  @override
  int get hashCode => const ListEquality().hash([userRef, goals, team]);
}

UserGoalsStruct createUserGoalsStruct({
  DocumentReference? userRef,
  int? goals,
  DocumentReference? team,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserGoalsStruct(
      userRef: userRef,
      goals: goals,
      team: team,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserGoalsStruct? updateUserGoalsStruct(
  UserGoalsStruct? userGoals, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userGoals
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserGoalsStructData(
  Map<String, dynamic> firestoreData,
  UserGoalsStruct? userGoals,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userGoals == null) {
    return;
  }
  if (userGoals.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userGoals.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userGoalsData = getUserGoalsFirestoreData(userGoals, forFieldValue);
  final nestedData = userGoalsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userGoals.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserGoalsFirestoreData(
  UserGoalsStruct? userGoals, [
  bool forFieldValue = false,
]) {
  if (userGoals == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userGoals.toMap());

  // Add any Firestore field values
  userGoals.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserGoalsListFirestoreData(
  List<UserGoalsStruct>? userGoalss,
) =>
    userGoalss?.map((e) => getUserGoalsFirestoreData(e, true)).toList() ?? [];
