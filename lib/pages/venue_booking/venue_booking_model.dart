import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/structs/index.dart';
import '/components/load_wallet_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'venue_booking_widget.dart' show VenueBookingWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VenueBookingModel extends FlutterFlowModel<VenueBookingWidget> {
  ///  Local state fields for this page.

  int? numberOfTurfs = 2;

  List<String> timeOptions = [];
  void addToTimeOptions(String item) => timeOptions.add(item);
  void removeFromTimeOptions(String item) => timeOptions.remove(item);
  void removeAtIndexFromTimeOptions(int index) => timeOptions.removeAt(index);
  void insertAtIndexInTimeOptions(int index, String item) =>
      timeOptions.insert(index, item);
  void updateTimeOptionsAtIndex(int index, Function(String) updateFn) =>
      timeOptions[index] = updateFn(timeOptions[index]);

  double? turfCost;

  int? turfPlayers;

  List<int> timeButtons = [];
  void addToTimeButtons(int item) => timeButtons.add(item);
  void removeFromTimeButtons(int item) => timeButtons.remove(item);
  void removeAtIndexFromTimeButtons(int index) => timeButtons.removeAt(index);
  void insertAtIndexInTimeButtons(int index, int item) =>
      timeButtons.insert(index, item);
  void updateTimeButtonsAtIndex(int index, Function(int) updateFn) =>
      timeButtons[index] = updateFn(timeButtons[index]);

  int? startTimeBtn;

  int? endTimeBtn;

  double bookingCost = 0.0;

  VenueOfferStruct? applicableOffer;
  void updateApplicableOfferStruct(Function(VenueOfferStruct) updateFn) =>
      updateFn(applicableOffer ??= VenueOfferStruct());

  BookingValidationsStruct? validations;
  void updateValidationsStruct(Function(BookingValidationsStruct) updateFn) =>
      updateFn(validations ??= BookingValidationsStruct());

  double organizerShare = 0.0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for turfs widget.
  FormFieldController<List<String>>? turfsValueController;
  String? get turfsValue => turfsValueController?.value?.firstOrNull;
  set turfsValue(String? val) =>
      turfsValueController?.value = val != null ? [val] : [];
  // State field(s) for availsports widget.
  FormFieldController<List<String>>? availsportsValueController;
  String? get availsportsValue =>
      availsportsValueController?.value?.firstOrNull;
  set availsportsValue(String? val) =>
      availsportsValueController?.value = val != null ? [val] : [];
  // State field(s) for numberOfTurfs widget.
  FormFieldController<List<String>>? numberOfTurfsValueController;
  String? get numberOfTurfsValue =>
      numberOfTurfsValueController?.value?.firstOrNull;
  set numberOfTurfsValue(String? val) =>
      numberOfTurfsValueController?.value = val != null ? [val] : [];
  // State field(s) for eventDate widget.
  FormFieldController<List<String>>? eventDateValueController;
  String? get eventDateValue => eventDateValueController?.value?.firstOrNull;
  set eventDateValue(String? val) =>
      eventDateValueController?.value = val != null ? [val] : [];
  DateTime? datePicked;
  // State field(s) for spliCost widget.
  bool? spliCostValue;
  // State field(s) for participants widget.
  FocusNode? participantsFocusNode;
  TextEditingController? participantsController;
  String? Function(BuildContext, String?)? participantsControllerValidator;
  String? _participantsControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (Create Event)] action in Button widget.
  ApiCallResponse? createApiResponse;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<EventsRecord>? eventsCreated;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<UsersRecord>? usersForNotification;

  @override
  void initState(BuildContext context) {
    participantsControllerValidator = _participantsControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    participantsFocusNode?.dispose();
    participantsController?.dispose();
  }
}
