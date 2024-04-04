import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TeamEventsRecord extends FirestoreRecord {
  TeamEventsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "team1" field.
  DocumentReference? _team1;
  DocumentReference? get team1 => _team1;
  bool hasTeam1() => _team1 != null;

  // "team2" field.
  DocumentReference? _team2;
  DocumentReference? get team2 => _team2;
  bool hasTeam2() => _team2 != null;

  // "eventDate" field.
  DateTime? _eventDate;
  DateTime? get eventDate => _eventDate;
  bool hasEventDate() => _eventDate != null;

  // "eventLocation" field.
  String? _eventLocation;
  String get eventLocation => _eventLocation ?? '';
  bool hasEventLocation() => _eventLocation != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  bool hasImages() => _images != null;

  // "videos" field.
  List<String>? _videos;
  List<String> get videos => _videos ?? const [];
  bool hasVideos() => _videos != null;

  // "goals" field.
  List<ScoreDetailsStruct>? _goals;
  List<ScoreDetailsStruct> get goals => _goals ?? const [];
  bool hasGoals() => _goals != null;

  // "corners" field.
  List<ScoreDetailsStruct>? _corners;
  List<ScoreDetailsStruct> get corners => _corners ?? const [];
  bool hasCorners() => _corners != null;

  // "yellowCard" field.
  List<ScoreDetailsStruct>? _yellowCard;
  List<ScoreDetailsStruct> get yellowCard => _yellowCard ?? const [];
  bool hasYellowCard() => _yellowCard != null;

  // "redCard" field.
  List<ScoreDetailsStruct>? _redCard;
  List<ScoreDetailsStruct> get redCard => _redCard ?? const [];
  bool hasRedCard() => _redCard != null;

  // "foul" field.
  List<ScoreDetailsStruct>? _foul;
  List<ScoreDetailsStruct> get foul => _foul ?? const [];
  bool hasFoul() => _foul != null;

  // "freeKick" field.
  List<ScoreDetailsStruct>? _freeKick;
  List<ScoreDetailsStruct> get freeKick => _freeKick ?? const [];
  bool hasFreeKick() => _freeKick != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "durationInMillis" field.
  int? _durationInMillis;
  int get durationInMillis => _durationInMillis ?? 0;
  bool hasDurationInMillis() => _durationInMillis != null;

  // "durationAtPause" field.
  int? _durationAtPause;
  int get durationAtPause => _durationAtPause ?? 0;
  bool hasDurationAtPause() => _durationAtPause != null;

  // "lastStartTime" field.
  DateTime? _lastStartTime;
  DateTime? get lastStartTime => _lastStartTime;
  bool hasLastStartTime() => _lastStartTime != null;

  // "startTime" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  bool hasEndTime() => _endTime != null;

  void _initializeFields() {
    _team1 = snapshotData['team1'] as DocumentReference?;
    _team2 = snapshotData['team2'] as DocumentReference?;
    _eventDate = snapshotData['eventDate'] as DateTime?;
    _eventLocation = snapshotData['eventLocation'] as String?;
    _images = getDataList(snapshotData['images']);
    _videos = getDataList(snapshotData['videos']);
    _goals = getStructList(
      snapshotData['goals'],
      ScoreDetailsStruct.fromMap,
    );
    _corners = getStructList(
      snapshotData['corners'],
      ScoreDetailsStruct.fromMap,
    );
    _yellowCard = getStructList(
      snapshotData['yellowCard'],
      ScoreDetailsStruct.fromMap,
    );
    _redCard = getStructList(
      snapshotData['redCard'],
      ScoreDetailsStruct.fromMap,
    );
    _foul = getStructList(
      snapshotData['foul'],
      ScoreDetailsStruct.fromMap,
    );
    _freeKick = getStructList(
      snapshotData['freeKick'],
      ScoreDetailsStruct.fromMap,
    );
    _status = snapshotData['status'] as String?;
    _durationInMillis = castToType<int>(snapshotData['durationInMillis']);
    _durationAtPause = castToType<int>(snapshotData['durationAtPause']);
    _lastStartTime = snapshotData['lastStartTime'] as DateTime?;
    _startTime = snapshotData['startTime'] as DateTime?;
    _endTime = snapshotData['endTime'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('teamEvents');

  static Stream<TeamEventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TeamEventsRecord.fromSnapshot(s));

  static Future<TeamEventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TeamEventsRecord.fromSnapshot(s));

  static TeamEventsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TeamEventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TeamEventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TeamEventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TeamEventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TeamEventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTeamEventsRecordData({
  DocumentReference? team1,
  DocumentReference? team2,
  DateTime? eventDate,
  String? eventLocation,
  String? status,
  int? durationInMillis,
  int? durationAtPause,
  DateTime? lastStartTime,
  DateTime? startTime,
  DateTime? endTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'team1': team1,
      'team2': team2,
      'eventDate': eventDate,
      'eventLocation': eventLocation,
      'status': status,
      'durationInMillis': durationInMillis,
      'durationAtPause': durationAtPause,
      'lastStartTime': lastStartTime,
      'startTime': startTime,
      'endTime': endTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class TeamEventsRecordDocumentEquality implements Equality<TeamEventsRecord> {
  const TeamEventsRecordDocumentEquality();

  @override
  bool equals(TeamEventsRecord? e1, TeamEventsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.team1 == e2?.team1 &&
        e1?.team2 == e2?.team2 &&
        e1?.eventDate == e2?.eventDate &&
        e1?.eventLocation == e2?.eventLocation &&
        listEquality.equals(e1?.images, e2?.images) &&
        listEquality.equals(e1?.videos, e2?.videos) &&
        listEquality.equals(e1?.goals, e2?.goals) &&
        listEquality.equals(e1?.corners, e2?.corners) &&
        listEquality.equals(e1?.yellowCard, e2?.yellowCard) &&
        listEquality.equals(e1?.redCard, e2?.redCard) &&
        listEquality.equals(e1?.foul, e2?.foul) &&
        listEquality.equals(e1?.freeKick, e2?.freeKick) &&
        e1?.status == e2?.status &&
        e1?.durationInMillis == e2?.durationInMillis &&
        e1?.durationAtPause == e2?.durationAtPause &&
        e1?.lastStartTime == e2?.lastStartTime &&
        e1?.startTime == e2?.startTime &&
        e1?.endTime == e2?.endTime;
  }

  @override
  int hash(TeamEventsRecord? e) => const ListEquality().hash([
        e?.team1,
        e?.team2,
        e?.eventDate,
        e?.eventLocation,
        e?.images,
        e?.videos,
        e?.goals,
        e?.corners,
        e?.yellowCard,
        e?.redCard,
        e?.foul,
        e?.freeKick,
        e?.status,
        e?.durationInMillis,
        e?.durationAtPause,
        e?.lastStartTime,
        e?.startTime,
        e?.endTime
      ]);

  @override
  bool isValidKey(Object? o) => o is TeamEventsRecord;
}
