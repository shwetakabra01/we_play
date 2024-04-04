import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VenueRecord extends FirestoreRecord {
  VenueRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "cost" field.
  double? _cost;
  double get cost => _cost ?? 0.0;
  bool hasCost() => _cost != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "shortAddress" field.
  String? _shortAddress;
  String get shortAddress => _shortAddress ?? '';
  bool hasShortAddress() => _shortAddress != null;

  // "availableSports" field.
  List<String>? _availableSports;
  List<String> get availableSports => _availableSports ?? const [];
  bool hasAvailableSports() => _availableSports != null;

  // "photos" field.
  List<String>? _photos;
  List<String> get photos => _photos ?? const [];
  bool hasPhotos() => _photos != null;

  // "aboutLines" field.
  List<IconDescriptionStruct>? _aboutLines;
  List<IconDescriptionStruct> get aboutLines => _aboutLines ?? const [];
  bool hasAboutLines() => _aboutLines != null;

  // "amenities" field.
  List<IconDescriptionStruct>? _amenities;
  List<IconDescriptionStruct> get amenities => _amenities ?? const [];
  bool hasAmenities() => _amenities != null;

  // "contactNumber1" field.
  String? _contactNumber1;
  String get contactNumber1 => _contactNumber1 ?? '';
  bool hasContactNumber1() => _contactNumber1 != null;

  // "contactNumber2" field.
  String? _contactNumber2;
  String get contactNumber2 => _contactNumber2 ?? '';
  bool hasContactNumber2() => _contactNumber2 != null;

  // "turfs" field.
  List<TurfStruct>? _turfs;
  List<TurfStruct> get turfs => _turfs ?? const [];
  bool hasTurfs() => _turfs != null;

  // "avgRatings" field.
  double? _avgRatings;
  double get avgRatings => _avgRatings ?? 0.0;
  bool hasAvgRatings() => _avgRatings != null;

  // "availableOffers" field.
  List<VenueOfferStruct>? _availableOffers;
  List<VenueOfferStruct> get availableOffers => _availableOffers ?? const [];
  bool hasAvailableOffers() => _availableOffers != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "locationCoOrdinates" field.
  LatLng? _locationCoOrdinates;
  LatLng? get locationCoOrdinates => _locationCoOrdinates;
  bool hasLocationCoOrdinates() => _locationCoOrdinates != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _cost = castToType<double>(snapshotData['cost']);
    _address = snapshotData['address'] as String?;
    _shortAddress = snapshotData['shortAddress'] as String?;
    _availableSports = getDataList(snapshotData['availableSports']);
    _photos = getDataList(snapshotData['photos']);
    _aboutLines = getStructList(
      snapshotData['aboutLines'],
      IconDescriptionStruct.fromMap,
    );
    _amenities = getStructList(
      snapshotData['amenities'],
      IconDescriptionStruct.fromMap,
    );
    _contactNumber1 = snapshotData['contactNumber1'] as String?;
    _contactNumber2 = snapshotData['contactNumber2'] as String?;
    _turfs = getStructList(
      snapshotData['turfs'],
      TurfStruct.fromMap,
    );
    _avgRatings = castToType<double>(snapshotData['avgRatings']);
    _availableOffers = getStructList(
      snapshotData['availableOffers'],
      VenueOfferStruct.fromMap,
    );
    _location = snapshotData['location'] as String?;
    _locationCoOrdinates = snapshotData['locationCoOrdinates'] as LatLng?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Venue');

  static Stream<VenueRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => VenueRecord.fromSnapshot(s));

  static Future<VenueRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => VenueRecord.fromSnapshot(s));

  static VenueRecord fromSnapshot(DocumentSnapshot snapshot) => VenueRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static VenueRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      VenueRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'VenueRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is VenueRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createVenueRecordData({
  String? name,
  double? cost,
  String? address,
  String? shortAddress,
  String? contactNumber1,
  String? contactNumber2,
  double? avgRatings,
  String? location,
  LatLng? locationCoOrdinates,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'cost': cost,
      'address': address,
      'shortAddress': shortAddress,
      'contactNumber1': contactNumber1,
      'contactNumber2': contactNumber2,
      'avgRatings': avgRatings,
      'location': location,
      'locationCoOrdinates': locationCoOrdinates,
    }.withoutNulls,
  );

  return firestoreData;
}

class VenueRecordDocumentEquality implements Equality<VenueRecord> {
  const VenueRecordDocumentEquality();

  @override
  bool equals(VenueRecord? e1, VenueRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.cost == e2?.cost &&
        e1?.address == e2?.address &&
        e1?.shortAddress == e2?.shortAddress &&
        listEquality.equals(e1?.availableSports, e2?.availableSports) &&
        listEquality.equals(e1?.photos, e2?.photos) &&
        listEquality.equals(e1?.aboutLines, e2?.aboutLines) &&
        listEquality.equals(e1?.amenities, e2?.amenities) &&
        e1?.contactNumber1 == e2?.contactNumber1 &&
        e1?.contactNumber2 == e2?.contactNumber2 &&
        listEquality.equals(e1?.turfs, e2?.turfs) &&
        e1?.avgRatings == e2?.avgRatings &&
        listEquality.equals(e1?.availableOffers, e2?.availableOffers) &&
        e1?.location == e2?.location &&
        e1?.locationCoOrdinates == e2?.locationCoOrdinates;
  }

  @override
  int hash(VenueRecord? e) => const ListEquality().hash([
        e?.name,
        e?.cost,
        e?.address,
        e?.shortAddress,
        e?.availableSports,
        e?.photos,
        e?.aboutLines,
        e?.amenities,
        e?.contactNumber1,
        e?.contactNumber2,
        e?.turfs,
        e?.avgRatings,
        e?.availableOffers,
        e?.location,
        e?.locationCoOrdinates
      ]);

  @override
  bool isValidKey(Object? o) => o is VenueRecord;
}
