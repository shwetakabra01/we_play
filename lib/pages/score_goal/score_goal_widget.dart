import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'score_goal_model.dart';
export 'score_goal_model.dart';

class ScoreGoalWidget extends StatefulWidget {
  const ScoreGoalWidget({
    super.key,
    required this.teamEventP,
    required this.team1,
    required this.titleText,
    required this.timer,
  });

  final TeamEventsRecord? teamEventP;
  final TeamsRecord? team1;
  final String? titleText;
  final String? timer;

  @override
  State<ScoreGoalWidget> createState() => _ScoreGoalWidgetState();
}

class _ScoreGoalWidgetState extends State<ScoreGoalWidget> {
  late ScoreGoalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScoreGoalModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: StreamBuilder<List<UsersRecord>>(
        stream: queryUsersRecord(
          queryBuilder: (usersRecord) => usersRecord.whereIn(
              'uid', widget.team1?.memberRefs?.map((e) => e.id).toList()),
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
          List<UsersRecord> containerUsersRecordList = snapshot.data!;
          return Container(
            width: MediaQuery.sizeOf(context).width * 0.95,
            height: 500.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Update ${widget.titleText}',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'Roboto',
                              fontSize: 18.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context).accent4,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 15.0),
                    child: Builder(
                      builder: (context) {
                        final userRecs2 = containerUsersRecordList.toList();
                        return Wrap(
                          spacing: 10.0,
                          runSpacing: 10.0,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.horizontal,
                          runAlignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          clipBehavior: Clip.none,
                          children:
                              List.generate(userRecs2.length, (userRecs2Index) {
                            final userRecs2Item = userRecs2[userRecs2Index];
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  _model.selectedPlayer = userRecs2Item;
                                });
                              },
                              child: Container(
                                width: 150.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 5.0, 0.0),
                                      child: Container(
                                        width: 30.0,
                                        height: 30.0,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          userRecs2Item.photoUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          userRecs2Item.displayName,
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                fontFamily: 'Roboto',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                    if (userRecs2Item.reference.id ==
                                        _model.selectedPlayer?.reference.id)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 5.0, 0.0),
                                        child: Icon(
                                          Icons.check_circle_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .success,
                                          size: 24.0,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context).accent4,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 10.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          text: 'Cancel',
                          options: FFButtonOptions(
                            width: 100.0,
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Roboto',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 5.0, 10.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (_model.selectedPlayer != null) {
                                if (widget.titleText == 'Goals') {
                                  await widget.teamEventP!.reference.update({
                                    ...mapToFirestore(
                                      {
                                        'goals': FieldValue.arrayUnion([
                                          getScoreDetailsFirestoreData(
                                            createScoreDetailsStruct(
                                              player: _model
                                                  .selectedPlayer?.reference,
                                              team: widget.team1?.reference,
                                              datetime: getCurrentTimestamp,
                                              timer: widget.timer,
                                              clearUnsetFields: false,
                                            ),
                                            true,
                                          )
                                        ]),
                                      },
                                    ),
                                  });
                                } else if (widget.titleText == 'Corner') {
                                  await widget.teamEventP!.reference.update({
                                    ...mapToFirestore(
                                      {
                                        'corners': FieldValue.arrayUnion([
                                          getScoreDetailsFirestoreData(
                                            createScoreDetailsStruct(
                                              player: _model
                                                  .selectedPlayer?.reference,
                                              team: widget.team1?.reference,
                                              datetime: getCurrentTimestamp,
                                              timer: widget.timer,
                                              clearUnsetFields: false,
                                            ),
                                            true,
                                          )
                                        ]),
                                      },
                                    ),
                                  });
                                } else if (widget.titleText == 'YellowCard') {
                                  await widget.teamEventP!.reference.update({
                                    ...mapToFirestore(
                                      {
                                        'yellowCard': FieldValue.arrayUnion([
                                          getScoreDetailsFirestoreData(
                                            createScoreDetailsStruct(
                                              player: _model
                                                  .selectedPlayer?.reference,
                                              team: widget.team1?.reference,
                                              datetime: getCurrentTimestamp,
                                              timer: widget.timer,
                                              clearUnsetFields: false,
                                            ),
                                            true,
                                          )
                                        ]),
                                      },
                                    ),
                                  });
                                } else if (widget.titleText == 'RedCard') {
                                  await widget.teamEventP!.reference.update({
                                    ...mapToFirestore(
                                      {
                                        'redCard': FieldValue.arrayUnion([
                                          getScoreDetailsFirestoreData(
                                            createScoreDetailsStruct(
                                              player: _model
                                                  .selectedPlayer?.reference,
                                              team: widget.team1?.reference,
                                              datetime: getCurrentTimestamp,
                                              timer: widget.timer,
                                              clearUnsetFields: false,
                                            ),
                                            true,
                                          )
                                        ]),
                                      },
                                    ),
                                  });
                                } else if (widget.titleText == 'FreeKick') {
                                  await widget.teamEventP!.reference.update({
                                    ...mapToFirestore(
                                      {
                                        'freeKick': FieldValue.arrayUnion([
                                          getScoreDetailsFirestoreData(
                                            createScoreDetailsStruct(
                                              player: _model
                                                  .selectedPlayer?.reference,
                                              team: widget.team1?.reference,
                                              datetime: getCurrentTimestamp,
                                              timer: widget.timer,
                                              clearUnsetFields: false,
                                            ),
                                            true,
                                          )
                                        ]),
                                      },
                                    ),
                                  });
                                } else if (widget.titleText == 'Foul') {
                                  await widget.teamEventP!.reference.update({
                                    ...mapToFirestore(
                                      {
                                        'foul': FieldValue.arrayUnion([
                                          getScoreDetailsFirestoreData(
                                            createScoreDetailsStruct(
                                              player: _model
                                                  .selectedPlayer?.reference,
                                              team: widget.team1?.reference,
                                              datetime: getCurrentTimestamp,
                                              timer: widget.timer,
                                              clearUnsetFields: false,
                                            ),
                                            true,
                                          )
                                        ]),
                                      },
                                    ),
                                  });
                                }

                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Success'),
                                      content: Text(
                                          '${widget.titleText} added successfully'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                Navigator.pop(context, widget.titleText);
                              }
                            },
                            text: 'Update ${widget.titleText}',
                            options: FFButtonOptions(
                              width: 200.0,
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primaryText,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
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
    );
  }
}
