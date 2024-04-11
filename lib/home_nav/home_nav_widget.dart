import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/location_set_widget.dart';
import '/components/profile_bottom_sheet_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_nav_model.dart';
export 'home_nav_model.dart';

class HomeNavWidget extends StatefulWidget {
  const HomeNavWidget({super.key});

  @override
  State<HomeNavWidget> createState() => _HomeNavWidgetState();
}

class _HomeNavWidgetState extends State<HomeNavWidget> {
  late HomeNavModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeNavModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.userDocument =
          await UsersRecord.getDocumentOnce(currentUserReference!);
      if ((_model.userDocument?.email == null ||
              _model.userDocument?.email == '') ||
          (_model.userDocument?.displayName == null ||
              _model.userDocument?.displayName == '') ||
          (_model.userDocument?.gender == null ||
              _model.userDocument?.gender == '')) {
        context.pushNamed('OnboardingViewsLoggedIn');
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TeamsRecord>>(
      stream: queryTeamsRecord(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<TeamsRecord> homeNavTeamsRecordList = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
              automaticallyImplyLeading: false,
              title: AuthUserStreamWidget(
                builder: (context) => FFButtonWidget(
                  onPressed: () async {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return GestureDetector(
                          onTap: () => _model.unfocusNode.canRequestFocus
                              ? FocusScope.of(context)
                                  .requestFocus(_model.unfocusNode)
                              : FocusScope.of(context).unfocus(),
                          child: Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: LocationSetWidget(),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  text: valueOrDefault<String>(
                    valueOrDefault(currentUserDocument?.locationText, ''),
                    'Select Location',
                  ),
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primaryBtnText,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Roboto',
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              actions: [
                AuthUserStreamWidget(
                  builder: (context) => StreamBuilder<List<EventsRecord>>(
                    stream: queryEventsRecord(
                      queryBuilder: (eventsRecord) => eventsRecord
                          .where(
                            'date',
                            isGreaterThanOrEqualTo: getCurrentTimestamp,
                          )
                          .whereIn(
                              'sport',
                              (currentUserDocument?.preferredSports?.toList() ??
                                  []))
                          .where(
                            'status',
                            isEqualTo: 'In Progress',
                          ),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }
                      List<EventsRecord> badgeEventsRecordList = snapshot.data!;
                      return badges.Badge(
                        badgeContent: Text(
                          badgeEventsRecordList.length.toString(),
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Roboto',
                                    fontSize: 10.0,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        showBadge: badgeEventsRecordList.length > 0,
                        shape: badges.BadgeShape.circle,
                        badgeColor: FlutterFlowTheme.of(context).warning,
                        elevation: 4.0,
                        padding: EdgeInsets.all(6.0),
                        position: badges.BadgePosition.topEnd(),
                        animationType: badges.BadgeAnimationType.scale,
                        toAnimate: true,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 5.0, 0.0),
                          child: Icon(
                            Icons.notifications_sharp,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: currentUserPhoto == null || currentUserPhoto == '',
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                    child: AuthUserStreamWidget(
                      builder: (context) => InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () => _model.unfocusNode.canRequestFocus
                                    ? FocusScope.of(context)
                                        .requestFocus(_model.unfocusNode)
                                    : FocusScope.of(context).unfocus(),
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: ProfileBottomSheetWidget(),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: currentUserPhoto != null && currentUserPhoto != '',
                  child: AuthUserStreamWidget(
                    builder: (context) => InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return GestureDetector(
                              onTap: () => _model.unfocusNode.canRequestFocus
                                  ? FocusScope.of(context)
                                      .requestFocus(_model.unfocusNode)
                                  : FocusScope.of(context).unfocus(),
                              child: Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: ProfileBottomSheetWidget(),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      },
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          currentUserPhoto,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: currentUserDocument?.userRole == UserRole.ADMIN,
                  child: AuthUserStreamWidget(
                    builder: (context) => FlutterFlowIconButton(
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.admin_panel_settings,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        context.pushNamed('Admin');
                      },
                    ),
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: StreamBuilder<List<TeamEventsRecord>>(
                            stream: queryTeamEventsRecord(
                              queryBuilder: (teamEventsRecord) =>
                                  teamEventsRecord.orderBy('eventDate'),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              List<TeamEventsRecord>
                                  listViewTeamEventsRecordList = snapshot.data!;
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewTeamEventsRecordList.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewTeamEventsRecord =
                                      listViewTeamEventsRecordList[
                                          listViewIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'FixtureDetails',
                                          queryParameters: {
                                            'fixtureRef': serializeParam(
                                              listViewTeamEventsRecord
                                                  .reference,
                                              ParamType.DocumentReference,
                                            ),
                                            'team1': serializeParam(
                                              homeNavTeamsRecordList
                                                  .where((e) =>
                                                      e.reference ==
                                                      listViewTeamEventsRecord
                                                          .team1)
                                                  .toList()
                                                  .first,
                                              ParamType.Document,
                                            ),
                                            'team2': serializeParam(
                                              homeNavTeamsRecordList
                                                  .where((e) =>
                                                      e.reference ==
                                                      listViewTeamEventsRecord
                                                          .team2)
                                                  .toList()
                                                  .first,
                                              ParamType.Document,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'team1': homeNavTeamsRecordList
                                                .where((e) =>
                                                    e.reference ==
                                                    listViewTeamEventsRecord
                                                        .team1)
                                                .toList()
                                                .first,
                                            'team2': homeNavTeamsRecordList
                                                .where((e) =>
                                                    e.reference ==
                                                    listViewTeamEventsRecord
                                                        .team2)
                                                .toList()
                                                .first,
                                          },
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        constraints: BoxConstraints(
                                          minHeight: 100.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .accent3,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        20.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  5.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          if (homeNavTeamsRecordList
                                                                      .where((e) =>
                                                                          e.reference ==
                                                                          listViewTeamEventsRecord
                                                                              .team1)
                                                                      .toList()
                                                                      .first
                                                                      .teamIcon !=
                                                                  null &&
                                                              homeNavTeamsRecordList
                                                                      .where((e) =>
                                                                          e.reference ==
                                                                          listViewTeamEventsRecord
                                                                              .team1)
                                                                      .toList()
                                                                      .first
                                                                      .teamIcon !=
                                                                  '')
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          15.0,
                                                                          0.0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                child: Image
                                                                    .network(
                                                                  homeNavTeamsRecordList
                                                                      .where((e) =>
                                                                          e.reference ==
                                                                          listViewTeamEventsRecord
                                                                              .team1)
                                                                      .toList()
                                                                      .first
                                                                      .teamIcon,
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ),
                                                          if (homeNavTeamsRecordList
                                                                      .where((e) =>
                                                                          e.reference ==
                                                                          listViewTeamEventsRecord
                                                                              .team1)
                                                                      .toList()
                                                                      .first
                                                                      .teamIcon ==
                                                                  null ||
                                                              homeNavTeamsRecordList
                                                                      .where((e) =>
                                                                          e.reference ==
                                                                          listViewTeamEventsRecord
                                                                              .team1)
                                                                      .toList()
                                                                      .first
                                                                      .teamIcon ==
                                                                  '')
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          15.0,
                                                                          0.0),
                                                              child: Icon(
                                                                Icons
                                                                    .question_mark,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                size: 30.0,
                                                              ),
                                                            ),
                                                          Text(
                                                            homeNavTeamsRecordList
                                                                .where((e) =>
                                                                    e.reference ==
                                                                    listViewTeamEventsRecord
                                                                        .team1)
                                                                .toList()
                                                                .first
                                                                .name,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        if (homeNavTeamsRecordList
                                                                    .where((e) =>
                                                                        e.reference ==
                                                                        listViewTeamEventsRecord
                                                                            .team2)
                                                                    .toList()
                                                                    .first
                                                                    .teamIcon !=
                                                                null &&
                                                            homeNavTeamsRecordList
                                                                    .where((e) =>
                                                                        e.reference ==
                                                                        listViewTeamEventsRecord
                                                                            .team2)
                                                                    .toList()
                                                                    .first
                                                                    .teamIcon !=
                                                                '')
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        15.0,
                                                                        0.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        0.0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0.0),
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                homeNavTeamsRecordList
                                                                    .where((e) =>
                                                                        e.reference ==
                                                                        listViewTeamEventsRecord
                                                                            .team2)
                                                                    .toList()
                                                                    .first
                                                                    .teamIcon,
                                                                width: 30.0,
                                                                height: 30.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                        if (homeNavTeamsRecordList
                                                                    .where((e) =>
                                                                        e.reference ==
                                                                        listViewTeamEventsRecord
                                                                            .team2)
                                                                    .toList()
                                                                    .first
                                                                    .teamIcon ==
                                                                null ||
                                                            homeNavTeamsRecordList
                                                                    .where((e) =>
                                                                        e.reference ==
                                                                        listViewTeamEventsRecord
                                                                            .team2)
                                                                    .toList()
                                                                    .first
                                                                    .teamIcon ==
                                                                '')
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        15.0,
                                                                        0.0),
                                                            child: Icon(
                                                              Icons
                                                                  .question_mark,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              size: 30.0,
                                                            ),
                                                          ),
                                                        Text(
                                                          homeNavTeamsRecordList
                                                              .where((e) =>
                                                                  e.reference ==
                                                                  listViewTeamEventsRecord
                                                                      .team2)
                                                              .toList()
                                                              .first
                                                              .name,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 30.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 10.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  10.0),
                                                      child: Text(
                                                        listViewTeamEventsRecord
                                                            .goals
                                                            .where((e) =>
                                                                e.team ==
                                                                listViewTeamEventsRecord
                                                                    .team1)
                                                            .toList()
                                                            .length
                                                            .toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ),
                                                    Text(
                                                      listViewTeamEventsRecord
                                                          .goals
                                                          .where((e) =>
                                                              e.team ==
                                                              listViewTeamEventsRecord
                                                                  .team2)
                                                          .toList()
                                                          .length
                                                          .toString(),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelLarge
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 100.0,
                                              child: VerticalDivider(
                                                width: 20.0,
                                                thickness: 2.0,
                                                indent: 12.0,
                                                endIndent: 12.0,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
                                              ),
                                            ),
                                            Container(
                                              width: 120.0,
                                              decoration: BoxDecoration(),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      'FT',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelLarge
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                    Text(
                                                      dateTimeFormat(
                                                          'MMMEd',
                                                          listViewTeamEventsRecord
                                                              .eventDate!),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelLarge
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                    if (listViewTeamEventsRecord
                                                        .videos.isNotEmpty)
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    5.0,
                                                                    0.0,
                                                                    5.0),
                                                        child:
                                                            FlutterFlowVideoPlayer(
                                                          path:
                                                              listViewTeamEventsRecord
                                                                  .videos.first,
                                                          videoType:
                                                              VideoType.network,
                                                          width: 90.0,
                                                          height: 60.0,
                                                          autoPlay: false,
                                                          looping: true,
                                                          showControls: true,
                                                          allowFullScreen: true,
                                                          allowPlaybackSpeedMenu:
                                                              false,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
