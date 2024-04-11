import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start WePlayApi Group Code

class WePlayApiGroup {
  static String baseUrl =
      'https://us-central1-playprod-2b863.cloudfunctions.net/wePlayApi/api/';
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
    final sports = _serializeList(sportsList);

    return ApiManager.instance.makeApiCall(
      callName: 'Get  My Events',
      apiUrl: '${WePlayApiGroup.baseUrl}getMyEvents',
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
    return ApiManager.instance.makeApiCall(
      callName: 'Get Event By Id',
      apiUrl: '${WePlayApiGroup.baseUrl}getEvent/${eventId}',
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
      apiUrl: '${WePlayApiGroup.baseUrl}createEvent',
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
    return ApiManager.instance.makeApiCall(
      callName: 'Get Events',
      apiUrl: '${WePlayApiGroup.baseUrl}getEvents',
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
    return ApiManager.instance.makeApiCall(
      callName: 'Get Static Data',
      apiUrl: '${WePlayApiGroup.baseUrl}getStaticData',
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
    return ApiManager.instance.makeApiCall(
      callName: 'Join Event',
      apiUrl: '${WePlayApiGroup.baseUrl}joinEvent/${eventId}',
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
    return ApiManager.instance.makeApiCall(
      callName: 'Leave Event',
      apiUrl: '${WePlayApiGroup.baseUrl}leaveEvent/${eventId}',
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
    final ffApiRequestBody = '''
{
  "eventId": "${eventId}",
  "userId": "${userId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Remove Participant',
      apiUrl: '${WePlayApiGroup.baseUrl}removeParticipant',
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
    return ApiManager.instance.makeApiCall(
      callName: 'Cancel Event',
      apiUrl: '${WePlayApiGroup.baseUrl}cancelEvent/${eventId}',
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
    return ApiManager.instance.makeApiCall(
      callName: 'test scheduler',
      apiUrl: '${WePlayApiGroup.baseUrl}testSchedular',
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
    return ApiManager.instance.makeApiCall(
      callName: 'Get Venues',
      apiUrl: '${WePlayApiGroup.baseUrl}getVenues',
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
    return ApiManager.instance.makeApiCall(
      callName: 'Make Public',
      apiUrl: '${WePlayApiGroup.baseUrl}makePublic/${eventId}',
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
    String? jwtToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "displayName": "${displayName}",
  "phoneNumber": "${phoneNumber}",
  "gender": "${gender}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Create User',
      apiUrl: '${WePlayApiGroup.baseUrl}createUser',
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
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
