import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StaticDataRecord extends FirestoreRecord {
  StaticDataRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "value" field.
  String? _value;
  String get value => _value ?? '';
  bool hasValue() => _value != null;

  void _initializeFields() {
    _category = snapshotData['category'] as String?;
    _value = snapshotData['value'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('staticData');

  static Stream<StaticDataRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StaticDataRecord.fromSnapshot(s));

  static Future<StaticDataRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StaticDataRecord.fromSnapshot(s));

  static StaticDataRecord fromSnapshot(DocumentSnapshot snapshot) =>
      StaticDataRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StaticDataRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StaticDataRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StaticDataRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StaticDataRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStaticDataRecordData({
  String? category,
  String? value,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'category': category,
      'value': value,
    }.withoutNulls,
  );

  return firestoreData;
}

class StaticDataRecordDocumentEquality implements Equality<StaticDataRecord> {
  const StaticDataRecordDocumentEquality();

  @override
  bool equals(StaticDataRecord? e1, StaticDataRecord? e2) {
    return e1?.category == e2?.category && e1?.value == e2?.value;
  }

  @override
  int hash(StaticDataRecord? e) =>
      const ListEquality().hash([e?.category, e?.value]);

  @override
  bool isValidKey(Object? o) => o is StaticDataRecord;
}
