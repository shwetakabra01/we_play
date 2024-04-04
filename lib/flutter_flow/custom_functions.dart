import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

bool userPresentInEvent(
  EventsRecord eventRec,
  DocumentReference loggedInUser,
) {
  return eventRec.participantsRefs != null &&
      eventRec.participantsRefs.contains(loggedInUser);
}

double? gerProgressValue(
  int playerCapacity,
  int numberOfParticipants,
  int? numberOfGuests,
) {
  if (numberOfGuests == null) {
    numberOfGuests = 0;
  }
  if ((numberOfParticipants + numberOfGuests) > playerCapacity ||
      playerCapacity == 0) {
    return 1.0;
  }
  return (numberOfParticipants + numberOfGuests) / playerCapacity;
}

EventParticipantStruct? getParticipantDetail(
  EventsRecord eventDoc,
  DocumentReference userRef,
) {
  if (eventDoc.participants != null) {
    for (EventParticipantStruct p in eventDoc.participants) {
      if (p.userRef == userRef) {
        return p;
      }
    }
  }

  return new EventParticipantStruct();
}

VenueRecord? getVenueRef(
  List<VenueRecord>? venues,
  String? vName,
) {
  for (VenueRecord vr in venues!) {
    if (vr.name == vName) {
      return vr;
    }
  }

  return null;
}

TurfStruct? getTurfRec(
  List<TurfStruct> turfs,
  String turfSize,
) {
  if (turfs != null) {
    for (TurfStruct t in turfs) {
      if (t.size == turfSize) {
        return t;
      }
    }
  }
  return null;
}

List<DateTime>? getNextSevenDays(DateTime startDate) {
  List<DateTime> dates = [startDate];
  for (var i = 0; i < 6; i++) {
    startDate = startDate.add(Duration(days: 1));
    dates.add(startDate);
  }

  return dates;
}

DateTime? getDateTimeFromString(
  String date,
  String? timeRange,
) {
  DateFormat dateFormat = new DateFormat("MMMEd");
  var parsedDate = dateFormat.parse(date);
  var result =
      new DateTime(DateTime.now().year, parsedDate.month, parsedDate.day);

  if (timeRange != null) {
    var part = timeRange.split('M').first;
    var toAdd = 0;
    if (part.endsWith('A')) {
      part = part.substring(0, part.length - 1).trim();
      var numb = int.parse(part);
      if (numb == 12) {
        toAdd = 0;
      } else {
        toAdd = numb;
      }
    } else if (part.endsWith('P')) {
      part = part.substring(0, part.length - 1).trim();
      var numb = int.parse(part);
      if (numb == 12) {
        toAdd = 12;
      } else {
        toAdd = numb + 12;
      }
    }
    result = result.add(Duration(hours: toAdd));
  }
  return result;
}

String getTimeString(int timeIndex) {
  var timeStrings = [
    '12AM - 1AM',
    '1AM - 2AM',
    '2AM - 3AM',
    '3AM - 4AM',
    '4AM - 5AM',
    '5AM - 6AM',
    '6AM - 7AM',
    '7AM - 8AM',
    '8AM - 9AM',
    '9AM - 10AM',
    '10AM - 11AM',
    '11AM - 12PM',
    '12PM - 1PM',
    '1PM - 2PM',
    '2PM - 3PM',
    '3PM - 4PM',
    '4PM - 5PM',
    '5PM - 6PM',
    '6PM - 7PM',
    '7PM - 8PM',
    '8PM - 9PM',
    '9PM - 10PM',
    '10PM - 11PM',
    '11PM - 12AM'
  ];
  return timeStrings[timeIndex - 1];
}

bool isTimeSelected(
  int startTimeBtn,
  int endTimeBtn,
  int btnIndex,
) {
  if (startTimeBtn != -1 && endTimeBtn != -1) {
    return (btnIndex >= startTimeBtn && btnIndex <= endTimeBtn);
  }
  if (startTimeBtn != -1) {
    return btnIndex == startTimeBtn;
  }
  return false;
}

String getBookingTime(
  String startTime,
  String endTime,
) {
  return startTime.split('-').first.trim() +
      ' - ' +
      endTime.split('-').last.trim();
}

VenueOfferStruct? getBestApplicableOffer(
  List<VenueOfferStruct>? venueOffers,
  int startTimeIndex,
  int endTimeIndex,
  double bookingCost,
) {
  VenueOfferStruct? result = null;
  var discountValue = 0.0;
  if (venueOffers != null && startTimeIndex != -1 && endTimeIndex != -1) {
    for (VenueOfferStruct offer in venueOffers) {
      if (offer.applicationRule == ApplicationRule.MIN_HOURS) {
        if (offer.minBookingTime <= (endTimeIndex - startTimeIndex + 1)) {
          var applicableDiscount = getDiscountAmount(bookingCost, offer);
          if (applicableDiscount > discountValue) {
            result = offer;
            discountValue = applicableDiscount;
          }
        }
      } else if (offer.applicationRule == ApplicationRule.TIME_BETWEEN) {
        if (startTimeIndex >= offer.startTimeIndex &&
            endTimeIndex <= offer.endTimeIndex) {
          var applicableDiscount = getDiscountAmount(bookingCost, offer);
          if (applicableDiscount > discountValue) {
            result = offer;
            discountValue = applicableDiscount;
          }
        }
      }
    }
  }
  return result;
}

double getDiscountAmount(
  double bookingAmount,
  VenueOfferStruct? offer,
) {
  var applicableDiscount = 0.0;
  if (offer != null) {
    if (offer.discountType == Discount.PERCENTAGE) {
      applicableDiscount = bookingAmount * offer.discountRate;
    } else {
      applicableDiscount = offer.discountRate;
    }
  }
  return applicableDiscount;
}

DateTime parseDate(String dateStr) {
  return DateTime.parse(dateStr).toLocal();
}

DateTime currentDateWithoutTime() {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

String getLocationString(LatLng locationCoOrdinates) {
  /*return '18.575441148943256,73.87486020792399';*/
  return locationCoOrdinates.latitude.toString() +
      ',' +
      locationCoOrdinates.longitude.toString();
}

bool userPresentInEventApi(
  EventWoStruct eventRec,
  DocumentReference loggedInUser,
) {
  return eventRec.participantsRefs != null &&
      eventRec.participantsRefs.contains(loggedInUser.id);
}

DateTime currentPlusDays(int days) {
  final now = DateTime.now();
  return now.add(Duration(days: days));
}

int timeDifferenceInMillis(
  DateTime startTime,
  DateTime endTime,
) {
  return endTime.difference(startTime).inMilliseconds;
}
