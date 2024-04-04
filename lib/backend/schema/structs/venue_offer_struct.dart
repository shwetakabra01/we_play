// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VenueOfferStruct extends FFFirebaseStruct {
  VenueOfferStruct({
    String? descriptionLine1,
    String? descriptionLine2,
    ApplicationRule? applicationRule,
    int? minBookingTime,
    int? startTimeIndex,
    int? endTimeIndex,
    Discount? discountType,
    double? discountRate,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _descriptionLine1 = descriptionLine1,
        _descriptionLine2 = descriptionLine2,
        _applicationRule = applicationRule,
        _minBookingTime = minBookingTime,
        _startTimeIndex = startTimeIndex,
        _endTimeIndex = endTimeIndex,
        _discountType = discountType,
        _discountRate = discountRate,
        super(firestoreUtilData);

  // "descriptionLine1" field.
  String? _descriptionLine1;
  String get descriptionLine1 => _descriptionLine1 ?? '';
  set descriptionLine1(String? val) => _descriptionLine1 = val;
  bool hasDescriptionLine1() => _descriptionLine1 != null;

  // "descriptionLine2" field.
  String? _descriptionLine2;
  String get descriptionLine2 => _descriptionLine2 ?? '';
  set descriptionLine2(String? val) => _descriptionLine2 = val;
  bool hasDescriptionLine2() => _descriptionLine2 != null;

  // "applicationRule" field.
  ApplicationRule? _applicationRule;
  ApplicationRule? get applicationRule => _applicationRule;
  set applicationRule(ApplicationRule? val) => _applicationRule = val;
  bool hasApplicationRule() => _applicationRule != null;

  // "minBookingTime" field.
  int? _minBookingTime;
  int get minBookingTime => _minBookingTime ?? 0;
  set minBookingTime(int? val) => _minBookingTime = val;
  void incrementMinBookingTime(int amount) =>
      _minBookingTime = minBookingTime + amount;
  bool hasMinBookingTime() => _minBookingTime != null;

  // "startTimeIndex" field.
  int? _startTimeIndex;
  int get startTimeIndex => _startTimeIndex ?? 0;
  set startTimeIndex(int? val) => _startTimeIndex = val;
  void incrementStartTimeIndex(int amount) =>
      _startTimeIndex = startTimeIndex + amount;
  bool hasStartTimeIndex() => _startTimeIndex != null;

  // "endTimeIndex" field.
  int? _endTimeIndex;
  int get endTimeIndex => _endTimeIndex ?? 0;
  set endTimeIndex(int? val) => _endTimeIndex = val;
  void incrementEndTimeIndex(int amount) =>
      _endTimeIndex = endTimeIndex + amount;
  bool hasEndTimeIndex() => _endTimeIndex != null;

  // "discountType" field.
  Discount? _discountType;
  Discount? get discountType => _discountType;
  set discountType(Discount? val) => _discountType = val;
  bool hasDiscountType() => _discountType != null;

  // "discountRate" field.
  double? _discountRate;
  double get discountRate => _discountRate ?? 0.0;
  set discountRate(double? val) => _discountRate = val;
  void incrementDiscountRate(double amount) =>
      _discountRate = discountRate + amount;
  bool hasDiscountRate() => _discountRate != null;

  static VenueOfferStruct fromMap(Map<String, dynamic> data) =>
      VenueOfferStruct(
        descriptionLine1: data['descriptionLine1'] as String?,
        descriptionLine2: data['descriptionLine2'] as String?,
        applicationRule:
            deserializeEnum<ApplicationRule>(data['applicationRule']),
        minBookingTime: castToType<int>(data['minBookingTime']),
        startTimeIndex: castToType<int>(data['startTimeIndex']),
        endTimeIndex: castToType<int>(data['endTimeIndex']),
        discountType: deserializeEnum<Discount>(data['discountType']),
        discountRate: castToType<double>(data['discountRate']),
      );

  static VenueOfferStruct? maybeFromMap(dynamic data) => data is Map
      ? VenueOfferStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'descriptionLine1': _descriptionLine1,
        'descriptionLine2': _descriptionLine2,
        'applicationRule': _applicationRule?.serialize(),
        'minBookingTime': _minBookingTime,
        'startTimeIndex': _startTimeIndex,
        'endTimeIndex': _endTimeIndex,
        'discountType': _discountType?.serialize(),
        'discountRate': _discountRate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'descriptionLine1': serializeParam(
          _descriptionLine1,
          ParamType.String,
        ),
        'descriptionLine2': serializeParam(
          _descriptionLine2,
          ParamType.String,
        ),
        'applicationRule': serializeParam(
          _applicationRule,
          ParamType.Enum,
        ),
        'minBookingTime': serializeParam(
          _minBookingTime,
          ParamType.int,
        ),
        'startTimeIndex': serializeParam(
          _startTimeIndex,
          ParamType.int,
        ),
        'endTimeIndex': serializeParam(
          _endTimeIndex,
          ParamType.int,
        ),
        'discountType': serializeParam(
          _discountType,
          ParamType.Enum,
        ),
        'discountRate': serializeParam(
          _discountRate,
          ParamType.double,
        ),
      }.withoutNulls;

  static VenueOfferStruct fromSerializableMap(Map<String, dynamic> data) =>
      VenueOfferStruct(
        descriptionLine1: deserializeParam(
          data['descriptionLine1'],
          ParamType.String,
          false,
        ),
        descriptionLine2: deserializeParam(
          data['descriptionLine2'],
          ParamType.String,
          false,
        ),
        applicationRule: deserializeParam<ApplicationRule>(
          data['applicationRule'],
          ParamType.Enum,
          false,
        ),
        minBookingTime: deserializeParam(
          data['minBookingTime'],
          ParamType.int,
          false,
        ),
        startTimeIndex: deserializeParam(
          data['startTimeIndex'],
          ParamType.int,
          false,
        ),
        endTimeIndex: deserializeParam(
          data['endTimeIndex'],
          ParamType.int,
          false,
        ),
        discountType: deserializeParam<Discount>(
          data['discountType'],
          ParamType.Enum,
          false,
        ),
        discountRate: deserializeParam(
          data['discountRate'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'VenueOfferStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is VenueOfferStruct &&
        descriptionLine1 == other.descriptionLine1 &&
        descriptionLine2 == other.descriptionLine2 &&
        applicationRule == other.applicationRule &&
        minBookingTime == other.minBookingTime &&
        startTimeIndex == other.startTimeIndex &&
        endTimeIndex == other.endTimeIndex &&
        discountType == other.discountType &&
        discountRate == other.discountRate;
  }

  @override
  int get hashCode => const ListEquality().hash([
        descriptionLine1,
        descriptionLine2,
        applicationRule,
        minBookingTime,
        startTimeIndex,
        endTimeIndex,
        discountType,
        discountRate
      ]);
}

VenueOfferStruct createVenueOfferStruct({
  String? descriptionLine1,
  String? descriptionLine2,
  ApplicationRule? applicationRule,
  int? minBookingTime,
  int? startTimeIndex,
  int? endTimeIndex,
  Discount? discountType,
  double? discountRate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    VenueOfferStruct(
      descriptionLine1: descriptionLine1,
      descriptionLine2: descriptionLine2,
      applicationRule: applicationRule,
      minBookingTime: minBookingTime,
      startTimeIndex: startTimeIndex,
      endTimeIndex: endTimeIndex,
      discountType: discountType,
      discountRate: discountRate,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

VenueOfferStruct? updateVenueOfferStruct(
  VenueOfferStruct? venueOffer, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    venueOffer
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addVenueOfferStructData(
  Map<String, dynamic> firestoreData,
  VenueOfferStruct? venueOffer,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (venueOffer == null) {
    return;
  }
  if (venueOffer.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && venueOffer.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final venueOfferData = getVenueOfferFirestoreData(venueOffer, forFieldValue);
  final nestedData = venueOfferData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = venueOffer.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getVenueOfferFirestoreData(
  VenueOfferStruct? venueOffer, [
  bool forFieldValue = false,
]) {
  if (venueOffer == null) {
    return {};
  }
  final firestoreData = mapToFirestore(venueOffer.toMap());

  // Add any Firestore field values
  venueOffer.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getVenueOfferListFirestoreData(
  List<VenueOfferStruct>? venueOffers,
) =>
    venueOffers?.map((e) => getVenueOfferFirestoreData(e, true)).toList() ?? [];
