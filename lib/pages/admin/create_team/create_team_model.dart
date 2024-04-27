import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'create_team_widget.dart' show CreateTeamWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateTeamModel extends FlutterFlowModel<CreateTeamWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for teamName widget.
  FocusNode? teamNameFocusNode;
  TextEditingController? teamNameTextController;
  String? Function(BuildContext, String?)? teamNameTextControllerValidator;
  // State field(s) for teamOwner widget.
  FocusNode? teamOwnerFocusNode;
  TextEditingController? teamOwnerTextController;
  String? Function(BuildContext, String?)? teamOwnerTextControllerValidator;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    teamNameFocusNode?.dispose();
    teamNameTextController?.dispose();

    teamOwnerFocusNode?.dispose();
    teamOwnerTextController?.dispose();
  }
}
