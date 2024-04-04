// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventWoStruct extends FFFirebaseStruct {
  EventWoStruct({
    String? name,
    String? location,
    double? bookingCost,
    String? sport,
    String? turfSize,
    double? organizerRefund,
    String? status,
    bool? splitCost,
    int? numberOfTurfs,
    int? playersCapacity,
    String? appliedOffer,
    String? bookingTime,
    String? eventDescription,
    String? venue,
    List<String>? participantsRefs,
    String? organizer,
    List<EventParticipantWoStruct>? participants,
    String? date,
    String? eventId,
    String? distanceFromUserText,
    double? distanceFromUser,
    String? durationFromUser,
    int? numberOfGuests,
    List<String>? photos,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _location = location,
        _bookingCost = bookingCost,
        _sport = sport,
        _turfSize = turfSize,
        _organizerRefund = organizerRefund,
        _status = status,
        _splitCost = splitCost,
        _numberOfTurfs = numberOfTurfs,
        _playersCapacity = playersCapacity,
        _appliedOffer = appliedOffer,
        _bookingTime = bookingTime,
        _eventDescription = eventDescription,
        _venue = venue,
        _participantsRefs = participantsRefs,
        _organizer = organizer,
        _participants = participants,
        _date = date,
        _eventId = eventId,
        _distanceFromUserText = distanceFromUserText,
        _distanceFromUser = distanceFromUser,
        _durationFromUser = durationFromUser,
        _numberOfGuests = numberOfGuests,
        _photos = photos,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  set location(String? val) => _location = val;
  bool hasLocation() => _location != null;

  // "bookingCost" field.
  double? _bookingCost;
  double get bookingCost => _bookingCost ?? 0.0;
  set bookingCost(double? val) => _bookingCost = val;
  void incrementBookingCost(double amount) =>
      _bookingCost = bookingCost + amount;
  bool hasBookingCost() => _bookingCost != null;

  // "sport" field.
  String? _sport;
  String get sport => _sport ?? '';
  set sport(String? val) => _sport = val;
  bool hasSport() => _sport != null;

  // "turfSize" field.
  String? _turfSize;
  String get turfSize => _turfSize ?? '';
  set turfSize(String? val) => _turfSize = val;
  bool hasTurfSize() => _turfSize != null;

  // "organizerRefund" field.
  double? _organizerRefund;
  double get organizerRefund => _organizerRefund ?? 0.0;
  set organizerRefund(double? val) => _organizerRefund = val;
  void incrementOrganizerRefund(double amount) =>
      _organizerRefund = organizerRefund + amount;
  bool hasOrganizerRefund() => _organizerRefund != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;
  bool hasStatus() => _status != null;

  // "splitCost" field.
  bool? _splitCost;
  bool get splitCost => _splitCost ?? false;
  set splitCost(bool? val) => _splitCost = val;
  bool hasSplitCost() => _splitCost != null;

  // "numberOfTurfs" field.
  int? _numberOfTurfs;
  int get numberOfTurfs => _numberOfTurfs ?? 0;
  set numberOfTurfs(int? val) => _numberOfTurfs = val;
  void incrementNumberOfTurfs(int amount) =>
      _numberOfTurfs = numberOfTurfs + amount;
  bool hasNumberOfTurfs() => _numberOfTurfs != null;

  // "playersCapacity" field.
  int? _playersCapacity;
  int get playersCapacity => _playersCapacity ?? 0;
  set playersCapacity(int? val) => _playersCapacity = val;
  void incrementPlayersCapacity(int amount) =>
      _playersCapacity = playersCapacity + amount;
  bool hasPlayersCapacity() => _playersCapacity != null;

  // "appliedOffer" field.
  String? _appliedOffer;
  String get appliedOffer => _appliedOffer ?? '';
  set appliedOffer(String? val) => _appliedOffer = val;
  bool hasAppliedOffer() => _appliedOffer != null;

  // "bookingTime" field.
  String? _bookingTime;
  String get bookingTime => _bookingTime ?? '';
  set bookingTime(String? val) => _bookingTime = val;
  bool hasBookingTime() => _bookingTime != null;

  // "eventDescription" field.
  String? _eventDescription;
  String get eventDescription => _eventDescription ?? '';
  set eventDescription(String? val) => _eventDescription = val;
  bool hasEventDescription() => _eventDescription != null;

  // "venue" field.
  String? _venue;
  String get venue => _venue ?? '';
  set venue(String? val) => _venue = val;
  bool hasVenue() => _venue != null;

  // "participantsRefs" field.
  List<String>? _participantsRefs;
  List<String> get participantsRefs => _participantsRefs ?? const [];
  set participantsRefs(List<String>? val) => _participantsRefs = val;
  void updateParticipantsRefs(Function(List<String>) updateFn) =>
      updateFn(_participantsRefs ??= []);
  bool hasParticipantsRefs() => _participantsRefs != null;

  // "organizer" field.
  String? _organizer;
  String get organizer => _organizer ?? '';
  set organizer(String? val) => _organizer = val;
  bool hasOrganizer() => _organizer != null;

  // "participants" field.
  List<EventParticipantWoStruct>? _participants;
  List<EventParticipantWoStruct> get participants => _participants ?? const [];
  set participants(List<EventParticipantWoStruct>? val) => _participants = val;
  void updateParticipants(Function(List<EventParticipantWoStruct>) updateFn) =>
      updateFn(_participants ??= []);
  bool hasParticipants() => _participants != null;

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;
  bool hasDate() => _date != null;

  // "eventId" field.
  String? _eventId;
  String get eventId => _eventId ?? '';
  set eventId(String? val) => _eventId = val;
  bool hasEventId() => _eventId != null;

  // "distanceFromUserText" field.
  String? _distanceFromUserText;
  String get distanceFromUserText => _distanceFromUserText ?? '';
  set distanceFromUserText(String? val) => _distanceFromUserText = val;
  bool hasDistanceFromUserText() => _distanceFromUserText != null;

  // "distanceFromUser" field.
  double? _distanceFromUser;
  double get distanceFromUser => _distanceFromUser ?? 0.0;
  set distanceFromUser(double? val) => _distanceFromUser = val;
  void incrementDistanceFromUser(double amount) =>
      _distanceFromUser = distanceFromUser + amount;
  bool hasDistanceFromUser() => _distanceFromUser != null;

  // "durationFromUser" field.
  String? _durationFromUser;
  String get durationFromUser => _durationFromUser ?? '';
  set durationFromUser(String? val) => _durationFromUser = val;
  bool hasDurationFromUser() => _durationFromUser != null;

  // "numberOfGuests" field.
  int? _numberOfGuests;
  int get numberOfGuests => _numberOfGuests ?? 0;
  set numberOfGuests(int? val) => _numberOfGuests = val;
  void incrementNumberOfGuests(int amount) =>
      _numberOfGuests = numberOfGuests + amount;
  bool hasNumberOfGuests() => _numberOfGuests != null;

  // "photos" field.
  List<String>? _photos;
  List<String> get photos => _photos ?? const [];
  set photos(List<String>? val) => _photos = val;
  void updatePhotos(Function(List<String>) updateFn) =>
      updateFn(_photos ??= []);
  bool hasPhotos() => _photos != null;

  static EventWoStruct fromMap(Map<String, dynamic> data) => EventWoStruct(
        name: data['name'] as String?,
        location: data['location'] as String?,
        bookingCost: castToType<double>(data['bookingCost']),
        sport: data['sport'] as String?,
        turfSize: data['turfSize'] as String?,
        organizerRefund: castToType<double>(data['organizerRefund']),
        status: data['status'] as String?,
        splitCost: data['splitCost'] as bool?,
        numberOfTurfs: castToType<int>(data['numberOfTurfs']),
        playersCapacity: castToType<int>(data['playersCapacity']),
        appliedOffer: data['appliedOffer'] as String?,
        bookingTime: data['bookingTime'] as String?,
        eventDescription: data['eventDescription'] as String?,
        venue: data['venue'] as String?,
        participantsRefs: getDataList(data['participantsRefs']),
        organizer: data['organizer'] as String?,
        participants: getStructList(
          data['participants'],
          EventParticipantWoStruct.fromMap,
        ),
        date: data['date'] as String?,
        eventId: data['eventId'] as String?,
        distanceFromUserText: data['distanceFromUserText'] as String?,
        distanceFromUser: castToType<double>(data['distanceFromUser']),
        durationFromUser: data['durationFromUser'] as String?,
        numberOfGuests: castToType<int>(data['numberOfGuests']),
        photos: getDataList(data['photos']),
      );

  static EventWoStruct? maybeFromMap(dynamic data) =>
      data is Map ? EventWoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'location': _location,
        'bookingCost': _bookingCost,
        'sport': _sport,
        'turfSize': _turfSize,
        'organizerRefund': _organizerRefund,
        'status': _status,
        'splitCost': _splitCost,
        'numberOfTurfs': _numberOfTurfs,
        'playersCapacity': _playersCapacity,
        'appliedOffer': _appliedOffer,
        'bookingTime': _bookingTime,
        'eventDescription': _eventDescription,
        'venue': _venue,
        'participantsRefs': _participantsRefs,
        'organizer': _organizer,
        'participants': _participants?.map((e) => e.toMap()).toList(),
        'date': _date,
        'eventId': _eventId,
        'distanceFromUserText': _distanceFromUserText,
        'distanceFromUser': _distanceFromUser,
        'durationFromUser': _durationFromUser,
        'numberOfGuests': _numberOfGuests,
        'photos': _photos,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'location': serializeParam(
          _location,
          ParamType.String,
        ),
        'bookingCost': serializeParam(
          _bookingCost,
          ParamType.double,
        ),
        'sport': serializeParam(
          _sport,
          ParamType.String,
        ),
        'turfSize': serializeParam(
          _turfSize,
          ParamType.String,
        ),
        'organizerRefund': serializeParam(
          _organizerRefund,
          ParamType.double,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'splitCost': serializeParam(
          _splitCost,
          ParamType.bool,
        ),
        'numberOfTurfs': serializeParam(
          _numberOfTurfs,
          ParamType.int,
        ),
        'playersCapacity': serializeParam(
          _playersCapacity,
          ParamType.int,
        ),
        'appliedOffer': serializeParam(
          _appliedOffer,
          ParamType.String,
        ),
        'bookingTime': serializeParam(
          _bookingTime,
          ParamType.String,
        ),
        'eventDescription': serializeParam(
          _eventDescription,
          ParamType.String,
        ),
        'venue': serializeParam(
          _venue,
          ParamType.String,
        ),
        'participantsRefs': serializeParam(
          _participantsRefs,
          ParamType.String,
          true,
        ),
        'organizer': serializeParam(
          _organizer,
          ParamType.String,
        ),
        'participants': serializeParam(
          _participants,
          ParamType.DataStruct,
          true,
        ),
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'eventId': serializeParam(
          _eventId,
          ParamType.String,
        ),
        'distanceFromUserText': serializeParam(
          _distanceFromUserText,
          ParamType.String,
        ),
        'distanceFromUser': serializeParam(
          _distanceFromUser,
          ParamType.double,
        ),
        'durationFromUser': serializeParam(
          _durationFromUser,
          ParamType.String,
        ),
        'numberOfGuests': serializeParam(
          _numberOfGuests,
          ParamType.int,
        ),
        'photos': serializeParam(
          _photos,
          ParamType.String,
          true,
        ),
      }.withoutNulls;

  static EventWoStruct fromSerializableMap(Map<String, dynamic> data) =>
      EventWoStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        location: deserializeParam(
          data['location'],
          ParamType.String,
          false,
        ),
        bookingCost: deserializeParam(
          data['bookingCost'],
          ParamType.double,
          false,
        ),
        sport: deserializeParam(
          data['sport'],
          ParamType.String,
          false,
        ),
        turfSize: deserializeParam(
          data['turfSize'],
          ParamType.String,
          false,
        ),
        organizerRefund: deserializeParam(
          data['organizerRefund'],
          ParamType.double,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        splitCost: deserializeParam(
          data['splitCost'],
          ParamType.bool,
          false,
        ),
        numberOfTurfs: deserializeParam(
          data['numberOfTurfs'],
          ParamType.int,
          false,
        ),
        playersCapacity: deserializeParam(
          data['playersCapacity'],
          ParamType.int,
          false,
        ),
        appliedOffer: deserializeParam(
          data['appliedOffer'],
          ParamType.String,
          false,
        ),
        bookingTime: deserializeParam(
          data['bookingTime'],
          ParamType.String,
          false,
        ),
        eventDescription: deserializeParam(
          data['eventDescription'],
          ParamType.String,
          false,
        ),
        venue: deserializeParam(
          data['venue'],
          ParamType.String,
          false,
        ),
        participantsRefs: deserializeParam<String>(
          data['participantsRefs'],
          ParamType.String,
          true,
        ),
        organizer: deserializeParam(
          data['organizer'],
          ParamType.String,
          false,
        ),
        participants: deserializeStructParam<EventParticipantWoStruct>(
          data['participants'],
          ParamType.DataStruct,
          true,
          structBuilder: EventParticipantWoStruct.fromSerializableMap,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        eventId: deserializeParam(
          data['eventId'],
          ParamType.String,
          false,
        ),
        distanceFromUserText: deserializeParam(
          data['distanceFromUserText'],
          ParamType.String,
          false,
        ),
        distanceFromUser: deserializeParam(
          data['distanceFromUser'],
          ParamType.double,
          false,
        ),
        durationFromUser: deserializeParam(
          data['durationFromUser'],
          ParamType.String,
          false,
        ),
        numberOfGuests: deserializeParam(
          data['numberOfGuests'],
          ParamType.int,
          false,
        ),
        photos: deserializeParam<String>(
          data['photos'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'EventWoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is EventWoStruct &&
        name == other.name &&
        location == other.location &&
        bookingCost == other.bookingCost &&
        sport == other.sport &&
        turfSize == other.turfSize &&
        organizerRefund == other.organizerRefund &&
        status == other.status &&
        splitCost == other.splitCost &&
        numberOfTurfs == other.numberOfTurfs &&
        playersCapacity == other.playersCapacity &&
        appliedOffer == other.appliedOffer &&
        bookingTime == other.bookingTime &&
        eventDescription == other.eventDescription &&
        venue == other.venue &&
        listEquality.equals(participantsRefs, other.participantsRefs) &&
        organizer == other.organizer &&
        listEquality.equals(participants, other.participants) &&
        date == other.date &&
        eventId == other.eventId &&
        distanceFromUserText == other.distanceFromUserText &&
        distanceFromUser == other.distanceFromUser &&
        durationFromUser == other.durationFromUser &&
        numberOfGuests == other.numberOfGuests &&
        listEquality.equals(photos, other.photos);
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        location,
        bookingCost,
        sport,
        turfSize,
        organizerRefund,
        status,
        splitCost,
        numberOfTurfs,
        playersCapacity,
        appliedOffer,
        bookingTime,
        eventDescription,
        venue,
        participantsRefs,
        organizer,
        participants,
        date,
        eventId,
        distanceFromUserText,
        distanceFromUser,
        durationFromUser,
        numberOfGuests,
        photos
      ]);
}

EventWoStruct createEventWoStruct({
  String? name,
  String? location,
  double? bookingCost,
  String? sport,
  String? turfSize,
  double? organizerRefund,
  String? status,
  bool? splitCost,
  int? numberOfTurfs,
  int? playersCapacity,
  String? appliedOffer,
  String? bookingTime,
  String? eventDescription,
  String? venue,
  String? organizer,
  String? date,
  String? eventId,
  String? distanceFromUserText,
  double? distanceFromUser,
  String? durationFromUser,
  int? numberOfGuests,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EventWoStruct(
      name: name,
      location: location,
      bookingCost: bookingCost,
      sport: sport,
      turfSize: turfSize,
      organizerRefund: organizerRefund,
      status: status,
      splitCost: splitCost,
      numberOfTurfs: numberOfTurfs,
      playersCapacity: playersCapacity,
      appliedOffer: appliedOffer,
      bookingTime: bookingTime,
      eventDescription: eventDescription,
      venue: venue,
      organizer: organizer,
      date: date,
      eventId: eventId,
      distanceFromUserText: distanceFromUserText,
      distanceFromUser: distanceFromUser,
      durationFromUser: durationFromUser,
      numberOfGuests: numberOfGuests,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EventWoStruct? updateEventWoStruct(
  EventWoStruct? eventWo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    eventWo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEventWoStructData(
  Map<String, dynamic> firestoreData,
  EventWoStruct? eventWo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (eventWo == null) {
    return;
  }
  if (eventWo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && eventWo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final eventWoData = getEventWoFirestoreData(eventWo, forFieldValue);
  final nestedData = eventWoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = eventWo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEventWoFirestoreData(
  EventWoStruct? eventWo, [
  bool forFieldValue = false,
]) {
  if (eventWo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(eventWo.toMap());

  // Add any Firestore field values
  eventWo.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEventWoListFirestoreData(
  List<EventWoStruct>? eventWos,
) =>
    eventWos?.map((e) => getEventWoFirestoreData(e, true)).toList() ?? [];
