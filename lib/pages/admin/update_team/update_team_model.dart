import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'update_team_widget.dart' show UpdateTeamWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpdateTeamModel extends FlutterFlowModel<UpdateTeamWidget> {
  ///  Local state fields for this page.

  List<TeamMemberStruct> selectedMembers = [];
  void addToSelectedMembers(TeamMemberStruct item) => selectedMembers.add(item);
  void removeFromSelectedMembers(TeamMemberStruct item) =>
      selectedMembers.remove(item);
  void removeAtIndexFromSelectedMembers(int index) =>
      selectedMembers.removeAt(index);
  void insertAtIndexInSelectedMembers(int index, TeamMemberStruct item) =>
      selectedMembers.insert(index, item);
  void updateSelectedMembersAtIndex(
          int index, Function(TeamMemberStruct) updateFn) =>
      selectedMembers[index] = updateFn(selectedMembers[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for userName widget.
  FocusNode? userNameFocusNode;
  TextEditingController? userNameTextController;
  String? Function(BuildContext, String?)? userNameTextControllerValidator;
  // State field(s) for phone_number widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  // State field(s) for genderSelect widget.
  FormFieldController<List<String>>? genderSelectValueController;
  String? get genderSelectValue =>
      genderSelectValueController?.value?.firstOrNull;
  set genderSelectValue(String? val) =>
      genderSelectValueController?.value = val != null ? [val] : [];
  // State field(s) for emailId widget.
  FocusNode? emailIdFocusNode;
  TextEditingController? emailIdTextController;
  String? Function(BuildContext, String?)? emailIdTextControllerValidator;
  // State field(s) for instagramId widget.
  FocusNode? instagramIdFocusNode;
  TextEditingController? instagramIdTextController;
  String? Function(BuildContext, String?)? instagramIdTextControllerValidator;
  DateTime? datePicked;
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  // Stores action output result for [Backend Call - API (Create User)] action in Button widget.
  ApiCallResponse? apiResponse;
  // State field(s) for userDd widget.
  String? userDdValue;
  FormFieldController<String>? userDdValueController;
  // State field(s) for userRole widget.
  String? userRoleValue;
  FormFieldController<String>? userRoleValueController;
  // State field(s) for wonTxt widget.
  FocusNode? wonTxtFocusNode;
  TextEditingController? wonTxtTextController;
  String? Function(BuildContext, String?)? wonTxtTextControllerValidator;
  // State field(s) for LostTxt widget.
  FocusNode? lostTxtFocusNode;
  TextEditingController? lostTxtTextController;
  String? Function(BuildContext, String?)? lostTxtTextControllerValidator;
  // State field(s) for drawTxt widget.
  FocusNode? drawTxtFocusNode;
  TextEditingController? drawTxtTextController;
  String? Function(BuildContext, String?)? drawTxtTextControllerValidator;
  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  bool isDataUploading3 = false;
  FFUploadedFile uploadedLocalFile3 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl3 = '';

  bool isDataUploading4 = false;
  FFUploadedFile uploadedLocalFile4 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl4 = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    userNameFocusNode?.dispose();
    userNameTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    emailIdFocusNode?.dispose();
    emailIdTextController?.dispose();

    instagramIdFocusNode?.dispose();
    instagramIdTextController?.dispose();

    wonTxtFocusNode?.dispose();
    wonTxtTextController?.dispose();

    lostTxtFocusNode?.dispose();
    lostTxtTextController?.dispose();

    drawTxtFocusNode?.dispose();
    drawTxtTextController?.dispose();
  }
}
