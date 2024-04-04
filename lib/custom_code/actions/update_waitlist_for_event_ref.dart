// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future updateWaitlistForEventRef(DocumentReference eventDocRef) async {
  // Add your function code here!
  EventsRecord eventRec = await EventsRecord.getDocument(eventDocRef).first;
  var participants = eventRec.participants;
  if (participants != null) {
    for (var i = 0; i < participants.length; i++) {
      participants[i].status =
          (i < eventRec.playersCapacity) ? 'Confirm' : 'WL';
    }
    await eventRec.reference.update({
      'participants':
          getEventParticipantListFirestoreData(participants.toList())
    });
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!
