// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ImageStruct extends FFFirebaseStruct {
  ImageStruct({
    String? imagePath,
    String? imageId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _imagePath = imagePath,
        _imageId = imageId,
        super(firestoreUtilData);

  // "imagePath" field.
  String? _imagePath;
  String get imagePath => _imagePath ?? '';
  set imagePath(String? val) => _imagePath = val;
  bool hasImagePath() => _imagePath != null;

  // "imageId" field.
  String? _imageId;
  String get imageId => _imageId ?? '';
  set imageId(String? val) => _imageId = val;
  bool hasImageId() => _imageId != null;

  static ImageStruct fromMap(Map<String, dynamic> data) => ImageStruct(
        imagePath: data['imagePath'] as String?,
        imageId: data['imageId'] as String?,
      );

  static ImageStruct? maybeFromMap(dynamic data) =>
      data is Map ? ImageStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'imagePath': _imagePath,
        'imageId': _imageId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'imagePath': serializeParam(
          _imagePath,
          ParamType.String,
        ),
        'imageId': serializeParam(
          _imageId,
          ParamType.String,
        ),
      }.withoutNulls;

  static ImageStruct fromSerializableMap(Map<String, dynamic> data) =>
      ImageStruct(
        imagePath: deserializeParam(
          data['imagePath'],
          ParamType.String,
          false,
        ),
        imageId: deserializeParam(
          data['imageId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ImageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ImageStruct &&
        imagePath == other.imagePath &&
        imageId == other.imageId;
  }

  @override
  int get hashCode => const ListEquality().hash([imagePath, imageId]);
}

ImageStruct createImageStruct({
  String? imagePath,
  String? imageId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ImageStruct(
      imagePath: imagePath,
      imageId: imageId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ImageStruct? updateImageStruct(
  ImageStruct? image, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    image
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addImageStructData(
  Map<String, dynamic> firestoreData,
  ImageStruct? image,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (image == null) {
    return;
  }
  if (image.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && image.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final imageData = getImageFirestoreData(image, forFieldValue);
  final nestedData = imageData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = image.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getImageFirestoreData(
  ImageStruct? image, [
  bool forFieldValue = false,
]) {
  if (image == null) {
    return {};
  }
  final firestoreData = mapToFirestore(image.toMap());

  // Add any Firestore field values
  image.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getImageListFirestoreData(
  List<ImageStruct>? images,
) =>
    images?.map((e) => getImageFirestoreData(e, true)).toList() ?? [];
