import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/load_wallet_widget.dart';
import '/components/menu_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'game_info_widget.dart' show GameInfoWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class GameInfoModel extends FlutterFlowModel<GameInfoWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Carousel widget.
  CarouselController? carouselController;

  int carouselCurrentIndex = 1;

  // Stores action output result for [Alert Dialog - Custom Dialog] action in Icon widget.
  String? menuAction;
  // Stores action output result for [Backend Call - API (Remove Participant)] action in Icon widget.
  ApiCallResponse? apiResult3;
  // Stores action output result for [Backend Call - API (Join Event)] action in Button widget.
  ApiCallResponse? apiResultq75;
  // Stores action output result for [Backend Call - API (Leave Event)] action in Button widget.
  ApiCallResponse? apiResult2;
  // Stores action output result for [Backend Call - API (Cancel Event)] action in Button widget.
  ApiCallResponse? apiResult5;
  // Stores action output result for [Backend Call - API (Make Public)] action in Button widget.
  ApiCallResponse? apiResultMakePublic;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
