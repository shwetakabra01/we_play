import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TransactionRecord extends FirestoreRecord {
  TransactionRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "transactionType" field.
  String? _transactionType;
  String get transactionType => _transactionType ?? '';
  bool hasTransactionType() => _transactionType != null;

  // "transactiontime" field.
  DateTime? _transactiontime;
  DateTime? get transactiontime => _transactiontime;
  bool hasTransactiontime() => _transactiontime != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  // "eventid" field.
  DocumentReference? _eventid;
  DocumentReference? get eventid => _eventid;
  bool hasEventid() => _eventid != null;

  // "status" field.
  bool? _status;
  bool get status => _status ?? false;
  bool hasStatus() => _status != null;

  // "userid" field.
  DocumentReference? _userid;
  DocumentReference? get userid => _userid;
  bool hasUserid() => _userid != null;

  // "errordetails" field.
  String? _errordetails;
  String get errordetails => _errordetails ?? '';
  bool hasErrordetails() => _errordetails != null;

  // "toUserId" field.
  DocumentReference? _toUserId;
  DocumentReference? get toUserId => _toUserId;
  bool hasToUserId() => _toUserId != null;

  // "toVenueId" field.
  DocumentReference? _toVenueId;
  DocumentReference? get toVenueId => _toVenueId;
  bool hasToVenueId() => _toVenueId != null;

  void _initializeFields() {
    _transactionType = snapshotData['transactionType'] as String?;
    _transactiontime = snapshotData['transactiontime'] as DateTime?;
    _amount = castToType<double>(snapshotData['amount']);
    _eventid = snapshotData['eventid'] as DocumentReference?;
    _status = snapshotData['status'] as bool?;
    _userid = snapshotData['userid'] as DocumentReference?;
    _errordetails = snapshotData['errordetails'] as String?;
    _toUserId = snapshotData['toUserId'] as DocumentReference?;
    _toVenueId = snapshotData['toVenueId'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('transaction');

  static Stream<TransactionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TransactionRecord.fromSnapshot(s));

  static Future<TransactionRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TransactionRecord.fromSnapshot(s));

  static TransactionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TransactionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TransactionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TransactionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TransactionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TransactionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTransactionRecordData({
  String? transactionType,
  DateTime? transactiontime,
  double? amount,
  DocumentReference? eventid,
  bool? status,
  DocumentReference? userid,
  String? errordetails,
  DocumentReference? toUserId,
  DocumentReference? toVenueId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'transactionType': transactionType,
      'transactiontime': transactiontime,
      'amount': amount,
      'eventid': eventid,
      'status': status,
      'userid': userid,
      'errordetails': errordetails,
      'toUserId': toUserId,
      'toVenueId': toVenueId,
    }.withoutNulls,
  );

  return firestoreData;
}

class TransactionRecordDocumentEquality implements Equality<TransactionRecord> {
  const TransactionRecordDocumentEquality();

  @override
  bool equals(TransactionRecord? e1, TransactionRecord? e2) {
    return e1?.transactionType == e2?.transactionType &&
        e1?.transactiontime == e2?.transactiontime &&
        e1?.amount == e2?.amount &&
        e1?.eventid == e2?.eventid &&
        e1?.status == e2?.status &&
        e1?.userid == e2?.userid &&
        e1?.errordetails == e2?.errordetails &&
        e1?.toUserId == e2?.toUserId &&
        e1?.toVenueId == e2?.toVenueId;
  }

  @override
  int hash(TransactionRecord? e) => const ListEquality().hash([
        e?.transactionType,
        e?.transactiontime,
        e?.amount,
        e?.eventid,
        e?.status,
        e?.userid,
        e?.errordetails,
        e?.toUserId,
        e?.toVenueId
      ]);

  @override
  bool isValidKey(Object? o) => o is TransactionRecord;
}
