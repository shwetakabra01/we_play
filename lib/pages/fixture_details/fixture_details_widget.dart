import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
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

class _FixtureDetailsWidgetState extends State<FixtureDetailsWidget> {
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
                'Match Details',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontSize: 18.0,
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
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (currentUserDocument?.userRole ==
                                  UserRole.ADMIN)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 5.0, 0.0, 5.0),
                                  child: AuthUserStreamWidget(
                                    builder: (context) => Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        FlutterFlowIconButton(
                                          borderRadius: 20.0,
                                          borderWidth: 1.0,
                                          buttonSize: 40.0,
                                          disabledIconColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          icon: Icon(
                                            Icons.play_arrow,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24.0,
                                          ),
                                          onPressed:
                                              !((fixtureDetailsTeamEventsRecord
                                                              .status ==
                                                          'Created') ||
                                                      (fixtureDetailsTeamEventsRecord
                                                              .status ==
                                                          'Paused'))
                                                  ? null
                                                  : () async {
                                                      var confirmDialogResponse =
                                                          await showDialog<
                                                                  bool>(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (alertDialogContext) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Start Match'),
                                                                    content: Text(
                                                                        'Are you sure you want to start the match?'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                        child: Text(
                                                                            'Cancel'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                        child: Text(
                                                                            'Confirm'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ) ??
                                                              false;
                                                      if (confirmDialogResponse) {
                                                        _model.timerController
                                                            .onStartTimer();
                                                        if (fixtureDetailsTeamEventsRecord
                                                                .status ==
                                                            'Created') {
                                                          await widget
                                                              .fixtureRef!
                                                              .update(
                                                                  createTeamEventsRecordData(
                                                            status:
                                                                'In Progress',
                                                            durationAtPause: 0,
                                                            lastStartTime:
                                                                getCurrentTimestamp,
                                                            startTime:
                                                                getCurrentTimestamp,
                                                          ));
                                                        } else {
                                                          if (fixtureDetailsTeamEventsRecord
                                                                  .status ==
                                                              'Paused') {
                                                            await widget
                                                                .fixtureRef!
                                                                .update(
                                                                    createTeamEventsRecordData(
                                                              status:
                                                                  'In Progress',
                                                              lastStartTime:
                                                                  getCurrentTimestamp,
                                                            ));
                                                          }
                                                        }

                                                        setState(() {
                                                          _model.timerStarted =
                                                              true;
                                                        });
                                                      }
                                                    },
                                        ),
                                        FlutterFlowTimer(
                                          initialTime: _model.timerMilliseconds,
                                          getDisplayTime: (value) =>
                                              StopWatchTimer.getDisplayTime(
                                            value,
                                            hours: false,
                                            milliSecond: false,
                                          ),
                                          controller: _model.timerController,
                                          updateStateInterval:
                                              Duration(milliseconds: 10000),
                                          onChanged: (value, displayTime,
                                              shouldUpdate) {
                                            _model.timerMilliseconds = value;
                                            _model.timerValue = displayTime;
                                            if (shouldUpdate) setState(() {});
                                          },
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .headlineLarge
                                              .override(
                                                fontFamily: 'Roboto',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        FlutterFlowIconButton(
                                          borderRadius: 20.0,
                                          borderWidth: 1.0,
                                          buttonSize: 40.0,
                                          disabledIconColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          icon: Icon(
                                            Icons.pause,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24.0,
                                          ),
                                          onPressed:
                                              (fixtureDetailsTeamEventsRecord
                                                          .status !=
                                                      'In Progress')
                                                  ? null
                                                  : () async {
                                                      var confirmDialogResponse =
                                                          await showDialog<
                                                                  bool>(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (alertDialogContext) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Pause Match'),
                                                                    content: Text(
                                                                        'Are you sure you want to pause the match?'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                        child: Text(
                                                                            'Cancel'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                        child: Text(
                                                                            'Confirm'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ) ??
                                                              false;
                                                      if (confirmDialogResponse) {
                                                        _model.timerController
                                                            .onStopTimer();

                                                        await widget.fixtureRef!
                                                            .update(
                                                                createTeamEventsRecordData(
                                                          status: 'Paused',
                                                          durationAtPause: _model
                                                              .timerMilliseconds,
                                                        ));
                                                        setState(() {
                                                          _model.timerStarted =
                                                              false;
                                                        });
                                                      }
                                                    },
                                        ),
                                        FlutterFlowIconButton(
                                          borderRadius: 20.0,
                                          borderWidth: 1.0,
                                          buttonSize: 40.0,
                                          disabledIconColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          icon: Icon(
                                            Icons.stop,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24.0,
                                          ),
                                          onPressed:
                                              (fixtureDetailsTeamEventsRecord
                                                          .status !=
                                                      'In Progress')
                                                  ? null
                                                  : () async {
                                                      var confirmDialogResponse =
                                                          await showDialog<
                                                                  bool>(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (alertDialogContext) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'End Match'),
                                                                    content: Text(
                                                                        'Are you sure you want to end the match?'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                        child: Text(
                                                                            'Cancel'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                        child: Text(
                                                                            'Confirm'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ) ??
                                                              false;
                                                      if (confirmDialogResponse) {
                                                        _model.timerController
                                                            .onStopTimer();

                                                        await widget.fixtureRef!
                                                            .update(
                                                                createTeamEventsRecordData(
                                                          status: 'Completed',
                                                          durationInMillis: _model
                                                              .timerMilliseconds,
                                                          endTime:
                                                              getCurrentTimestamp,
                                                        ));

                                                        await widget
                                                            .team1!.reference
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'won': FieldValue.increment(fixtureDetailsTeamEventsRecord
                                                                          .goals
                                                                          .where((e) =>
                                                                              e.team ==
                                                                              widget
                                                                                  .team1?.reference)
                                                                          .toList()
                                                                          .length >
                                                                      fixtureDetailsTeamEventsRecord
                                                                          .goals
                                                                          .where((e) =>
                                                                              e.team ==
                                                                              widget.team2?.reference)
                                                                          .toList()
                                                                          .length
                                                                  ? 1
                                                                  : 0),
                                                              'lost': FieldValue.increment(fixtureDetailsTeamEventsRecord
                                                                          .goals
                                                                          .where((e) =>
                                                                              e.team ==
                                                                              widget
                                                                                  .team1?.reference)
                                                                          .toList()
                                                                          .length <
                                                                      fixtureDetailsTeamEventsRecord
                                                                          .goals
                                                                          .where((e) =>
                                                                              e.team ==
                                                                              widget.team2?.reference)
                                                                          .toList()
                                                                          .length
                                                                  ? 1
                                                                  : 0),
                                                              'draw': FieldValue.increment(fixtureDetailsTeamEventsRecord
                                                                          .goals
                                                                          .where((e) =>
                                                                              e.team ==
                                                                              widget
                                                                                  .team1?.reference)
                                                                          .toList()
                                                                          .length ==
                                                                      fixtureDetailsTeamEventsRecord
                                                                          .goals
                                                                          .where((e) =>
                                                                              e.team ==
                                                                              widget.team2?.reference)
                                                                          .toList()
                                                                          .length
                                                                  ? 1
                                                                  : 0),
                                                            },
                                                          ),
                                                        });

                                                        await widget
                                                            .team2!.reference
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'won': FieldValue.increment(fixtureDetailsTeamEventsRecord
                                                                          .goals
                                                                          .where((e) =>
                                                                              e.team ==
                                                                              widget
                                                                                  .team1?.reference)
                                                                          .toList()
                                                                          .length <
                                                                      fixtureDetailsTeamEventsRecord
                                                                          .goals
                                                                          .where((e) =>
                                                                              e.team ==
                                                                              widget.team2?.reference)
                                                                          .toList()
                                                                          .length
                                                                  ? 1
                                                                  : 0),
                                                              'lost': FieldValue.increment(fixtureDetailsTeamEventsRecord
                                                                          .goals
                                                                          .where((e) =>
                                                                              e.team ==
                                                                              widget
                                                                                  .team1?.reference)
                                                                          .toList()
                                                                          .length >
                                                                      fixtureDetailsTeamEventsRecord
                                                                          .goals
                                                                          .where((e) =>
                                                                              e.team ==
                                                                              widget.team2?.reference)
                                                                          .toList()
                                                                          .length
                                                                  ? 1
                                                                  : 0),
                                                              'draw': FieldValue.increment(fixtureDetailsTeamEventsRecord
                                                                          .goals
                                                                          .where((e) =>
                                                                              e.team ==
                                                                              widget
                                                                                  .team1?.reference)
                                                                          .toList()
                                                                          .length ==
                                                                      fixtureDetailsTeamEventsRecord
                                                                          .goals
                                                                          .where((e) =>
                                                                              e.team ==
                                                                              widget.team2?.reference)
                                                                          .toList()
                                                                          .length
                                                                  ? 1
                                                                  : 0),
                                                            },
                                                          ),
                                                        });
                                                        setState(() {
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
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (currentUserPhoto != null &&
                                    currentUserPhoto != '')
                                  AuthUserStreamWidget(
                                    builder: (context) => Container(
                                      width: 30.0,
                                      height: 30.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        widget.team1!.teamIcon,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                Text(
                                  widget.team1!.name,
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                                Text(
                                  '  vs  ',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  widget.team2!.name,
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                                if (currentUserPhoto != null &&
                                    currentUserPhoto != '')
                                  AuthUserStreamWidget(
                                    builder: (context) => Container(
                                      width: 30.0,
                                      height: 30.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        widget.team2!.teamIcon,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 15.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if ((currentUserDocument?.userRole ==
                                                UserRole.ADMIN) &&
                                            _model.timerStarted) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: ScoreGoalWidget(
                                                    teamEventP:
                                                        fixtureDetailsTeamEventsRecord,
                                                    team1: widget.team1!,
                                                    titleText: 'Goals',
                                                    timer: _model.timerValue,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => safeSetState(
                                              () => _model.tt = value));

                                          if (_model.tt == 'Goals') {
                                            setState(() {
                                              _model.allowUndo = true;
                                            });
                                          }
                                        }

                                        setState(() {});
                                      },
                                      child: Text(
                                        'Goal',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Roboto',
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 40.0, 0.0),
                                  child: Text(
                                    fixtureDetailsTeamEventsRecord.goals
                                        .where((e) =>
                                            e.team?.id ==
                                            widget.team1?.reference.id)
                                        .toList()
                                        .length
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Icon(
                                  Icons.sports_soccer,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      40.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    fixtureDetailsTeamEventsRecord.goals
                                        .where((e) =>
                                            e.team?.id ==
                                            widget.team2?.reference.id)
                                        .toList()
                                        .length
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if ((currentUserDocument?.userRole ==
                                                UserRole.ADMIN) &&
                                            _model.timerStarted) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: ScoreGoalWidget(
                                                    teamEventP:
                                                        fixtureDetailsTeamEventsRecord,
                                                    team1: widget.team2!,
                                                    titleText: 'Goals',
                                                    timer: _model.timerValue,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => safeSetState(
                                              () => _model.tt2 = value));

                                          if (_model.tt2 == 'Goals') {
                                            setState(() {
                                              _model.allowUndo = true;
                                            });
                                          }
                                        }

                                        setState(() {});
                                      },
                                      child: Text(
                                        'Goal',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 15.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if ((currentUserDocument?.userRole ==
                                                UserRole.ADMIN) &&
                                            _model.timerStarted) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: ScoreGoalWidget(
                                                    teamEventP:
                                                        fixtureDetailsTeamEventsRecord,
                                                    team1: widget.team1!,
                                                    titleText: 'Corner',
                                                    timer: _model.timerValue,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        }
                                      },
                                      child: Text(
                                        'Corner',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 40.0, 0.0),
                                  child: Text(
                                    fixtureDetailsTeamEventsRecord.corners
                                        .where((e) =>
                                            e.team?.id ==
                                            widget.team1?.reference.id)
                                        .toList()
                                        .length
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Icon(
                                  Icons.flag_circle_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      40.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    fixtureDetailsTeamEventsRecord.corners
                                        .where((e) =>
                                            e.team?.id ==
                                            widget.team2?.reference.id)
                                        .toList()
                                        .length
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if ((currentUserDocument?.userRole ==
                                                UserRole.ADMIN) &&
                                            _model.timerStarted) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: ScoreGoalWidget(
                                                    teamEventP:
                                                        fixtureDetailsTeamEventsRecord,
                                                    team1: widget.team2!,
                                                    titleText: 'Corner',
                                                    timer: _model.timerValue,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        }
                                      },
                                      child: Text(
                                        'Corner',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 15.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if ((currentUserDocument?.userRole ==
                                                UserRole.ADMIN) &&
                                            _model.timerStarted) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: ScoreGoalWidget(
                                                    teamEventP:
                                                        fixtureDetailsTeamEventsRecord,
                                                    team1: widget.team1!,
                                                    titleText: 'YellowCard',
                                                    timer: _model.timerValue,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        }
                                      },
                                      child: Text(
                                        'Yellow Card',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 40.0, 0.0),
                                  child: Text(
                                    fixtureDetailsTeamEventsRecord.yellowCard
                                        .where((e) =>
                                            e.team?.id ==
                                            widget.team1?.reference.id)
                                        .toList()
                                        .length
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Icon(
                                  Icons.sim_card_sharp,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      40.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    fixtureDetailsTeamEventsRecord.yellowCard
                                        .where((e) =>
                                            e.team?.id ==
                                            widget.team2?.reference.id)
                                        .toList()
                                        .length
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if ((currentUserDocument?.userRole ==
                                                UserRole.ADMIN) &&
                                            _model.timerStarted) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: ScoreGoalWidget(
                                                    teamEventP:
                                                        fixtureDetailsTeamEventsRecord,
                                                    team1: widget.team2!,
                                                    titleText: 'YellowCard',
                                                    timer: _model.timerValue,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        }
                                      },
                                      child: Text(
                                        'Yellow Card',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 15.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if ((currentUserDocument?.userRole ==
                                                UserRole.ADMIN) &&
                                            _model.timerStarted) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: ScoreGoalWidget(
                                                    teamEventP:
                                                        fixtureDetailsTeamEventsRecord,
                                                    team1: widget.team1!,
                                                    titleText: 'RedCard',
                                                    timer: _model.timerValue,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        }
                                      },
                                      child: Text(
                                        'Red Card',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 40.0, 0.0),
                                  child: Text(
                                    fixtureDetailsTeamEventsRecord.redCard
                                        .where((e) =>
                                            e.team?.id ==
                                            widget.team1?.reference.id)
                                        .toList()
                                        .length
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Icon(
                                  Icons.sim_card_alert,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      40.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    fixtureDetailsTeamEventsRecord.redCard
                                        .where((e) =>
                                            e.team?.id ==
                                            widget.team2?.reference.id)
                                        .toList()
                                        .length
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if ((currentUserDocument?.userRole ==
                                                UserRole.ADMIN) &&
                                            _model.timerStarted) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: ScoreGoalWidget(
                                                    teamEventP:
                                                        fixtureDetailsTeamEventsRecord,
                                                    team1: widget.team2!,
                                                    titleText: 'RedCard',
                                                    timer: _model.timerValue,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        }
                                      },
                                      child: Text(
                                        'Red Card',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 15.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if ((currentUserDocument?.userRole ==
                                                UserRole.ADMIN) &&
                                            _model.timerStarted) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: ScoreGoalWidget(
                                                    teamEventP:
                                                        fixtureDetailsTeamEventsRecord,
                                                    team1: widget.team1!,
                                                    titleText: 'FreeKick',
                                                    timer: _model.timerValue,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        }
                                      },
                                      child: Text(
                                        'Free Kick',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 40.0, 0.0),
                                  child: Text(
                                    fixtureDetailsTeamEventsRecord.freeKick
                                        .where((e) =>
                                            e.team?.id ==
                                            widget.team1?.reference.id)
                                        .toList()
                                        .length
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Icon(
                                  Icons.sports_handball,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      40.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    fixtureDetailsTeamEventsRecord.freeKick
                                        .where((e) =>
                                            e.team?.id ==
                                            widget.team2?.reference.id)
                                        .toList()
                                        .length
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if ((currentUserDocument?.userRole ==
                                                UserRole.ADMIN) &&
                                            _model.timerStarted) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: ScoreGoalWidget(
                                                    teamEventP:
                                                        fixtureDetailsTeamEventsRecord,
                                                    team1: widget.team2!,
                                                    titleText: 'FreeKick',
                                                    timer: _model.timerValue,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        }
                                      },
                                      child: Text(
                                        'Free Kick',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 15.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if ((currentUserDocument?.userRole ==
                                                UserRole.ADMIN) &&
                                            _model.timerStarted) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: ScoreGoalWidget(
                                                    teamEventP:
                                                        fixtureDetailsTeamEventsRecord,
                                                    team1: widget.team1!,
                                                    titleText: 'Foul',
                                                    timer: _model.timerValue,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        }
                                      },
                                      child: Text(
                                        'Foul',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 40.0, 0.0),
                                  child: Text(
                                    fixtureDetailsTeamEventsRecord.foul
                                        .where((e) =>
                                            e.team?.id ==
                                            widget.team1?.reference.id)
                                        .toList()
                                        .length
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Icon(
                                  Icons.sports_sharp,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      40.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    fixtureDetailsTeamEventsRecord.foul
                                        .where((e) =>
                                            e.team?.id ==
                                            widget.team2?.reference.id)
                                        .toList()
                                        .length
                                        .toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if ((currentUserDocument?.userRole ==
                                                UserRole.ADMIN) &&
                                            _model.timerStarted) {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: ScoreGoalWidget(
                                                    teamEventP:
                                                        fixtureDetailsTeamEventsRecord,
                                                    team1: widget.team2!,
                                                    titleText: 'Foul',
                                                    timer: _model.timerValue,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        }
                                      },
                                      child: Text(
                                        'Foul',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'Roboto',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 15.0, 15.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (currentUserDocument?.userRole ==
                                    UserRole.ADMIN)
                                  AuthUserStreamWidget(
                                    builder: (context) => FFButtonWidget(
                                      onPressed: () async {
                                        if (_model.allowUndo) {
                                          await widget.fixtureRef!.update({
                                            ...mapToFirestore(
                                              {
                                                'goals':
                                                    FieldValue.arrayRemove([
                                                  getScoreDetailsFirestoreData(
                                                    updateScoreDetailsStruct(
                                                      fixtureDetailsTeamEventsRecord
                                                          .goals.last,
                                                      clearUnsetFields: false,
                                                    ),
                                                    true,
                                                  )
                                                ]),
                                              },
                                            ),
                                          });
                                          setState(() {
                                            _model.allowUndo = false;
                                          });
                                        }
                                      },
                                      text: 'Undo Last goal',
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            2.0, 0.0, 2.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Colors.white,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Roboto',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              letterSpacing: 0.0,
                                            ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                      ),
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
