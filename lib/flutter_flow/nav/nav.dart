import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : OnboardingViewsWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? NavBarPage()
              : OnboardingViewsWidget(),
        ),
        FFRoute(
          name: 'CompleteProfile',
          path: '/completeProfile',
          requireAuth: true,
          builder: (context, params) => CompleteProfileWidget(),
        ),
        FFRoute(
          name: 'OnboardingViews',
          path: '/onboardingViews',
          builder: (context, params) => OnboardingViewsWidget(
            mobileNumber: params.getParam(
              'mobileNumber',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'OnboardingViewsLoggedIn',
          path: '/onboardingViewsLoggedIn',
          requireAuth: true,
          builder: (context, params) => OnboardingViewsLoggedInWidget(
            mobileNumber: params.getParam(
              'mobileNumber',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'HomeNav',
          path: '/homeNav',
          requireAuth: true,
          builder: (context, params) => HomeNavWidget(),
        ),
        FFRoute(
          name: 'Play',
          path: '/play',
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Play')
              : PlayWidget(
                  filterEvents: params.getParam(
                    'filterEvents',
                    ParamType.String,
                  ),
                  showBack: params.getParam(
                    'showBack',
                    ParamType.bool,
                  ),
                ),
        ),
        FFRoute(
          name: 'GameInfo',
          path: '/gameInfo',
          requireAuth: true,
          builder: (context, params) => GameInfoWidget(
            eventRef: params.getParam(
              'eventRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['events'],
            ),
            fromPage: params.getParam(
              'fromPage',
              ParamType.String,
            ),
            eventId: params.getParam(
              'eventId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'Venues',
          path: '/venues',
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Venues')
              : VenuesWidget(),
        ),
        FFRoute(
          name: 'VenueInfo',
          path: '/venueInfo',
          requireAuth: true,
          builder: (context, params) => VenueInfoWidget(
            venueRef: params.getParam(
              'venueRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Venue'],
            ),
          ),
        ),
        FFRoute(
          name: 'VenueBooking',
          path: '/venueBooking',
          requireAuth: true,
          asyncParams: {
            'venue': getDoc(['Venue'], VenueRecord.fromSnapshot),
          },
          builder: (context, params) => VenueBookingWidget(
            venue: params.getParam(
              'venue',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'Admin',
          path: '/admin',
          requireAuth: true,
          builder: (context, params) => AdminWidget(),
        ),
        FFRoute(
          name: 'InvitePlayer',
          path: '/invitePlayer',
          requireAuth: true,
          asyncParams: {
            'event': getDoc(['events'], EventsRecord.fromSnapshot),
          },
          builder: (context, params) => InvitePlayerWidget(
            event: params.getParam(
              'event',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'Fixtures',
          path: '/fixtures',
          requireAuth: true,
          builder: (context, params) => FixturesWidget(),
        ),
        FFRoute(
          name: 'CreateTeam',
          path: '/createTeam',
          requireAuth: true,
          builder: (context, params) => CreateTeamWidget(),
        ),
        FFRoute(
          name: 'UpdateTeam',
          path: '/updateTeam',
          requireAuth: true,
          asyncParams: {
            'team': getDoc(['teams'], TeamsRecord.fromSnapshot),
          },
          builder: (context, params) => UpdateTeamWidget(
            pageTitle: params.getParam(
              'pageTitle',
              ParamType.String,
            ),
            team: params.getParam(
              'team',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'FixtureDetails',
          path: '/fixtureDetails',
          requireAuth: true,
          asyncParams: {
            'team1': getDoc(['teams'], TeamsRecord.fromSnapshot),
            'team2': getDoc(['teams'], TeamsRecord.fromSnapshot),
          },
          builder: (context, params) => FixtureDetailsWidget(
            fixtureRef: params.getParam(
              'fixtureRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['teamEvents'],
            ),
            team1: params.getParam(
              'team1',
              ParamType.Document,
            ),
            team2: params.getParam(
              'team2',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'TeamDetails',
          path: '/teamDetails',
          requireAuth: true,
          asyncParams: {
            'teamP': getDoc(['teams'], TeamsRecord.fromSnapshot),
          },
          builder: (context, params) => TeamDetailsWidget(
            teamP: params.getParam(
              'teamP',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'HomeNavCopy',
          path: '/homeNavCopy',
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'HomeNavCopy')
              : HomeNavCopyWidget(),
        ),
        FFRoute(
          name: 'chat_2_Details',
          path: '/chat2Details',
          requireAuth: true,
          asyncParams: {
            'chatRef': getDoc(['chats'], ChatsRecord.fromSnapshot),
          },
          builder: (context, params) => Chat2DetailsWidget(
            chatRef: params.getParam(
              'chatRef',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'chat_2_main',
          path: '/chat2Main',
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'chat_2_main')
              : Chat2MainWidget(),
        ),
        FFRoute(
          name: 'chat_2_InviteUsers',
          path: '/chat2InviteUsers',
          requireAuth: true,
          asyncParams: {
            'chatRef': getDoc(['chats'], ChatsRecord.fromSnapshot),
          },
          builder: (context, params) => Chat2InviteUsersWidget(
            chatRef: params.getParam(
              'chatRef',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'image_Details',
          path: '/imageDetails',
          requireAuth: true,
          asyncParams: {
            'chatMessage':
                getDoc(['chat_messages'], ChatMessagesRecord.fromSnapshot),
          },
          builder: (context, params) => ImageDetailsWidget(
            chatMessage: params.getParam(
              'chatMessage',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'Collections',
          path: '/collections',
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Collections')
              : CollectionsWidget(),
        ),
        FFRoute(
          name: 'Gallery',
          path: '/gallery',
          requireAuth: true,
          builder: (context, params) => GalleryWidget(
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            queryType: params.getParam(
              'queryType',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'GalleryCopy',
          path: '/galleryCopy',
          requireAuth: true,
          builder: (context, params) => GalleryCopyWidget(
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            queryType: params.getParam(
              'queryType',
              ParamType.String,
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/onboardingViews';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
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
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
