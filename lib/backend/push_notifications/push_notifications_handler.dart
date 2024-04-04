import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'CompleteProfile': ParameterData.none(),
  'OnboardingViews': (data) async => ParameterData(
        allParams: {
          'mobileNumber': getParameter<String>(data, 'mobileNumber'),
        },
      ),
  'OnboardingViewsLoggedIn': (data) async => ParameterData(
        allParams: {
          'mobileNumber': getParameter<String>(data, 'mobileNumber'),
        },
      ),
  'HomeNav': ParameterData.none(),
  'Play': (data) async => ParameterData(
        allParams: {
          'filterEvents': getParameter<String>(data, 'filterEvents'),
          'showBack': getParameter<bool>(data, 'showBack'),
        },
      ),
  'GameInfo': (data) async => ParameterData(
        allParams: {
          'eventRef': getParameter<DocumentReference>(data, 'eventRef'),
          'fromPage': getParameter<String>(data, 'fromPage'),
          'eventId': getParameter<String>(data, 'eventId'),
        },
      ),
  'Venues': ParameterData.none(),
  'VenueInfo': (data) async => ParameterData(
        allParams: {
          'venueRef': getParameter<DocumentReference>(data, 'venueRef'),
        },
      ),
  'VenueBooking': (data) async => ParameterData(
        allParams: {
          'venue': await getDocumentParameter<VenueRecord>(
              data, 'venue', VenueRecord.fromSnapshot),
        },
      ),
  'Admin': ParameterData.none(),
  'InvitePlayer': (data) async => ParameterData(
        allParams: {
          'event': await getDocumentParameter<EventsRecord>(
              data, 'event', EventsRecord.fromSnapshot),
        },
      ),
  'Fixtures': ParameterData.none(),
  'CreateTeam': ParameterData.none(),
  'UpdateTeam': (data) async => ParameterData(
        allParams: {
          'pageTitle': getParameter<String>(data, 'pageTitle'),
          'team': await getDocumentParameter<TeamsRecord>(
              data, 'team', TeamsRecord.fromSnapshot),
        },
      ),
  'FixtureDetails': (data) async => ParameterData(
        allParams: {
          'fixtureRef': getParameter<DocumentReference>(data, 'fixtureRef'),
          'team1': await getDocumentParameter<TeamsRecord>(
              data, 'team1', TeamsRecord.fromSnapshot),
          'team2': await getDocumentParameter<TeamsRecord>(
              data, 'team2', TeamsRecord.fromSnapshot),
        },
      ),
  'TeamDetails': (data) async => ParameterData(
        allParams: {
          'teamP': await getDocumentParameter<TeamsRecord>(
              data, 'teamP', TeamsRecord.fromSnapshot),
        },
      ),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
