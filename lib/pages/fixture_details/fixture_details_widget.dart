import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/score_goal/score_goal_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'fixture_details_model.dart';
export 'fixture_details_model.dart';

class FixtureDetailsWidget extends StatefulWidget {
  const FixtureDetailsWidget({
    super.key,
    required this.fixtureRef,
    required this.team1,
    required this.team2,
  });

  final DocumentReference? fixtureRef;
  final TeamsRecord? team1;
  final TeamsRecord? team2;

  @override
  State<FixtureDetailsWidget> createState() => _FixtureDetailsWidgetState();
}

class _FixtureDetailsWidgetState extends State<FixtureDetailsWidget>
    with TickerProviderStateMixin {
  late FixtureDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FixtureDetailsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.document =
          await TeamEventsRecord.getDocumentOnce(widget.fixtureRef!);
      if (_model.document?.status == 'In Progress') {
        _model.timerController.timer.setPresetTime(
          mSec: (int elapsedMillis, int durationAtPause) {
            return durationAtPause == null
                ? elapsedMillis
                : (elapsedMillis + durationAtPause);
          }(
              functions.timeDifferenceInMillis(
                  _model.document!.lastStartTime!, getCurrentTimestamp),
              _model.document!.durationAtPause),
          add: false,
        );
        _model.timerController.onResetTimer();

        _model.timerController.onStartTimer();
        setState(() {
          _model.timerStarted = true;
        });
      } else {
        if (_model.document?.status == 'Paused') {
          _model.timerController.timer.setPresetTime(
            mSec: _model.document!.durationAtPause,
            add: false,
          );
          _model.timerController.onResetTimer();
        } else {
          if (_model.document?.status == 'Completed') {
            _model.timerController.timer.setPresetTime(
              mSec: _model.document!.durationInMillis,
              add: false,
            );
            _model.timerController.onResetTimer();
          }
        }
      }
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 4,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TeamEventsRecord>(
      stream: TeamEventsRecord.getDocument(widget.fixtureRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
        final fixtureDetailsTeamEventsRecord = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 52.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 22.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                '${widget.team1?.teamFullName} VS ${widget.team2?.teamFullName}',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Visibility(
                visible: fixtureDetailsTeamEventsRecord != null,
                child: StreamBuilder<List<UsersRecord>>(
                  stream: queryUsersRecord(),
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
                    List<UsersRecord> containerUsersRecordList = snapshot.data!;
                    return Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment(-1.0, 0),
                                  child: TabBar(
                                    isScrollable: true,
                                    labelColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    unselectedLabelColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Roboto',
                                          fontSize: 19.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w900,
                                        ),
                                    unselectedLabelStyle: TextStyle(),
                                    indicatorColor: Color(0xFF07F4E6),
                                    padding: EdgeInsets.all(4.0),
                                    tabs: [
                                      Tab(
                                        text: 'Stats',
                                      ),
                                      Tab(
                                        text: 'Player',
                                      ),
                                      Tab(
                                        text: 'Gallery',
                                      ),
                                      Tab(
                                        text: 'Summary',
                                      ),
                                    ],
                                    controller: _model.tabBarController,
                                    onTap: (i) async {
                                      [
                                        () async {},
                                        () async {},
                                        () async {},
                                        () async {}
                                      ][i]();
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    controller: _model.tabBarController,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                1.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (currentUserDocument
                                                          ?.userRole ==
                                                      UserRole.ADMIN)
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  5.0,
                                                                  0.0,
                                                                  5.0),
                                                      child:
                                                          AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            FlutterFlowIconButton(
                                                              borderRadius:
                                                                  20.0,
                                                              borderWidth: 1.0,
                                                              buttonSize: 40.0,
                                                              disabledIconColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                              icon: Icon(
                                                                Icons
                                                                    .play_arrow,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 24.0,
                                                              ),
                                                              onPressed: !((fixtureDetailsTeamEventsRecord
                                                                              .status ==
                                                                          'Created') ||
                                                                      (fixtureDetailsTeamEventsRecord
                                                                              .status ==
                                                                          'Paused'))
                                                                  ? null
                                                                  : () async {
                                                                      var confirmDialogResponse = await showDialog<
                                                                              bool>(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (alertDialogContext) {
                                                                              return AlertDialog(
                                                                                title: Text('Start Match'),
                                                                                content: Text('Are you sure you want to start the match?'),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                    child: Text('Cancel'),
                                                                                  ),
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                    child: Text('Confirm'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          ) ??
                                                                          false;
                                                                      if (confirmDialogResponse) {
                                                                        _model
                                                                            .timerController
                                                                            .onStartTimer();
                                                                        if (fixtureDetailsTeamEventsRecord.status ==
                                                                            'Created') {
                                                                          await widget
                                                                              .fixtureRef!
                                                                              .update(createTeamEventsRecordData(
                                                                            status:
                                                                                'In Progress',
                                                                            durationAtPause:
                                                                                0,
                                                                            lastStartTime:
                                                                                getCurrentTimestamp,
                                                                            startTime:
                                                                                getCurrentTimestamp,
                                                                          ));
                                                                        } else {
                                                                          if (fixtureDetailsTeamEventsRecord.status ==
                                                                              'Paused') {
                                                                            await widget.fixtureRef!.update(createTeamEventsRecordData(
                                                                              status: 'In Progress',
                                                                              lastStartTime: getCurrentTimestamp,
                                                                            ));
                                                                          }
                                                                        }

                                                                        setState(
                                                                            () {
                                                                          _model.timerStarted =
                                                                              true;
                                                                        });
                                                                      }
                                                                    },
                                                            ),
                                                            FlutterFlowTimer(
                                                              initialTime: _model
                                                                  .timerInitialTimeMs,
                                                              getDisplayTime: (value) =>
                                                                  StopWatchTimer
                                                                      .getDisplayTime(
                                                                value,
                                                                hours: false,
                                                                milliSecond:
                                                                    false,
                                                              ),
                                                              controller: _model
                                                                  .timerController,
                                                              updateStateInterval:
                                                                  Duration(
                                                                      milliseconds:
                                                                          10000),
                                                              onChanged: (value,
                                                                  displayTime,
                                                                  shouldUpdate) {
                                                                _model.timerMilliseconds =
                                                                    value;
                                                                _model.timerValue =
                                                                    displayTime;
                                                                if (shouldUpdate)
                                                                  setState(
                                                                      () {});
                                                              },
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                            FlutterFlowIconButton(
                                                              borderRadius:
                                                                  20.0,
                                                              borderWidth: 1.0,
                                                              buttonSize: 40.0,
                                                              disabledIconColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                              icon: Icon(
                                                                Icons.pause,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 24.0,
                                                              ),
                                                              onPressed: (fixtureDetailsTeamEventsRecord
                                                                          .status !=
                                                                      'In Progress')
                                                                  ? null
                                                                  : () async {
                                                                      var confirmDialogResponse = await showDialog<
                                                                              bool>(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (alertDialogContext) {
                                                                              return AlertDialog(
                                                                                title: Text('Pause Match'),
                                                                                content: Text('Are you sure you want to pause the match?'),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                    child: Text('Cancel'),
                                                                                  ),
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                    child: Text('Confirm'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          ) ??
                                                                          false;
                                                                      if (confirmDialogResponse) {
                                                                        _model
                                                                            .timerController
                                                                            .onStopTimer();

                                                                        await widget
                                                                            .fixtureRef!
                                                                            .update(createTeamEventsRecordData(
                                                                          status:
                                                                              'Paused',
                                                                          durationAtPause:
                                                                              _model.timerMilliseconds,
                                                                        ));
                                                                        setState(
                                                                            () {
                                                                          _model.timerStarted =
                                                                              false;
                                                                        });
                                                                      }
                                                                    },
                                                            ),
                                                            FlutterFlowIconButton(
                                                              borderRadius:
                                                                  20.0,
                                                              borderWidth: 1.0,
                                                              buttonSize: 40.0,
                                                              disabledIconColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                              icon: Icon(
                                                                Icons.stop,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 24.0,
                                                              ),
                                                              onPressed: (fixtureDetailsTeamEventsRecord
                                                                          .status !=
                                                                      'In Progress')
                                                                  ? null
                                                                  : () async {
                                                                      var confirmDialogResponse = await showDialog<
                                                                              bool>(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (alertDialogContext) {
                                                                              return AlertDialog(
                                                                                title: Text('End Match'),
                                                                                content: Text('Are you sure you want to end the match?'),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                    child: Text('Cancel'),
                                                                                  ),
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                    child: Text('Confirm'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          ) ??
                                                                          false;
                                                                      if (confirmDialogResponse) {
                                                                        _model
                                                                            .timerController
                                                                            .onStopTimer();

                                                                        await widget
                                                                            .fixtureRef!
                                                                            .update(createTeamEventsRecordData(
                                                                          status:
                                                                              'Completed',
                                                                          durationInMillis:
                                                                              _model.timerMilliseconds,
                                                                          endTime:
                                                                              getCurrentTimestamp,
                                                                          matchResult:
                                                                              () {
                                                                            if (fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team1?.reference).toList().length >
                                                                                fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team2?.reference).toList().length) {
                                                                              return 1;
                                                                            } else if (fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team1?.reference).toList().length < fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team2?.reference).toList().length) {
                                                                              return -1;
                                                                            } else {
                                                                              return 0;
                                                                            }
                                                                          }(),
                                                                        ));

                                                                        await widget
                                                                            .team1!
                                                                            .reference
                                                                            .update({
                                                                          ...mapToFirestore(
                                                                            {
                                                                              'won': FieldValue.increment(fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team1?.reference).toList().length > fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team2?.reference).toList().length ? 1 : 0),
                                                                              'lost': FieldValue.increment(fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team1?.reference).toList().length < fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team2?.reference).toList().length ? 1 : 0),
                                                                              'draw': FieldValue.increment(fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team1?.reference).toList().length == fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team2?.reference).toList().length ? 1 : 0),
                                                                            },
                                                                          ),
                                                                        });

                                                                        await widget
                                                                            .team2!
                                                                            .reference
                                                                            .update({
                                                                          ...mapToFirestore(
                                                                            {
                                                                              'won': FieldValue.increment(fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team1?.reference).toList().length < fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team2?.reference).toList().length ? 1 : 0),
                                                                              'lost': FieldValue.increment(fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team1?.reference).toList().length > fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team2?.reference).toList().length ? 1 : 0),
                                                                              'draw': FieldValue.increment(fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team1?.reference).toList().length == fixtureDetailsTeamEventsRecord.goals.where((e) => e.team == widget.team2?.reference).toList().length ? 1 : 0),
                                                                            },
                                                                          ),
                                                                        });
                                                                        setState(
                                                                            () {
                                                                          _model.timerStarted =
                                                                              false;
                                                                        });
                                                                      }
                                                                    },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 5.0, 0.0, 10.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      width: 30.0,
                                                      height: 30.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        widget.team1!.teamIcon,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Text(
                                                      widget.team1!.name,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelLarge
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                    ),
                                                    Text(
                                                      '  vs  ',
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
                                                      widget.team2!.name,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelLarge
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                    ),
                                                    Container(
                                                      width: 30.0,
                                                      height: 30.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        widget.team2!.teamIcon,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20.0),
                                                    bottomRight:
                                                        Radius.circular(20.0),
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0),
                                                  ),
                                                  border: Border.all(
                                                    color: Color(0xFF040C45),
                                                    width: 6.0,
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  15.0,
                                                                  15.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Builder(
                                                              builder:
                                                                  (context) =>
                                                                      InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if ((currentUserDocument
                                                                              ?.userRole ==
                                                                          UserRole
                                                                              .ADMIN) &&
                                                                      _model
                                                                          .timerStarted) {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                ScoreGoalWidget(
                                                                              teamEventP: fixtureDetailsTeamEventsRecord,
                                                                              team1: widget.team1!,
                                                                              titleText: 'Goals',
                                                                              timer: _model.timerValue,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        safeSetState(() =>
                                                                            _model.tt =
                                                                                value));

                                                                    if (_model
                                                                            .tt ==
                                                                        'Goals') {
                                                                      setState(
                                                                          () {
                                                                        _model.allowUndo =
                                                                            true;
                                                                      });
                                                                    }
                                                                  }

                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Text(
                                                                  'GOAL',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        40.0,
                                                                        0.0),
                                                            child: Text(
                                                              fixtureDetailsTeamEventsRecord
                                                                  .goals
                                                                  .where((e) =>
                                                                      e.team
                                                                          ?.id ==
                                                                      widget
                                                                          .team1
                                                                          ?.reference
                                                                          .id)
                                                                  .toList()
                                                                  .length
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        24.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                              'assets/images/app-goal.png',
                                                              width: 50.0,
                                                              height: 45.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        40.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              fixtureDetailsTeamEventsRecord
                                                                  .goals
                                                                  .where((e) =>
                                                                      e.team
                                                                          ?.id ==
                                                                      widget
                                                                          .team2
                                                                          ?.reference
                                                                          .id)
                                                                  .toList()
                                                                  .length
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        24.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Builder(
                                                              builder:
                                                                  (context) =>
                                                                      InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if ((currentUserDocument
                                                                              ?.userRole ==
                                                                          UserRole
                                                                              .ADMIN) &&
                                                                      _model
                                                                          .timerStarted) {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                ScoreGoalWidget(
                                                                              teamEventP: fixtureDetailsTeamEventsRecord,
                                                                              team1: widget.team2!,
                                                                              titleText: 'Goals',
                                                                              timer: _model.timerValue,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        safeSetState(() =>
                                                                            _model.tt2 =
                                                                                value));

                                                                    if (_model
                                                                            .tt2 ==
                                                                        'Goals') {
                                                                      setState(
                                                                          () {
                                                                        _model.allowUndo =
                                                                            true;
                                                                      });
                                                                    }
                                                                  }

                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Text(
                                                                  'GOAL',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
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
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  15.0,
                                                                  15.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Builder(
                                                              builder:
                                                                  (context) =>
                                                                      InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if ((currentUserDocument
                                                                              ?.userRole ==
                                                                          UserRole
                                                                              .ADMIN) &&
                                                                      _model
                                                                          .timerStarted) {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                ScoreGoalWidget(
                                                                              teamEventP: fixtureDetailsTeamEventsRecord,
                                                                              team1: widget.team1!,
                                                                              titleText: 'Corner',
                                                                              timer: _model.timerValue,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'CORNER',
                                                                  style: FlutterFlowTheme.of(
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
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        40.0,
                                                                        0.0),
                                                            child: Text(
                                                              fixtureDetailsTeamEventsRecord
                                                                  .corners
                                                                  .where((e) =>
                                                                      e.team
                                                                          ?.id ==
                                                                      widget
                                                                          .team1
                                                                          ?.reference
                                                                          .id)
                                                                  .toList()
                                                                  .length
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        24.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                              'assets/images/app-corner.png',
                                                              width: 50.0,
                                                              height: 45.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        40.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              fixtureDetailsTeamEventsRecord
                                                                  .corners
                                                                  .where((e) =>
                                                                      e.team
                                                                          ?.id ==
                                                                      widget
                                                                          .team2
                                                                          ?.reference
                                                                          .id)
                                                                  .toList()
                                                                  .length
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        24.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Builder(
                                                              builder:
                                                                  (context) =>
                                                                      InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if ((currentUserDocument
                                                                              ?.userRole ==
                                                                          UserRole
                                                                              .ADMIN) &&
                                                                      _model
                                                                          .timerStarted) {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                ScoreGoalWidget(
                                                                              teamEventP: fixtureDetailsTeamEventsRecord,
                                                                              team1: widget.team2!,
                                                                              titleText: 'Corner',
                                                                              timer: _model.timerValue,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'CORNER',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
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
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  15.0,
                                                                  15.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Builder(
                                                              builder:
                                                                  (context) =>
                                                                      InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if ((currentUserDocument
                                                                              ?.userRole ==
                                                                          UserRole
                                                                              .ADMIN) &&
                                                                      _model
                                                                          .timerStarted) {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                ScoreGoalWidget(
                                                                              teamEventP: fixtureDetailsTeamEventsRecord,
                                                                              team1: widget.team1!,
                                                                              titleText: 'YellowCard',
                                                                              timer: _model.timerValue,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'YELLOW CARD',
                                                                  style: FlutterFlowTheme.of(
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
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        40.0,
                                                                        0.0),
                                                            child: Text(
                                                              fixtureDetailsTeamEventsRecord
                                                                  .yellowCard
                                                                  .where((e) =>
                                                                      e.team
                                                                          ?.id ==
                                                                      widget
                                                                          .team1
                                                                          ?.reference
                                                                          .id)
                                                                  .toList()
                                                                  .length
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        24.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                              'assets/images/app-yellow.png',
                                                              width: 50.0,
                                                              height: 45.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        40.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              fixtureDetailsTeamEventsRecord
                                                                  .yellowCard
                                                                  .where((e) =>
                                                                      e.team
                                                                          ?.id ==
                                                                      widget
                                                                          .team2
                                                                          ?.reference
                                                                          .id)
                                                                  .toList()
                                                                  .length
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        24.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Builder(
                                                              builder:
                                                                  (context) =>
                                                                      InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if ((currentUserDocument
                                                                              ?.userRole ==
                                                                          UserRole
                                                                              .ADMIN) &&
                                                                      _model
                                                                          .timerStarted) {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                ScoreGoalWidget(
                                                                              teamEventP: fixtureDetailsTeamEventsRecord,
                                                                              team1: widget.team2!,
                                                                              titleText: 'YellowCard',
                                                                              timer: _model.timerValue,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'YELLOW CARD',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
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
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  15.0,
                                                                  15.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Builder(
                                                              builder:
                                                                  (context) =>
                                                                      InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if ((currentUserDocument
                                                                              ?.userRole ==
                                                                          UserRole
                                                                              .ADMIN) &&
                                                                      _model
                                                                          .timerStarted) {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                ScoreGoalWidget(
                                                                              teamEventP: fixtureDetailsTeamEventsRecord,
                                                                              team1: widget.team1!,
                                                                              titleText: 'RedCard',
                                                                              timer: _model.timerValue,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'RED CARD',
                                                                  style: FlutterFlowTheme.of(
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
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        40.0,
                                                                        0.0),
                                                            child: Text(
                                                              fixtureDetailsTeamEventsRecord
                                                                  .redCard
                                                                  .where((e) =>
                                                                      e.team
                                                                          ?.id ==
                                                                      widget
                                                                          .team1
                                                                          ?.reference
                                                                          .id)
                                                                  .toList()
                                                                  .length
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        24.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                              'assets/images/app-red.png',
                                                              width: 50.0,
                                                              height: 45.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        40.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              fixtureDetailsTeamEventsRecord
                                                                  .redCard
                                                                  .where((e) =>
                                                                      e.team
                                                                          ?.id ==
                                                                      widget
                                                                          .team2
                                                                          ?.reference
                                                                          .id)
                                                                  .toList()
                                                                  .length
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        24.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Builder(
                                                              builder:
                                                                  (context) =>
                                                                      InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if ((currentUserDocument
                                                                              ?.userRole ==
                                                                          UserRole
                                                                              .ADMIN) &&
                                                                      _model
                                                                          .timerStarted) {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                ScoreGoalWidget(
                                                                              teamEventP: fixtureDetailsTeamEventsRecord,
                                                                              team1: widget.team2!,
                                                                              titleText: 'RedCard',
                                                                              timer: _model.timerValue,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'RED CARD',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
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
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  15.0,
                                                                  15.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Builder(
                                                              builder:
                                                                  (context) =>
                                                                      InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if ((currentUserDocument
                                                                              ?.userRole ==
                                                                          UserRole
                                                                              .ADMIN) &&
                                                                      _model
                                                                          .timerStarted) {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                ScoreGoalWidget(
                                                                              teamEventP: fixtureDetailsTeamEventsRecord,
                                                                              team1: widget.team1!,
                                                                              titleText: 'FreeKick',
                                                                              timer: _model.timerValue,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'FREE KICK',
                                                                  style: FlutterFlowTheme.of(
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
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        40.0,
                                                                        0.0),
                                                            child: Text(
                                                              fixtureDetailsTeamEventsRecord
                                                                  .freeKick
                                                                  .where((e) =>
                                                                      e.team
                                                                          ?.id ==
                                                                      widget
                                                                          .team1
                                                                          ?.reference
                                                                          .id)
                                                                  .toList()
                                                                  .length
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        24.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                              'assets/images/app-freekick.png',
                                                              width: 50.0,
                                                              height: 45.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        40.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              fixtureDetailsTeamEventsRecord
                                                                  .freeKick
                                                                  .where((e) =>
                                                                      e.team
                                                                          ?.id ==
                                                                      widget
                                                                          .team2
                                                                          ?.reference
                                                                          .id)
                                                                  .toList()
                                                                  .length
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        24.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Builder(
                                                              builder:
                                                                  (context) =>
                                                                      InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if ((currentUserDocument
                                                                              ?.userRole ==
                                                                          UserRole
                                                                              .ADMIN) &&
                                                                      _model
                                                                          .timerStarted) {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                ScoreGoalWidget(
                                                                              teamEventP: fixtureDetailsTeamEventsRecord,
                                                                              team1: widget.team2!,
                                                                              titleText: 'FreeKick',
                                                                              timer: _model.timerValue,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'FREE KICK',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
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
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  15.0,
                                                                  15.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Builder(
                                                              builder:
                                                                  (context) =>
                                                                      InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if ((currentUserDocument
                                                                              ?.userRole ==
                                                                          UserRole
                                                                              .ADMIN) &&
                                                                      _model
                                                                          .timerStarted) {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                ScoreGoalWidget(
                                                                              teamEventP: fixtureDetailsTeamEventsRecord,
                                                                              team1: widget.team1!,
                                                                              titleText: 'Foul',
                                                                              timer: _model.timerValue,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'FOUL',
                                                                  style: FlutterFlowTheme.of(
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
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        40.0,
                                                                        0.0),
                                                            child: Text(
                                                              fixtureDetailsTeamEventsRecord
                                                                  .foul
                                                                  .where((e) =>
                                                                      e.team
                                                                          ?.id ==
                                                                      widget
                                                                          .team1
                                                                          ?.reference
                                                                          .id)
                                                                  .toList()
                                                                  .length
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        24.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Image.asset(
                                                              'assets/images/app-foul.png',
                                                              width: 50.0,
                                                              height: 45.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        40.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              fixtureDetailsTeamEventsRecord
                                                                  .foul
                                                                  .where((e) =>
                                                                      e.team
                                                                          ?.id ==
                                                                      widget
                                                                          .team2
                                                                          ?.reference
                                                                          .id)
                                                                  .toList()
                                                                  .length
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        24.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Builder(
                                                              builder:
                                                                  (context) =>
                                                                      InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  if ((currentUserDocument
                                                                              ?.userRole ==
                                                                          UserRole
                                                                              .ADMIN) &&
                                                                      _model
                                                                          .timerStarted) {
                                                                    await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Dialog(
                                                                          elevation:
                                                                              0,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          alignment:
                                                                              AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                ScoreGoalWidget(
                                                                              teamEventP: fixtureDetailsTeamEventsRecord,
                                                                              team1: widget.team2!,
                                                                              titleText: 'Foul',
                                                                              timer: _model.timerValue,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'FOUL',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
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
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  15.0,
                                                                  15.0,
                                                                  15.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          if (currentUserDocument
                                                                  ?.userRole ==
                                                              UserRole.ADMIN)
                                                            AuthUserStreamWidget(
                                                              builder: (context) =>
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  if (_model
                                                                      .allowUndo) {
                                                                    await widget
                                                                        .fixtureRef!
                                                                        .update({
                                                                      ...mapToFirestore(
                                                                        {
                                                                          'goals':
                                                                              FieldValue.arrayRemove([
                                                                            getScoreDetailsFirestoreData(
                                                                              updateScoreDetailsStruct(
                                                                                fixtureDetailsTeamEventsRecord.goals.last,
                                                                                clearUnsetFields: false,
                                                                              ),
                                                                              true,
                                                                            )
                                                                          ]),
                                                                        },
                                                                      ),
                                                                    });
                                                                    setState(
                                                                        () {
                                                                      _model.allowUndo =
                                                                          false;
                                                                    });
                                                                  }
                                                                },
                                                                text:
                                                                    'Undo Last goal',
                                                                options:
                                                                    FFButtonOptions(
                                                                  height: 40.0,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          2.0,
                                                                          0.0,
                                                                          2.0,
                                                                          0.0),
                                                                  iconPadding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color: Colors
                                                                      .white,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .info,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0.0),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: (widget
                                                .team1!.members.isNotEmpty) &&
                                            (widget.team2!.members.isNotEmpty),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              1.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: Image.asset(
                                                'assets/images/Football_field.svg.png',
                                              ).image,
                                            ),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              width: 3.0,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final gKTeam1 = (widget
                                                                  .team1
                                                                  ?.members
                                                                  ?.where((e) =>
                                                                      e.memberRole ==
                                                                      'GK')
                                                                  .toList()
                                                                  ?.toList() ??
                                                              [])
                                                          .take(1)
                                                          .toList();
                                                      return Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: List.generate(
                                                            gKTeam1.length,
                                                            (gKTeam1Index) {
                                                          final gKTeam1Item =
                                                              gKTeam1[
                                                                  gKTeam1Index];
                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                if (containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                gKTeam1Item
                                                                                    .memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl !=
                                                                        null &&
                                                                    containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                gKTeam1Item.memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl !=
                                                                        '')
                                                                  Container(
                                                                    width: 30.0,
                                                                    height:
                                                                        30.0,
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Image
                                                                        .network(
                                                                      containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              gKTeam1Item.memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                if (containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                gKTeam1Item
                                                                                    .memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl ==
                                                                        null ||
                                                                    containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                gKTeam1Item.memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl ==
                                                                        '')
                                                                  Icon(
                                                                    Icons
                                                                        .location_history,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    size: 30.0,
                                                                  ),
                                                                Text(
                                                                  containerUsersRecordList
                                                                      .where((e) =>
                                                                          e.reference ==
                                                                          gKTeam1Item
                                                                              .memberRef)
                                                                      .toList()
                                                                      .first
                                                                      .displayName,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Builder(
                                                  builder: (context) {
                                                    final dEFTeam1 = (widget
                                                                .team1?.members
                                                                ?.where((e) =>
                                                                    e.memberRole ==
                                                                    'DEF')
                                                                .toList()
                                                                ?.toList() ??
                                                            [])
                                                        .take(4)
                                                        .toList();
                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: List.generate(
                                                          dEFTeam1.length,
                                                          (dEFTeam1Index) {
                                                        final dEFTeam1Item =
                                                            dEFTeam1[
                                                                dEFTeam1Index];
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              if (containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              dEFTeam1Item
                                                                                  .memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl !=
                                                                      null &&
                                                                  containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              dEFTeam1Item.memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl !=
                                                                      '')
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    containerUsersRecordList
                                                                        .where((e) =>
                                                                            e.reference ==
                                                                            dEFTeam1Item.memberRef)
                                                                        .toList()
                                                                        .first
                                                                        .photoUrl,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              if (containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              dEFTeam1Item
                                                                                  .memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl ==
                                                                      null ||
                                                                  containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              dEFTeam1Item.memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl ==
                                                                      '')
                                                                Icon(
                                                                  Icons
                                                                      .location_history,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  size: 30.0,
                                                                ),
                                                              Text(
                                                                containerUsersRecordList
                                                                    .where((e) =>
                                                                        e.reference ==
                                                                        dEFTeam1Item
                                                                            .memberRef)
                                                                    .toList()
                                                                    .first
                                                                    .displayName,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Builder(
                                                  builder: (context) {
                                                    final mIDTeam1 = (widget
                                                                .team1?.members
                                                                ?.where((e) =>
                                                                    e.memberRole ==
                                                                    'MID')
                                                                .toList()
                                                                ?.toList() ??
                                                            [])
                                                        .take(4)
                                                        .toList();
                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: List.generate(
                                                          mIDTeam1.length,
                                                          (mIDTeam1Index) {
                                                        final mIDTeam1Item =
                                                            mIDTeam1[
                                                                mIDTeam1Index];
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              if (containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              mIDTeam1Item
                                                                                  .memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl !=
                                                                      null &&
                                                                  containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              mIDTeam1Item.memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl !=
                                                                      '')
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    containerUsersRecordList
                                                                        .where((e) =>
                                                                            e.reference ==
                                                                            mIDTeam1Item.memberRef)
                                                                        .toList()
                                                                        .first
                                                                        .photoUrl,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              if (containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              mIDTeam1Item
                                                                                  .memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl ==
                                                                      null ||
                                                                  containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              mIDTeam1Item.memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl ==
                                                                      '')
                                                                Icon(
                                                                  Icons
                                                                      .location_history,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  size: 30.0,
                                                                ),
                                                              Text(
                                                                containerUsersRecordList
                                                                    .where((e) =>
                                                                        e.reference ==
                                                                        mIDTeam1Item
                                                                            .memberRef)
                                                                    .toList()
                                                                    .first
                                                                    .displayName,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 5.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final fWDTeam1 = (widget
                                                                  .team1
                                                                  ?.members
                                                                  ?.where((e) =>
                                                                      e.memberRole ==
                                                                      'FWD')
                                                                  .toList()
                                                                  ?.toList() ??
                                                              [])
                                                          .take(4)
                                                          .toList();
                                                      return Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: List.generate(
                                                            fWDTeam1.length,
                                                            (fWDTeam1Index) {
                                                          final fWDTeam1Item =
                                                              fWDTeam1[
                                                                  fWDTeam1Index];
                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                if (containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                fWDTeam1Item
                                                                                    .memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl !=
                                                                        null &&
                                                                    containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                fWDTeam1Item.memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl !=
                                                                        '')
                                                                  Container(
                                                                    width: 30.0,
                                                                    height:
                                                                        30.0,
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Image
                                                                        .network(
                                                                      containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              fWDTeam1Item.memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                if (containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                fWDTeam1Item
                                                                                    .memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl ==
                                                                        null ||
                                                                    containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                fWDTeam1Item.memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl ==
                                                                        '')
                                                                  Icon(
                                                                    Icons
                                                                        .location_history,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    size: 30.0,
                                                                  ),
                                                                Text(
                                                                  containerUsersRecordList
                                                                      .where((e) =>
                                                                          e.reference ==
                                                                          fWDTeam1Item
                                                                              .memberRef)
                                                                      .toList()
                                                                      .first
                                                                      .displayName,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 0.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final fWDTeam2 = (widget
                                                                  .team2
                                                                  ?.members
                                                                  ?.where((e) =>
                                                                      e.memberRole ==
                                                                      'FWD')
                                                                  .toList()
                                                                  ?.toList() ??
                                                              [])
                                                          .take(4)
                                                          .toList();
                                                      return Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: List.generate(
                                                            fWDTeam2.length,
                                                            (fWDTeam2Index) {
                                                          final fWDTeam2Item =
                                                              fWDTeam2[
                                                                  fWDTeam2Index];
                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                if (containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                fWDTeam2Item
                                                                                    .memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl !=
                                                                        null &&
                                                                    containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                fWDTeam2Item.memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl !=
                                                                        '')
                                                                  Container(
                                                                    width: 30.0,
                                                                    height:
                                                                        30.0,
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Image
                                                                        .network(
                                                                      containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              fWDTeam2Item.memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorBuilder: (context,
                                                                              error,
                                                                              stackTrace) =>
                                                                          Image
                                                                              .asset(
                                                                        'assets/images/error_image.png',
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if (containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                fWDTeam2Item
                                                                                    .memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl ==
                                                                        null ||
                                                                    containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                fWDTeam2Item.memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl ==
                                                                        '')
                                                                  Icon(
                                                                    Icons
                                                                        .location_history,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    size: 30.0,
                                                                  ),
                                                                Text(
                                                                  containerUsersRecordList
                                                                      .where((e) =>
                                                                          e.reference ==
                                                                          fWDTeam2Item
                                                                              .memberRef)
                                                                      .toList()
                                                                      .first
                                                                      .displayName,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Builder(
                                                  builder: (context) {
                                                    final mIDTeam2 = (widget
                                                                .team2?.members
                                                                ?.where((e) =>
                                                                    e.memberRole ==
                                                                    'MID')
                                                                .toList()
                                                                ?.toList() ??
                                                            [])
                                                        .take(4)
                                                        .toList();
                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: List.generate(
                                                          mIDTeam2.length,
                                                          (mIDTeam2Index) {
                                                        final mIDTeam2Item =
                                                            mIDTeam2[
                                                                mIDTeam2Index];
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              if (containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              mIDTeam2Item
                                                                                  .memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl !=
                                                                      null &&
                                                                  containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              mIDTeam2Item.memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl !=
                                                                      '')
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    containerUsersRecordList
                                                                        .where((e) =>
                                                                            e.reference ==
                                                                            mIDTeam2Item.memberRef)
                                                                        .toList()
                                                                        .first
                                                                        .photoUrl,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              if (containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              mIDTeam2Item
                                                                                  .memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl ==
                                                                      null ||
                                                                  containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              mIDTeam2Item.memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl ==
                                                                      '')
                                                                Icon(
                                                                  Icons
                                                                      .location_history,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  size: 30.0,
                                                                ),
                                                              Text(
                                                                containerUsersRecordList
                                                                    .where((e) =>
                                                                        e.reference ==
                                                                        mIDTeam2Item
                                                                            .memberRef)
                                                                    .toList()
                                                                    .first
                                                                    .displayName,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Builder(
                                                  builder: (context) {
                                                    final dEFTeam2 = (widget
                                                                .team2?.members
                                                                ?.where((e) =>
                                                                    e.memberRole ==
                                                                    'DEF')
                                                                .toList()
                                                                ?.toList() ??
                                                            [])
                                                        .take(4)
                                                        .toList();
                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: List.generate(
                                                          dEFTeam2.length,
                                                          (dEFTeam2Index) {
                                                        final dEFTeam2Item =
                                                            dEFTeam2[
                                                                dEFTeam2Index];
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              if (containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              dEFTeam2Item
                                                                                  .memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl !=
                                                                      null &&
                                                                  containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              dEFTeam2Item.memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl !=
                                                                      '')
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    containerUsersRecordList
                                                                        .where((e) =>
                                                                            e.reference ==
                                                                            dEFTeam2Item.memberRef)
                                                                        .toList()
                                                                        .first
                                                                        .photoUrl,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              if (containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              dEFTeam2Item
                                                                                  .memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl ==
                                                                      null ||
                                                                  containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              dEFTeam2Item.memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl ==
                                                                      '')
                                                                Icon(
                                                                  Icons
                                                                      .location_history,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  size: 30.0,
                                                                ),
                                                              Text(
                                                                containerUsersRecordList
                                                                    .where((e) =>
                                                                        e.reference ==
                                                                        dEFTeam2Item
                                                                            .memberRef)
                                                                    .toList()
                                                                    .first
                                                                    .displayName,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 10.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final gKTeam2 = (widget
                                                                  .team2
                                                                  ?.members
                                                                  ?.where((e) =>
                                                                      e.memberRole ==
                                                                      'GK')
                                                                  .toList()
                                                                  ?.toList() ??
                                                              [])
                                                          .take(1)
                                                          .toList();
                                                      return Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: List.generate(
                                                            gKTeam2.length,
                                                            (gKTeam2Index) {
                                                          final gKTeam2Item =
                                                              gKTeam2[
                                                                  gKTeam2Index];
                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                if (containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                gKTeam2Item
                                                                                    .memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl !=
                                                                        null &&
                                                                    containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                gKTeam2Item.memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl !=
                                                                        '')
                                                                  Container(
                                                                    width: 30.0,
                                                                    height:
                                                                        30.0,
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Image
                                                                        .network(
                                                                      containerUsersRecordList
                                                                          .where((e) =>
                                                                              e.reference ==
                                                                              gKTeam2Item.memberRef)
                                                                          .toList()
                                                                          .first
                                                                          .photoUrl,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                if (containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                gKTeam2Item
                                                                                    .memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl ==
                                                                        null ||
                                                                    containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.reference ==
                                                                                gKTeam2Item.memberRef)
                                                                            .toList()
                                                                            .first
                                                                            .photoUrl ==
                                                                        '')
                                                                  Icon(
                                                                    Icons
                                                                        .location_history,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    size: 30.0,
                                                                  ),
                                                                Text(
                                                                  containerUsersRecordList
                                                                      .where((e) =>
                                                                          e.reference ==
                                                                          gKTeam2Item
                                                                              .memberRef)
                                                                      .toList()
                                                                      .first
                                                                      .displayName,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (!_model.imageView)
                                            Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  1.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (currentUserDocument
                                                            ?.userRole ==
                                                        UserRole.ADMIN)
                                                      AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        10.0,
                                                                        10.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            final selectedMedia =
                                                                                await selectMediaWithSourceBottomSheet(
                                                                              context: context,
                                                                              allowPhoto: true,
                                                                              includeDimensions: true,
                                                                              includeBlurHash: true,
                                                                            );
                                                                            if (selectedMedia != null &&
                                                                                selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                                                              setState(() => _model.isDataUploading1 = true);
                                                                              var selectedUploadedFiles = <FFUploadedFile>[];

                                                                              try {
                                                                                showUploadMessage(
                                                                                  context,
                                                                                  'Uploading file...',
                                                                                  showLoading: true,
                                                                                );
                                                                                selectedUploadedFiles = selectedMedia
                                                                                    .map((m) => FFUploadedFile(
                                                                                          name: m.storagePath.split('/').last,
                                                                                          bytes: m.bytes,
                                                                                          height: m.dimensions?.height,
                                                                                          width: m.dimensions?.width,
                                                                                          blurHash: m.blurHash,
                                                                                        ))
                                                                                    .toList();
                                                                              } finally {
                                                                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                                _model.isDataUploading1 = false;
                                                                              }
                                                                              if (selectedUploadedFiles.length == selectedMedia.length) {
                                                                                setState(() {
                                                                                  _model.uploadedLocalFile1 = selectedUploadedFiles.first;
                                                                                });
                                                                                showUploadMessage(context, 'Success!');
                                                                              } else {
                                                                                setState(() {});
                                                                                showUploadMessage(context, 'Failed to upload data');
                                                                                return;
                                                                              }
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                60.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0x36FCFCFC),
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(0.0),
                                                                                bottomRight: Radius.circular(0.0),
                                                                                topLeft: Radius.circular(0.0),
                                                                                topRight: Radius.circular(0.0),
                                                                              ),
                                                                              border: Border.all(
                                                                                width: 0.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Flexible(
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.file_upload_outlined,
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          size: 18.0,
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              'Upload team photo',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto Condensed',
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
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
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            final selectedMedia =
                                                                                await selectMediaWithSourceBottomSheet(
                                                                              context: context,
                                                                              allowPhoto: false,
                                                                              allowVideo: true,
                                                                            );
                                                                            if (selectedMedia != null &&
                                                                                selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                                                              setState(() => _model.isDataUploading2 = true);
                                                                              var selectedUploadedFiles = <FFUploadedFile>[];

                                                                              var downloadUrls = <String>[];
                                                                              try {
                                                                                showUploadMessage(
                                                                                  context,
                                                                                  'Uploading file...',
                                                                                  showLoading: true,
                                                                                );
                                                                                selectedUploadedFiles = selectedMedia
                                                                                    .map((m) => FFUploadedFile(
                                                                                          name: m.storagePath.split('/').last,
                                                                                          bytes: m.bytes,
                                                                                          height: m.dimensions?.height,
                                                                                          width: m.dimensions?.width,
                                                                                          blurHash: m.blurHash,
                                                                                        ))
                                                                                    .toList();

                                                                                downloadUrls = (await Future.wait(
                                                                                  selectedMedia.map(
                                                                                    (m) async => await uploadData(m.storagePath, m.bytes),
                                                                                  ),
                                                                                ))
                                                                                    .where((u) => u != null)
                                                                                    .map((u) => u!)
                                                                                    .toList();
                                                                              } finally {
                                                                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                                _model.isDataUploading2 = false;
                                                                              }
                                                                              if (selectedUploadedFiles.length == selectedMedia.length && downloadUrls.length == selectedMedia.length) {
                                                                                setState(() {
                                                                                  _model.uploadedLocalFile2 = selectedUploadedFiles.first;
                                                                                  _model.uploadedFileUrl2 = downloadUrls.first;
                                                                                });
                                                                                showUploadMessage(context, 'Success!');
                                                                              } else {
                                                                                setState(() {});
                                                                                showUploadMessage(context, 'Failed to upload data');
                                                                                return;
                                                                              }
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                60.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0x36FCFCFC),
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(0.0),
                                                                                bottomRight: Radius.circular(0.0),
                                                                                topLeft: Radius.circular(0.0),
                                                                                topRight: Radius.circular(0.0),
                                                                              ),
                                                                              border: Border.all(
                                                                                width: 0.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Flexible(
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.file_upload_outlined,
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          size: 18.0,
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              'Upload team video',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Roboto Condensed',
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
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
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          15.0,
                                                                          5.0,
                                                                          5.0),
                                                                  child:
                                                                      FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      _model.apiResulttaq = await WePlayApiGroup
                                                                          .uploadImageCall
                                                                          .call(
                                                                        file: functions
                                                                            .base64EncodeFile(_model.uploadedLocalFile1),
                                                                        jwtToken:
                                                                            currentJwtToken,
                                                                        fileName:
                                                                            functions.getFileName(_model.uploadedLocalFile1),
                                                                        teamEventId: widget
                                                                            .fixtureRef
                                                                            ?.id,
                                                                      );
                                                                      if (_model.uploadedFileUrl2 !=
                                                                              null &&
                                                                          _model.uploadedFileUrl2 !=
                                                                              '') {
                                                                        await widget
                                                                            .fixtureRef!
                                                                            .update({
                                                                          ...mapToFirestore(
                                                                            {
                                                                              'videos': FieldValue.arrayUnion([
                                                                                _model.uploadedFileUrl2
                                                                              ]),
                                                                            },
                                                                          ),
                                                                        });
                                                                      }
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (alertDialogContext) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('Success'),
                                                                            content:
                                                                                Text('Event data updated'),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                child: Text('Ok'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );

                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    text:
                                                                        'Update Event',
                                                                    options:
                                                                        FFButtonOptions(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      height:
                                                                          40.0,
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          24.0,
                                                                          0.0,
                                                                          24.0,
                                                                          0.0),
                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            color:
                                                                                Colors.white,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                      elevation:
                                                                          3.0,
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .transparent,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              18.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  10.0,
                                                                  10.0,
                                                                  10.0),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Builder(
                                                                builder:
                                                                    (context) {
                                                                  final images =
                                                                      fixtureDetailsTeamEventsRecord
                                                                          .images
                                                                          .toList();
                                                                  return Wrap(
                                                                    spacing:
                                                                        0.0,
                                                                    runSpacing:
                                                                        0.0,
                                                                    alignment:
                                                                        WrapAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        WrapCrossAlignment
                                                                            .start,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    runAlignment:
                                                                        WrapAlignment
                                                                            .start,
                                                                    verticalDirection:
                                                                        VerticalDirection
                                                                            .down,
                                                                    clipBehavior:
                                                                        Clip.none,
                                                                    children: List.generate(
                                                                        images
                                                                            .length,
                                                                        (imagesIndex) {
                                                                      final imagesItem =
                                                                          images[
                                                                              imagesIndex];
                                                                      return Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(0.0),
                                                                            bottomRight:
                                                                                Radius.circular(0.0),
                                                                            topLeft:
                                                                                Radius.circular(0.0),
                                                                            topRight:
                                                                                Radius.circular(0.0),
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            width:
                                                                                1.0,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            setState(() {
                                                                              _model.imageView = true;
                                                                              _model.imagePath = imagesItem;
                                                                            });
                                                                          },
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(0.0),
                                                                            child:
                                                                                Image.network(
                                                                              imagesItem,
                                                                              width: 100.0,
                                                                              height: 100.0,
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  10.0),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Builder(
                                                              builder:
                                                                  (context) {
                                                                final videos =
                                                                    fixtureDetailsTeamEventsRecord
                                                                        .videos
                                                                        .toList();
                                                                return Wrap(
                                                                  spacing: 0.0,
                                                                  runSpacing:
                                                                      0.0,
                                                                  alignment:
                                                                      WrapAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      WrapCrossAlignment
                                                                          .start,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  runAlignment:
                                                                      WrapAlignment
                                                                          .start,
                                                                  verticalDirection:
                                                                      VerticalDirection
                                                                          .down,
                                                                  clipBehavior:
                                                                      Clip.none,
                                                                  children: List
                                                                      .generate(
                                                                          videos
                                                                              .length,
                                                                          (videosIndex) {
                                                                    final videosItem =
                                                                        videos[
                                                                            videosIndex];
                                                                    return Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(2.0),
                                                                          bottomRight:
                                                                              Radius.circular(2.0),
                                                                          topLeft:
                                                                              Radius.circular(2.0),
                                                                          topRight:
                                                                              Radius.circular(2.0),
                                                                        ),
                                                                        border:
                                                                            Border.all(
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          FlutterFlowVideoPlayer(
                                                                        path:
                                                                            videosItem,
                                                                        videoType:
                                                                            VideoType.network,
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.49,
                                                                        height:
                                                                            120.0,
                                                                        autoPlay:
                                                                            false,
                                                                        looping:
                                                                            true,
                                                                        showControls:
                                                                            true,
                                                                        allowFullScreen:
                                                                            true,
                                                                        allowPlaybackSpeedMenu:
                                                                            false,
                                                                      ),
                                                                    );
                                                                  }),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (_model.imageView)
                                            Expanded(
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  setState(() {
                                                    _model.imageView = false;
                                                  });
                                                },
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: Image.network(
                                                        _model.imagePath!,
                                                      ).image,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4.0,
                                                        color:
                                                            Color(0x33000000),
                                                        offset: Offset(
                                                          0.0,
                                                          2.0,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                1.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                height: 600.0,
                                                decoration: BoxDecoration(),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                        10.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .team1!
                                                                        .teamIcon,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  widget.team1!
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                5.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              'GOALS',
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    fontSize: 20.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          '${fixtureDetailsTeamEventsRecord.goals.where((e) => e.team?.id == widget.team1?.reference.id).toList().length.toString()}-${fixtureDetailsTeamEventsRecord.goals.where((e) => e.team?.id == widget.team2?.reference.id).toList().length.toString()}',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                fontSize: 24.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  widget.team2!
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                ),
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .team2!
                                                                        .teamIcon,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        15.0,
                                                                        15.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final goalT1 = fixtureDetailsTeamEventsRecord
                                                                            .goals
                                                                            .where((e) =>
                                                                                e.team?.id ==
                                                                                widget.team1?.reference.id)
                                                                            .toList();
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: List.generate(
                                                                              goalT1.length,
                                                                              (goalT1Index) {
                                                                            final goalT1Item =
                                                                                goalT1[goalT1Index];
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                    child: Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == goalT1Item.player?.id).toList().first.photoUrl,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Text(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == goalT1Item.player?.id).toList().first.displayName,
                                                                                        style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final goalT2 = fixtureDetailsTeamEventsRecord
                                                                            .goals
                                                                            .where((e) =>
                                                                                e.team?.id ==
                                                                                widget.team2?.reference.id)
                                                                            .toList();
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: List.generate(
                                                                              goalT2.length,
                                                                              (goalT2Index) {
                                                                            final goalT2Item =
                                                                                goalT2[goalT2Index];
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                    child: Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == goalT2Item.player?.id).toList().first.photoUrl,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    containerUsersRecordList.where((e) => e.reference.id == goalT2Item.player?.id).toList().first.displayName,
                                                                                    style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Divider(
                                                            thickness: 2.0,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                        10.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .team1!
                                                                        .teamIcon,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  widget.team1!
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                5.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              'CORNER',
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: Color(0xFF0FFF08),
                                                                                    fontSize: 20.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          '${fixtureDetailsTeamEventsRecord.corners.where((e) => e.team?.id == widget.team1?.reference.id).toList().length.toString()} - ${fixtureDetailsTeamEventsRecord.corners.where((e) => e.team?.id == widget.team2?.reference.id).toList().length.toString()}',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                fontSize: 24.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  widget.team2!
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                ),
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .team2!
                                                                        .teamIcon,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        15.0,
                                                                        15.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final cornerCT1 = fixtureDetailsTeamEventsRecord
                                                                            .corners
                                                                            .where((e) =>
                                                                                e.team?.id ==
                                                                                widget.team1?.reference.id)
                                                                            .toList();
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: List.generate(
                                                                              cornerCT1.length,
                                                                              (cornerCT1Index) {
                                                                            final cornerCT1Item =
                                                                                cornerCT1[cornerCT1Index];
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                    child: Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == cornerCT1Item.player?.id).toList().first.photoUrl,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Text(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == cornerCT1Item.player?.id).toList().first.displayName,
                                                                                        style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final cornerCT2 = fixtureDetailsTeamEventsRecord
                                                                            .corners
                                                                            .where((e) =>
                                                                                e.team?.id ==
                                                                                widget.team2?.reference.id)
                                                                            .toList();
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: List.generate(
                                                                              cornerCT2.length,
                                                                              (cornerCT2Index) {
                                                                            final cornerCT2Item =
                                                                                cornerCT2[cornerCT2Index];
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                    child: Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == cornerCT2Item.player?.id).toList().first.photoUrl,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    containerUsersRecordList.where((e) => e.reference.id == cornerCT2Item.player?.id).toList().first.displayName,
                                                                                    style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Divider(
                                                            thickness: 2.0,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                        10.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .team1!
                                                                        .teamIcon,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  widget.team1!
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                5.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              'Yellow Card',
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: Color(0xFFF2D000),
                                                                                    fontSize: 20.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          '${fixtureDetailsTeamEventsRecord.yellowCard.where((e) => e.team?.id == widget.team1?.reference.id).toList().length.toString()} - ${fixtureDetailsTeamEventsRecord.yellowCard.where((e) => e.team?.id == widget.team2?.reference.id).toList().length.toString()}',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                fontSize: 24.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  widget.team2!
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                ),
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .team2!
                                                                        .teamIcon,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        15.0,
                                                                        15.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final yellowCT1 = fixtureDetailsTeamEventsRecord
                                                                            .yellowCard
                                                                            .where((e) =>
                                                                                e.team?.id ==
                                                                                widget.team1?.reference.id)
                                                                            .toList();
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: List.generate(
                                                                              yellowCT1.length,
                                                                              (yellowCT1Index) {
                                                                            final yellowCT1Item =
                                                                                yellowCT1[yellowCT1Index];
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                    child: Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == yellowCT1Item.player?.id).toList().first.photoUrl,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Text(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == yellowCT1Item.player?.id).toList().first.displayName,
                                                                                        style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final yellowCT2 = fixtureDetailsTeamEventsRecord
                                                                            .yellowCard
                                                                            .where((e) =>
                                                                                e.team?.id ==
                                                                                widget.team2?.reference.id)
                                                                            .toList();
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: List.generate(
                                                                              yellowCT2.length,
                                                                              (yellowCT2Index) {
                                                                            final yellowCT2Item =
                                                                                yellowCT2[yellowCT2Index];
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                    child: Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == yellowCT2Item.player?.id).toList().first.photoUrl,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    containerUsersRecordList.where((e) => e.reference.id == yellowCT2Item.player?.id).toList().first.displayName,
                                                                                    style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Divider(
                                                            thickness: 2.0,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                        10.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .team1!
                                                                        .teamIcon,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  widget.team1!
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                5.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              'RED CARD',
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    fontSize: 20.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          '${fixtureDetailsTeamEventsRecord.redCard.where((e) => e.team?.id == widget.team1?.reference.id).toList().length.toString()} - ${fixtureDetailsTeamEventsRecord.redCard.where((e) => e.team?.id == widget.team2?.reference.id).toList().length.toString()}',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                fontSize: 24.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  widget.team2!
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                ),
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .team2!
                                                                        .teamIcon,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        15.0,
                                                                        15.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final redCT1 = fixtureDetailsTeamEventsRecord
                                                                            .redCard
                                                                            .where((e) =>
                                                                                e.team?.id ==
                                                                                widget.team1?.reference.id)
                                                                            .toList();
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: List.generate(
                                                                              redCT1.length,
                                                                              (redCT1Index) {
                                                                            final redCT1Item =
                                                                                redCT1[redCT1Index];
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                    child: Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == redCT1Item.player?.id).toList().first.photoUrl,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Text(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == redCT1Item.player?.id).toList().first.displayName,
                                                                                        style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final redCT2 = fixtureDetailsTeamEventsRecord
                                                                            .redCard
                                                                            .where((e) =>
                                                                                e.team?.id ==
                                                                                widget.team2?.reference.id)
                                                                            .toList();
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: List.generate(
                                                                              redCT2.length,
                                                                              (redCT2Index) {
                                                                            final redCT2Item =
                                                                                redCT2[redCT2Index];
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                    child: Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == redCT2Item.player?.id).toList().first.photoUrl,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    containerUsersRecordList.where((e) => e.reference.id == redCT2Item.player?.id).toList().first.displayName,
                                                                                    style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Divider(
                                                            thickness: 2.0,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                        10.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .team1!
                                                                        .teamIcon,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  widget.team1!
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                5.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              'FREE KICK',
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: Color(0xFF05F6FB),
                                                                                    fontSize: 20.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          '${fixtureDetailsTeamEventsRecord.freeKick.where((e) => e.team?.id == widget.team1?.reference.id).toList().length.toString()} - ${fixtureDetailsTeamEventsRecord.freeKick.where((e) => e.team?.id == widget.team2?.reference.id).toList().length.toString()}',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                fontSize: 24.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  widget.team2!
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                ),
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .team2!
                                                                        .teamIcon,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        15.0,
                                                                        15.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final freeKickCT1 = fixtureDetailsTeamEventsRecord
                                                                            .freeKick
                                                                            .where((e) =>
                                                                                e.team?.id ==
                                                                                widget.team1?.reference.id)
                                                                            .toList();
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: List.generate(
                                                                              freeKickCT1.length,
                                                                              (freeKickCT1Index) {
                                                                            final freeKickCT1Item =
                                                                                freeKickCT1[freeKickCT1Index];
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                    child: Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == freeKickCT1Item.player?.id).toList().first.photoUrl,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Text(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == freeKickCT1Item.player?.id).toList().first.displayName,
                                                                                        style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final freeKickCT2 = fixtureDetailsTeamEventsRecord
                                                                            .freeKick
                                                                            .where((e) =>
                                                                                e.team?.id ==
                                                                                widget.team2?.reference.id)
                                                                            .toList();
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: List.generate(
                                                                              freeKickCT2.length,
                                                                              (freeKickCT2Index) {
                                                                            final freeKickCT2Item =
                                                                                freeKickCT2[freeKickCT2Index];
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                    child: Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == freeKickCT2Item.player?.id).toList().first.photoUrl,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    containerUsersRecordList.where((e) => e.reference.id == freeKickCT2Item.player?.id).toList().first.displayName,
                                                                                    style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Divider(
                                                            thickness: 2.0,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                        10.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .team1!
                                                                        .teamIcon,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  widget.team1!
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                5.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              'FOUL',
                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                    fontFamily: 'Roboto',
                                                                                    color: Color(0xFFFF4708),
                                                                                    fontSize: 20.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          '${fixtureDetailsTeamEventsRecord.foul.where((e) => e.team?.id == widget.team1?.reference.id).toList().length.toString()} - ${fixtureDetailsTeamEventsRecord.foul.where((e) => e.team?.id == widget.team2?.reference.id).toList().length.toString()}',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                fontFamily: 'Roboto',
                                                                                fontSize: 24.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  widget.team2!
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                ),
                                                                Container(
                                                                  width: 30.0,
                                                                  height: 30.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    widget
                                                                        .team2!
                                                                        .teamIcon,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        15.0,
                                                                        15.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final foulCT1 = fixtureDetailsTeamEventsRecord
                                                                            .foul
                                                                            .where((e) =>
                                                                                e.team?.id ==
                                                                                widget.team1?.reference.id)
                                                                            .toList();
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: List.generate(
                                                                              foulCT1.length,
                                                                              (foulCT1Index) {
                                                                            final foulCT1Item =
                                                                                foulCT1[foulCT1Index];
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                    child: Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == foulCT1Item.player?.id).toList().first.photoUrl,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Text(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == foulCT1Item.player?.id).toList().first.displayName,
                                                                                        style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                              fontFamily: 'Roboto',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final foulCT2 = fixtureDetailsTeamEventsRecord
                                                                            .foul
                                                                            .where((e) =>
                                                                                e.team?.id ==
                                                                                widget.team2?.reference.id)
                                                                            .toList();
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: List.generate(
                                                                              foulCT2.length,
                                                                              (foulCT2Index) {
                                                                            final foulCT2Item =
                                                                                foulCT2[foulCT2Index];
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                    child: Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        containerUsersRecordList.where((e) => e.reference.id == foulCT2Item.player?.id).toList().first.photoUrl,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    containerUsersRecordList.where((e) => e.reference.id == foulCT2Item.player?.id).toList().first.displayName,
                                                                                    style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
