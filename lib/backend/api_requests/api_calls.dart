import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start WePlayApi Group Code

class WePlayApiGroup {
  static String getBaseUrl({
    String? jwtToken = '',
  }) =>
      'https://us-central1-play-e84eb.cloudfunctions.net/wePlayApi/api/';
  static Map<String, String> headers = {
    'Authorization': 'Bearer [jwt_token]',
  };
  static GetMyEventsCall getMyEventsCall = GetMyEventsCall();
  static GetEventByIdCall getEventByIdCall = GetEventByIdCall();
  static CreateEventCall createEventCall = CreateEventCall();
  static GetEventsCall getEventsCall = GetEventsCall();
  static GetStaticDataCall getStaticDataCall = GetStaticDataCall();
  static JoinEventCall joinEventCall = JoinEventCall();
  static LeaveEventCall leaveEventCall = LeaveEventCall();
  static RemoveParticipantCall removeParticipantCall = RemoveParticipantCall();
  static CancelEventCall cancelEventCall = CancelEventCall();
  static TestSchedulerCall testSchedulerCall = TestSchedulerCall();
  static GetVenuesCall getVenuesCall = GetVenuesCall();
  static MakePublicCall makePublicCall = MakePublicCall();
  static CreateUserCall createUserCall = CreateUserCall();
  static UploadImageCall uploadImageCall = UploadImageCall();
  static GenerateFaceIdCall generateFaceIdCall = GenerateFaceIdCall();
  static GetImagesCall getImagesCall = GetImagesCall();
  static GetImagesAWSCall getImagesAWSCall = GetImagesAWSCall();
  static ToggleStarImageCall toggleStarImageCall = ToggleStarImageCall();
}

class GetMyEventsCall {
  Future<ApiCallResponse> call({
    bool? futureEvents,
    bool? organizer,
    bool? mySports,
    bool? participant,
    List<String>? sportsList,
    bool? cancelledEvents,
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );
    final sports = _serializeList(sportsList);

    return ApiManager.instance.makeApiCall(
      callName: 'Get  My Events',
      apiUrl: '${baseUrl}getMyEvents',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {
        'futureEvents': futureEvents,
        'organizer': organizer,
        'mySports': mySports,
        'participant': participant,
        'sports': sports,
        'cancelledEvents': cancelledEvents,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetEventByIdCall {
  Future<ApiCallResponse> call({
    String? eventId = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Event By Id',
      apiUrl: '${baseUrl}getEvent/${eventId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateEventCall {
  Future<ApiCallResponse> call({
    String? venueId = '',
    int? playersCapacity,
    String? sport = '',
    String? eventDate = '',
    int? numberOfTurfs,
    bool? splitCost,
    String? bookingTime = '',
    int? turfId,
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "venueId": "${venueId}",
  "playersCapacity": ${playersCapacity},
  "sport": "${sport}",
  "eventDate": "${eventDate}",
  "numberOfTurfs": ${numberOfTurfs},
  "splitCost": ${splitCost},
  "bookingTime": "${bookingTime}",
  "turfId": ${turfId}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Create Event',
      apiUrl: '${baseUrl}createEvent',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetEventsCall {
  Future<ApiCallResponse> call({
    bool? futureEvents,
    bool? mySports,
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Events',
      apiUrl: '${baseUrl}getEvents',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {
        'mySports': mySports,
        'futureEvents': futureEvents,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetStaticDataCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Static Data',
      apiUrl: '${baseUrl}getStaticData',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class JoinEventCall {
  Future<ApiCallResponse> call({
    String? eventId = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Join Event',
      apiUrl: '${baseUrl}joinEvent/${eventId}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class LeaveEventCall {
  Future<ApiCallResponse> call({
    String? eventId = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Leave Event',
      apiUrl: '${baseUrl}leaveEvent/${eventId}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class RemoveParticipantCall {
  Future<ApiCallResponse> call({
    String? eventId = '',
    String? userId = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "eventId": "${eventId}",
  "userId": "${userId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Remove Participant',
      apiUrl: '${baseUrl}removeParticipant',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class CancelEventCall {
  Future<ApiCallResponse> call({
    String? eventId = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Cancel Event',
      apiUrl: '${baseUrl}cancelEvent/${eventId}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class TestSchedulerCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'test scheduler',
      apiUrl: '${baseUrl}testSchedular',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetVenuesCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Venues',
      apiUrl: '${baseUrl}getVenues',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class MakePublicCall {
  Future<ApiCallResponse> call({
    String? eventId = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Make Public',
      apiUrl: '${baseUrl}makePublic/${eventId}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateUserCall {
  Future<ApiCallResponse> call({
    String? gender = '',
    String? displayName = '',
    String? phoneNumber = '',
    String? emailId = '',
    String? instagramId = '',
    String? dateOfBirth = '',
    String? profilePic = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "displayName": "${displayName}",
  "phoneNumber": "${phoneNumber}",
  "gender": "${gender}",
  "emailId": "${emailId}",
  "instagramId": "${instagramId}",
  "dateOfBirth": "${dateOfBirth}",
  "profilePic": "${profilePic}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Create User',
      apiUrl: '${baseUrl}createUser',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  String? userId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.userId''',
      ));
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class UploadImageCall {
  Future<ApiCallResponse> call({
    String? file = '',
    String? fileName = '',
    String? teamEventId = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "fileData": "${file}",
  "fileName": "${fileName}",
  "teamEventId": "${teamEventId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Upload Image',
      apiUrl: '${baseUrl}uploadImage',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GenerateFaceIdCall {
  Future<ApiCallResponse> call({
    String? fileName = '',
    String? fileData = '',
    String? userId = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "fileData": "${fileData}",
  "fileName": "${fileName}",
  "userId": "${userId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Generate Face Id',
      apiUrl: '${baseUrl}generateFaceId',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetImagesCall {
  Future<ApiCallResponse> call({
    String? type = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Get Images',
      apiUrl: '${baseUrl}getImages',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {
        'type': type,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetImagesAWSCall {
  Future<ApiCallResponse> call({
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getImages AWS',
      apiUrl: '${baseUrl}/getImagesfromAWS',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ToggleStarImageCall {
  Future<ApiCallResponse> call({
    String? imageId = '',
    String? jwtToken = '',
  }) async {
    final baseUrl = WePlayApiGroup.getBaseUrl(
      jwtToken: jwtToken,
    );

    final ffApiRequestBody = '''
{
  "imageId": "${imageId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'toggle Star Image',
      apiUrl: '${baseUrl}toggleStarImage',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${jwtToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/// End WePlayApi Group Code

class DistanceMatrixApiCall {
  static Future<ApiCallResponse> call({
    String? destinations = '',
    String? origins = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'DistanceMatrixApi',
      apiUrl: 'https://maps.googleapis.com/maps/api/distancematrix/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'destinations': destinations,
        'origins': origins,
        'key': "AIzaSyDdgymSCRjSdHi6yN_8c5935byszzvBXGo",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class SetCurrentAddressCall {
  static Future<ApiCallResponse> call({
    String? latlng = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'SetCurrentAddress',
      apiUrl: 'https://maps.googleapis.com/maps/api/geocode/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'latlng': latlng,
        'key': "AIzaSyDdgymSCRjSdHi6yN_8c5935byszzvBXGo",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? detailedAddress(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].formatted_address''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? area(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].address_components[:].short_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
