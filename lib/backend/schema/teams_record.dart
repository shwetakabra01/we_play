import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TeamsRecord extends FirestoreRecord {
  TeamsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "teamIcon" field.
  String? _teamIcon;
  String get teamIcon => _teamIcon ?? '';
  bool hasTeamIcon() => _teamIcon != null;

  // "teamOwner" field.
  String? _teamOwner;
  String get teamOwner => _teamOwner ?? '';
  bool hasTeamOwner() => _teamOwner != null;

  // "won" field.
  int? _won;
  int get won => _won ?? 0;
  bool hasWon() => _won != null;

  // "draw" field.
  int? _draw;
  int get draw => _draw ?? 0;
  bool hasDraw() => _draw != null;

  // "lost" field.
  int? _lost;
  int get lost => _lost ?? 0;
  bool hasLost() => _lost != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  bool hasImages() => _images != null;

  // "videos" field.
  List<String>? _videos;
  List<String> get videos => _videos ?? const [];
  bool hasVideos() => _videos != null;

  // "memberRefs" field.
  List<DocumentReference>? _memberRefs;
  List<DocumentReference> get memberRefs => _memberRefs ?? const [];
  bool hasMemberRefs() => _memberRefs != null;

  // "members" field.
  List<TeamMemberStruct>? _members;
  List<TeamMemberStruct> get members => _members ?? const [];
  bool hasMembers() => _members != null;

  // "isDeleted" field.
  bool? _isDeleted;
  bool get isDeleted => _isDeleted ?? false;
  bool hasIsDeleted() => _isDeleted != null;

  // "teamFullName" field.
  String? _teamFullName;
  String get teamFullName => _teamFullName ?? '';
  bool hasTeamFullName() => _teamFullName != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _teamIcon = snapshotData['teamIcon'] as String?;
    _teamOwner = snapshotData['teamOwner'] as String?;
    _won = castToType<int>(snapshotData['won']);
    _draw = castToType<int>(snapshotData['draw']);
    _lost = castToType<int>(snapshotData['lost']);
    _images = getDataList(snapshotData['images']);
    _videos = getDataList(snapshotData['videos']);
    _memberRefs = getDataList(snapshotData['memberRefs']);
    _members = getStructList(
      snapshotData['members'],
      TeamMemberStruct.fromMap,
    );
    _isDeleted = snapshotData['isDeleted'] as bool?;
    _teamFullName = snapshotData['teamFullName'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('teams');

  static Stream<TeamsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TeamsRecord.fromSnapshot(s));

  static Future<TeamsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TeamsRecord.fromSnapshot(s));

  static TeamsRecord fromSnapshot(DocumentSnapshot snapshot) => TeamsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TeamsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TeamsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TeamsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TeamsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTeamsRecordData({
  String? name,
  String? teamIcon,
  String? teamOwner,
  int? won,
  int? draw,
  int? lost,
  bool? isDeleted,
  String? teamFullName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'teamIcon': teamIcon,
      'teamOwner': teamOwner,
      'won': won,
      'draw': draw,
      'lost': lost,
      'isDeleted': isDeleted,
      'teamFullName': teamFullName,
    }.withoutNulls,
  );

  return firestoreData;
}

class TeamsRecordDocumentEquality implements Equality<TeamsRecord> {
  const TeamsRecordDocumentEquality();

  @override
  bool equals(TeamsRecord? e1, TeamsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.teamIcon == e2?.teamIcon &&
        e1?.teamOwner == e2?.teamOwner &&
        e1?.won == e2?.won &&
        e1?.draw == e2?.draw &&
        e1?.lost == e2?.lost &&
        listEquality.equals(e1?.images, e2?.images) &&
        listEquality.equals(e1?.videos, e2?.videos) &&
        listEquality.equals(e1?.memberRefs, e2?.memberRefs) &&
        listEquality.equals(e1?.members, e2?.members) &&
        e1?.isDeleted == e2?.isDeleted &&
        e1?.teamFullName == e2?.teamFullName;
  }

  @override
  int hash(TeamsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.teamIcon,
        e?.teamOwner,
        e?.won,
        e?.draw,
        e?.lost,
        e?.images,
        e?.videos,
        e?.memberRefs,
        e?.members,
        e?.isDeleted,
        e?.teamFullName
      ]);

  @override
  bool isValidKey(Object? o) => o is TeamsRecord;
}
