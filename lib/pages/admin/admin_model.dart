import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/menu_component_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'admin_widget.dart' show AdminWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminModel extends FlutterFlowModel<AdminWidget> {
  ///  Local state fields for this page.

  UsersRecord? selectedUser;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountTextController;
  String? Function(BuildContext, String?)? amountTextControllerValidator;
  // State field(s) for faceUserDD widget.
  String? faceUserDDValue;
  FormFieldController<String>? faceUserDDValueController;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (Generate Face Id)] action in Button widget.
  ApiCallResponse? apiResulttaq;
  // Stores action output result for [Backend Call - API (getImages AWS)] action in Button widget.
  ApiCallResponse? apiResult3da;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Icon widget.
  String? menuAction;
  // State field(s) for ddlTeam1 widget.
  String? ddlTeam1Value;
  FormFieldController<String>? ddlTeam1ValueController;
  // State field(s) for ddlTeam2 widget.
  String? ddlTeam2Value;
  FormFieldController<String>? ddlTeam2ValueController;
  DateTime? datePicked;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    amountFocusNode?.dispose();
    amountTextController?.dispose();
  }
}
