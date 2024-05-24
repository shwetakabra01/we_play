import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "favorites" field.
  List<int>? _favorites;
  List<int> get favorites => _favorites ?? const [];
  bool hasFavorites() => _favorites != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  bool hasGender() => _gender != null;

  // "preferredSports" field.
  List<String>? _preferredSports;
  List<String> get preferredSports => _preferredSports ?? const [];
  bool hasPreferredSports() => _preferredSports != null;

  // "walletBalance" field.
  double? _walletBalance;
  double get walletBalance => _walletBalance ?? 0.0;
  bool hasWalletBalance() => _walletBalance != null;

  // "userRole" field.
  UserRole? _userRole;
  UserRole? get userRole => _userRole;
  bool hasUserRole() => _userRole != null;

  // "preferredLocation" field.
  LatLng? _preferredLocation;
  LatLng? get preferredLocation => _preferredLocation;
  bool hasPreferredLocation() => _preferredLocation != null;

  // "locationText" field.
  String? _locationText;
  String get locationText => _locationText ?? '';
  bool hasLocationText() => _locationText != null;

  // "dateOfBirth" field.
  DateTime? _dateOfBirth;
  DateTime? get dateOfBirth => _dateOfBirth;
  bool hasDateOfBirth() => _dateOfBirth != null;

  // "instagramId" field.
  String? _instagramId;
  String get instagramId => _instagramId ?? '';
  bool hasInstagramId() => _instagramId != null;

  // "shortDescription" field.
  String? _shortDescription;
  String get shortDescription => _shortDescription ?? '';
  bool hasShortDescription() => _shortDescription != null;

  // "last_active_time" field.
  DateTime? _lastActiveTime;
  DateTime? get lastActiveTime => _lastActiveTime;
  bool hasLastActiveTime() => _lastActiveTime != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "userFaceRef" field.
  DocumentReference? _userFaceRef;
  DocumentReference? get userFaceRef => _userFaceRef;
  bool hasUserFaceRef() => _userFaceRef != null;

  // "faceId" field.
  String? _faceId;
  String get faceId => _faceId ?? '';
  bool hasFaceId() => _faceId != null;

  // "starImages" field.
  List<String>? _starImages;
  List<String> get starImages => _starImages ?? const [];
  bool hasStarImages() => _starImages != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _favorites = getDataList(snapshotData['favorites']);
    _phoneNumber = snapshotData['phone_number'] as String?;
    _gender = snapshotData['gender'] as String?;
    _preferredSports = getDataList(snapshotData['preferredSports']);
    _walletBalance = castToType<double>(snapshotData['walletBalance']);
    _userRole = deserializeEnum<UserRole>(snapshotData['userRole']);
    _preferredLocation = snapshotData['preferredLocation'] as LatLng?;
    _locationText = snapshotData['locationText'] as String?;
    _dateOfBirth = snapshotData['dateOfBirth'] as DateTime?;
    _instagramId = snapshotData['instagramId'] as String?;
    _shortDescription = snapshotData['shortDescription'] as String?;
    _lastActiveTime = snapshotData['last_active_time'] as DateTime?;
    _role = snapshotData['role'] as String?;
    _title = snapshotData['title'] as String?;
    _userFaceRef = snapshotData['userFaceRef'] as DocumentReference?;
    _faceId = snapshotData['faceId'] as String?;
    _starImages = getDataList(snapshotData['starImages']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? gender,
  double? walletBalance,
  UserRole? userRole,
  LatLng? preferredLocation,
  String? locationText,
  DateTime? dateOfBirth,
  String? instagramId,
  String? shortDescription,
  DateTime? lastActiveTime,
  String? role,
  String? title,
  DocumentReference? userFaceRef,
  String? faceId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'gender': gender,
      'walletBalance': walletBalance,
      'userRole': userRole,
      'preferredLocation': preferredLocation,
      'locationText': locationText,
      'dateOfBirth': dateOfBirth,
      'instagramId': instagramId,
      'shortDescription': shortDescription,
      'last_active_time': lastActiveTime,
      'role': role,
      'title': title,
      'userFaceRef': userFaceRef,
      'faceId': faceId,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        listEquality.equals(e1?.favorites, e2?.favorites) &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.gender == e2?.gender &&
        listEquality.equals(e1?.preferredSports, e2?.preferredSports) &&
        e1?.walletBalance == e2?.walletBalance &&
        e1?.userRole == e2?.userRole &&
        e1?.preferredLocation == e2?.preferredLocation &&
        e1?.locationText == e2?.locationText &&
        e1?.dateOfBirth == e2?.dateOfBirth &&
        e1?.instagramId == e2?.instagramId &&
        e1?.shortDescription == e2?.shortDescription &&
        e1?.lastActiveTime == e2?.lastActiveTime &&
        e1?.role == e2?.role &&
        e1?.title == e2?.title &&
        e1?.userFaceRef == e2?.userFaceRef &&
        e1?.faceId == e2?.faceId &&
        listEquality.equals(e1?.starImages, e2?.starImages);
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.favorites,
        e?.phoneNumber,
        e?.gender,
        e?.preferredSports,
        e?.walletBalance,
        e?.userRole,
        e?.preferredLocation,
        e?.locationText,
        e?.dateOfBirth,
        e?.instagramId,
        e?.shortDescription,
        e?.lastActiveTime,
        e?.role,
        e?.title,
        e?.userFaceRef,
        e?.faceId,
        e?.starImages
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
