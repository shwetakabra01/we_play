import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/carousel_photos_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'play_widget.dart' show PlayWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class PlayModel extends FlutterFlowModel<PlayWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for filterEventsDd widget.
  String? filterEventsDdValue1;
  FormFieldController<String>? filterEventsDdValueController1;
  // State field(s) for filterEventsDd widget.
  List<String>? filterEventsDdValue2;
  FormFieldController<List<String>>? filterEventsDdValueController2;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<EventsRecord>? eventsForRefCopy;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<EventsRecord>? eventsForRef;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<EventsRecord>? eventsForRef2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
