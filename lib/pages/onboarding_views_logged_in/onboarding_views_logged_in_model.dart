import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'onboarding_views_logged_in_widget.dart'
    show OnboardingViewsLoggedInWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnboardingViewsLoggedInModel
    extends FlutterFlowModel<OnboardingViewsLoggedInWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for emailId widget.
  FocusNode? emailIdFocusNode;
  TextEditingController? emailIdTextController;
  String? Function(BuildContext, String?)? emailIdTextControllerValidator;
  String? _emailIdTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Email is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Invalid email';
    }
    return null;
  }

  // State field(s) for fullName widget.
  FocusNode? fullNameFocusNode;
  TextEditingController? fullNameTextController;
  String? Function(BuildContext, String?)? fullNameTextControllerValidator;
  String? _fullNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Name is required';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }
    if (val.length > 50) {
      return 'Maximum characters limit reached';
    }

    return null;
  }

  // State field(s) for genderSelect widget.
  FormFieldController<List<String>>? genderSelectValueController;
  String? get genderSelectValue =>
      genderSelectValueController?.value?.firstOrNull;
  set genderSelectValue(String? val) =>
      genderSelectValueController?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  // Stores action output result for [Backend Call - API (SetCurrentAddress)] action in Button widget.
  ApiCallResponse? area;

  @override
  void initState(BuildContext context) {
    emailIdTextControllerValidator = _emailIdTextControllerValidator;
    fullNameTextControllerValidator = _fullNameTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    emailIdFocusNode?.dispose();
    emailIdTextController?.dispose();

    fullNameFocusNode?.dispose();
    fullNameTextController?.dispose();
  }
}
