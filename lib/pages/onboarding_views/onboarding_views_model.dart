import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'onboarding_views_widget.dart' show OnboardingViewsWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnboardingViewsModel extends FlutterFlowModel<OnboardingViewsWidget> {
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
  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberController;
  String? Function(BuildContext, String?)? phoneNumberControllerValidator;
  String? _phoneNumberControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Mobile Number is required';
    }

    if (val.length > 10) {
      return 'Maximum 10 characters allowed, currently ${val.length}.';
    }
    if (!RegExp('\\d{10}').hasMatch(val)) {
      return 'Invalid mobile number';
    }
    return null;
  }

  // State field(s) for optText widget.
  FocusNode? optTextFocusNode;
  TextEditingController? optTextController;
  String? Function(BuildContext, String?)? optTextControllerValidator;
  String? _optTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'OTP is required';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    phoneNumberControllerValidator = _phoneNumberControllerValidator;
    optTextControllerValidator = _optTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    phoneNumberFocusNode?.dispose();
    phoneNumberController?.dispose();

    optTextFocusNode?.dispose();
    optTextController?.dispose();
  }
}
