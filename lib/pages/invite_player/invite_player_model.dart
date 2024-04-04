import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'invite_player_widget.dart' show InvitePlayerWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InvitePlayerModel extends FlutterFlowModel<InvitePlayerWidget> {
  ///  Local state fields for this page.

  List<UsersRecord> selectedUsers = [];
  void addToSelectedUsers(UsersRecord item) => selectedUsers.add(item);
  void removeFromSelectedUsers(UsersRecord item) => selectedUsers.remove(item);
  void removeAtIndexFromSelectedUsers(int index) =>
      selectedUsers.removeAt(index);
  void insertAtIndexInSelectedUsers(int index, UsersRecord item) =>
      selectedUsers.insert(index, item);
  void updateSelectedUsersAtIndex(int index, Function(UsersRecord) updateFn) =>
      selectedUsers[index] = updateFn(selectedUsers[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in InvitePlayer widget.
  List<UsersRecord>? invitedUsers;
  // State field(s) for guests widget.
  FocusNode? guestsFocusNode;
  TextEditingController? guestsController;
  String? Function(BuildContext, String?)? guestsControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    guestsFocusNode?.dispose();
    guestsController?.dispose();
  }
}
