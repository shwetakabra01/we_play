import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventsRecord extends FirestoreRecord {
  EventsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "organizer" field.
  DocumentReference? _organizer;
  DocumentReference? get organizer => _organizer;
  bool hasOrganizer() => _organizer != null;

  // "eventDescription" field.
  String? _eventDescription;
  String get eventDescription => _eventDescription ?? '';
  bool hasEventDescription() => _eventDescription != null;

  // "playersCapacity" field.
  int? _playersCapacity;
  int get playersCapacity => _playersCapacity ?? 0;
  bool hasPlayersCapacity() => _playersCapacity != null;

  // "participants" field.
  List<EventParticipantStruct>? _participants;
  List<EventParticipantStruct> get participants => _participants ?? const [];
  bool hasParticipants() => _participants != null;

  // "participantsRefs" field.
  List<DocumentReference>? _participantsRefs;
  List<DocumentReference> get participantsRefs => _participantsRefs ?? const [];
  bool hasParticipantsRefs() => _participantsRefs != null;

  // "venue" field.
  DocumentReference? _venue;
  DocumentReference? get venue => _venue;
  bool hasVenue() => _venue != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "sport" field.
  String? _sport;
  String get sport => _sport ?? '';
  bool hasSport() => _sport != null;

  // "numberOfTurfs" field.
  int? _numberOfTurfs;
  int get numberOfTurfs => _numberOfTurfs ?? 0;
  bool hasNumberOfTurfs() => _numberOfTurfs != null;

  // "bookingCost" field.
  double? _bookingCost;
  double get bookingCost => _bookingCost ?? 0.0;
  bool hasBookingCost() => _bookingCost != null;

  // "turfSize" field.
  String? _turfSize;
  String get turfSize => _turfSize ?? '';
  bool hasTurfSize() => _turfSize != null;

  // "splitCost" field.
  bool? _splitCost;
  bool get splitCost => _splitCost ?? false;
  bool hasSplitCost() => _splitCost != null;

  // "bookingTime" field.
  String? _bookingTime;
  String get bookingTime => _bookingTime ?? '';
  bool hasBookingTime() => _bookingTime != null;

  // "appliedOffer" field.
  String? _appliedOffer;
  String get appliedOffer => _appliedOffer ?? '';
  bool hasAppliedOffer() => _appliedOffer != null;

  // "createdOn" field.
  DateTime? _createdOn;
  DateTime? get createdOn => _createdOn;
  bool hasCreatedOn() => _createdOn != null;

  // "numberOfGuests" field.
  int? _numberOfGuests;
  int get numberOfGuests => _numberOfGuests ?? 0;
  bool hasNumberOfGuests() => _numberOfGuests != null;

  // "privateEvent" field.
  bool? _privateEvent;
  bool get privateEvent => _privateEvent ?? false;
  bool hasPrivateEvent() => _privateEvent != null;

  // "invitedParticipants" field.
  List<DocumentReference>? _invitedParticipants;
  List<DocumentReference> get invitedParticipants =>
      _invitedParticipants ?? const [];
  bool hasInvitedParticipants() => _invitedParticipants != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _location = snapshotData['location'] as String?;
    _organizer = snapshotData['organizer'] as DocumentReference?;
    _eventDescription = snapshotData['eventDescription'] as String?;
    _playersCapacity = castToType<int>(snapshotData['playersCapacity']);
    _participants = getStructList(
      snapshotData['participants'],
      EventParticipantStruct.fromMap,
    );
    _participantsRefs = getDataList(snapshotData['participantsRefs']);
    _venue = snapshotData['venue'] as DocumentReference?;
    _status = snapshotData['status'] as String?;
    _sport = snapshotData['sport'] as String?;
    _numberOfTurfs = castToType<int>(snapshotData['numberOfTurfs']);
    _bookingCost = castToType<double>(snapshotData['bookingCost']);
    _turfSize = snapshotData['turfSize'] as String?;
    _splitCost = snapshotData['splitCost'] as bool?;
    _bookingTime = snapshotData['bookingTime'] as String?;
    _appliedOffer = snapshotData['appliedOffer'] as String?;
    _createdOn = snapshotData['createdOn'] as DateTime?;
    _numberOfGuests = castToType<int>(snapshotData['numberOfGuests']);
    _privateEvent = snapshotData['privateEvent'] as bool?;
    _invitedParticipants = getDataList(snapshotData['invitedParticipants']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventsRecord.fromSnapshot(s));

  static Future<EventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventsRecord.fromSnapshot(s));

  static EventsRecord fromSnapshot(DocumentSnapshot snapshot) => EventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventsRecordData({
  String? name,
  DateTime? date,
  String? location,
  DocumentReference? organizer,
  String? eventDescription,
  int? playersCapacity,
  DocumentReference? venue,
  String? status,
  String? sport,
  int? numberOfTurfs,
  double? bookingCost,
  String? turfSize,
  bool? splitCost,
  String? bookingTime,
  String? appliedOffer,
  DateTime? createdOn,
  int? numberOfGuests,
  bool? privateEvent,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'date': date,
      'location': location,
      'organizer': organizer,
      'eventDescription': eventDescription,
      'playersCapacity': playersCapacity,
      'venue': venue,
      'status': status,
      'sport': sport,
      'numberOfTurfs': numberOfTurfs,
      'bookingCost': bookingCost,
      'turfSize': turfSize,
      'splitCost': splitCost,
      'bookingTime': bookingTime,
      'appliedOffer': appliedOffer,
      'createdOn': createdOn,
      'numberOfGuests': numberOfGuests,
      'privateEvent': privateEvent,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventsRecordDocumentEquality implements Equality<EventsRecord> {
  const EventsRecordDocumentEquality();

  @override
  bool equals(EventsRecord? e1, EventsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.date == e2?.date &&
        e1?.location == e2?.location &&
        e1?.organizer == e2?.organizer &&
        e1?.eventDescription == e2?.eventDescription &&
        e1?.playersCapacity == e2?.playersCapacity &&
        listEquality.equals(e1?.participants, e2?.participants) &&
        listEquality.equals(e1?.participantsRefs, e2?.participantsRefs) &&
        e1?.venue == e2?.venue &&
        e1?.status == e2?.status &&
        e1?.sport == e2?.sport &&
        e1?.numberOfTurfs == e2?.numberOfTurfs &&
        e1?.bookingCost == e2?.bookingCost &&
        e1?.turfSize == e2?.turfSize &&
        e1?.splitCost == e2?.splitCost &&
        e1?.bookingTime == e2?.bookingTime &&
        e1?.appliedOffer == e2?.appliedOffer &&
        e1?.createdOn == e2?.createdOn &&
        e1?.numberOfGuests == e2?.numberOfGuests &&
        e1?.privateEvent == e2?.privateEvent &&
        listEquality.equals(e1?.invitedParticipants, e2?.invitedParticipants);
  }

  @override
  int hash(EventsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.date,
        e?.location,
        e?.organizer,
        e?.eventDescription,
        e?.playersCapacity,
        e?.participants,
        e?.participantsRefs,
        e?.venue,
        e?.status,
        e?.sport,
        e?.numberOfTurfs,
        e?.bookingCost,
        e?.turfSize,
        e?.splitCost,
        e?.bookingTime,
        e?.appliedOffer,
        e?.createdOn,
        e?.numberOfGuests,
        e?.privateEvent,
        e?.invitedParticipants
      ]);

  @override
  bool isValidKey(Object? o) => o is EventsRecord;
}
