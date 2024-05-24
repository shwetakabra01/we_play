import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class S3ImageDirectoryRecord extends FirestoreRecord {
  S3ImageDirectoryRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "imageIdReko" field.
  String? _imageIdReko;
  String get imageIdReko => _imageIdReko ?? '';
  bool hasImageIdReko() => _imageIdReko != null;

  // "fileName" field.
  String? _fileName;
  String get fileName => _fileName ?? '';
  bool hasFileName() => _fileName != null;

  // "s3Url" field.
  String? _s3Url;
  String get s3Url => _s3Url ?? '';
  bool hasS3Url() => _s3Url != null;

  // "s3ImageName" field.
  String? _s3ImageName;
  String get s3ImageName => _s3ImageName ?? '';
  bool hasS3ImageName() => _s3ImageName != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "createdOn" field.
  DateTime? _createdOn;
  DateTime? get createdOn => _createdOn;
  bool hasCreatedOn() => _createdOn != null;

  void _initializeFields() {
    _imageIdReko = snapshotData['imageIdReko'] as String?;
    _fileName = snapshotData['fileName'] as String?;
    _s3Url = snapshotData['s3Url'] as String?;
    _s3ImageName = snapshotData['s3ImageName'] as String?;
    _category = snapshotData['category'] as String?;
    _createdOn = snapshotData['createdOn'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('S3ImageDirectory');

  static Stream<S3ImageDirectoryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => S3ImageDirectoryRecord.fromSnapshot(s));

  static Future<S3ImageDirectoryRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => S3ImageDirectoryRecord.fromSnapshot(s));

  static S3ImageDirectoryRecord fromSnapshot(DocumentSnapshot snapshot) =>
      S3ImageDirectoryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static S3ImageDirectoryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      S3ImageDirectoryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'S3ImageDirectoryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is S3ImageDirectoryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createS3ImageDirectoryRecordData({
  String? imageIdReko,
  String? fileName,
  String? s3Url,
  String? s3ImageName,
  String? category,
  DateTime? createdOn,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'imageIdReko': imageIdReko,
      'fileName': fileName,
      's3Url': s3Url,
      's3ImageName': s3ImageName,
      'category': category,
      'createdOn': createdOn,
    }.withoutNulls,
  );

  return firestoreData;
}

class S3ImageDirectoryRecordDocumentEquality
    implements Equality<S3ImageDirectoryRecord> {
  const S3ImageDirectoryRecordDocumentEquality();

  @override
  bool equals(S3ImageDirectoryRecord? e1, S3ImageDirectoryRecord? e2) {
    return e1?.imageIdReko == e2?.imageIdReko &&
        e1?.fileName == e2?.fileName &&
        e1?.s3Url == e2?.s3Url &&
        e1?.s3ImageName == e2?.s3ImageName &&
        e1?.category == e2?.category &&
        e1?.createdOn == e2?.createdOn;
  }

  @override
  int hash(S3ImageDirectoryRecord? e) => const ListEquality().hash([
        e?.imageIdReko,
        e?.fileName,
        e?.s3Url,
        e?.s3ImageName,
        e?.category,
        e?.createdOn
      ]);

  @override
  bool isValidKey(Object? o) => o is S3ImageDirectoryRecord;
}
