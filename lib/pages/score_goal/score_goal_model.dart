import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'score_goal_widget.dart' show ScoreGoalWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScoreGoalModel extends FlutterFlowModel<ScoreGoalWidget> {
  ///  Local state fields for this component.

  UsersRecord? selectedPlayer;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
