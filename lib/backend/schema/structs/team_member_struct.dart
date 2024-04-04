// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TeamMemberStruct extends FFFirebaseStruct {
  TeamMemberStruct({
    String? memberRole,
    DocumentReference? memberRef,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _memberRole = memberRole,
        _memberRef = memberRef,
        super(firestoreUtilData);

  // "memberRole" field.
  String? _memberRole;
  String get memberRole => _memberRole ?? '';
  set memberRole(String? val) => _memberRole = val;
  bool hasMemberRole() => _memberRole != null;

  // "memberRef" field.
  DocumentReference? _memberRef;
  DocumentReference? get memberRef => _memberRef;
  set memberRef(DocumentReference? val) => _memberRef = val;
  bool hasMemberRef() => _memberRef != null;

  static TeamMemberStruct fromMap(Map<String, dynamic> data) =>
      TeamMemberStruct(
        memberRole: data['memberRole'] as String?,
        memberRef: data['memberRef'] as DocumentReference?,
      );

  static TeamMemberStruct? maybeFromMap(dynamic data) => data is Map
      ? TeamMemberStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'memberRole': _memberRole,
        'memberRef': _memberRef,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'memberRole': serializeParam(
          _memberRole,
          ParamType.String,
        ),
        'memberRef': serializeParam(
          _memberRef,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static TeamMemberStruct fromSerializableMap(Map<String, dynamic> data) =>
      TeamMemberStruct(
        memberRole: deserializeParam(
          data['memberRole'],
          ParamType.String,
          false,
        ),
        memberRef: deserializeParam(
          data['memberRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
      );

  @override
  String toString() => 'TeamMemberStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TeamMemberStruct &&
        memberRole == other.memberRole &&
        memberRef == other.memberRef;
  }

  @override
  int get hashCode => const ListEquality().hash([memberRole, memberRef]);
}

TeamMemberStruct createTeamMemberStruct({
  String? memberRole,
  DocumentReference? memberRef,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TeamMemberStruct(
      memberRole: memberRole,
      memberRef: memberRef,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TeamMemberStruct? updateTeamMemberStruct(
  TeamMemberStruct? teamMember, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    teamMember
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTeamMemberStructData(
  Map<String, dynamic> firestoreData,
  TeamMemberStruct? teamMember,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (teamMember == null) {
    return;
  }
  if (teamMember.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && teamMember.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final teamMemberData = getTeamMemberFirestoreData(teamMember, forFieldValue);
  final nestedData = teamMemberData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = teamMember.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTeamMemberFirestoreData(
  TeamMemberStruct? teamMember, [
  bool forFieldValue = false,
]) {
  if (teamMember == null) {
    return {};
  }
  final firestoreData = mapToFirestore(teamMember.toMap());

  // Add any Firestore field values
  teamMember.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTeamMemberListFirestoreData(
  List<TeamMemberStruct>? teamMembers,
) =>
    teamMembers?.map((e) => getTeamMemberFirestoreData(e, true)).toList() ?? [];
