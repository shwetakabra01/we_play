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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'venue_booking_model.dart';
export 'venue_booking_model.dart';

class VenueBookingWidget extends StatefulWidget {
  const VenueBookingWidget({
    super.key,
    required this.venue,
  });

  final VenueRecord? venue;

  @override
  State<VenueBookingWidget> createState() => _VenueBookingWidgetState();
}

class _VenueBookingWidgetState extends State<VenueBookingWidget> {
  late VenueBookingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VenueBookingModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.turfCost = 0.0;
        _model.timeButtons = [
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18,
          19,
          20,
          21,
          22,
          23,
          24
        ].toList().cast<int>();
        _model.startTimeBtn = -1;
        _model.endTimeBtn = -1;
      });
    });

    _model.participantsController ??= TextEditingController();
    _model.participantsFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 52.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 22.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Align(
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: Text(
              valueOrDefault<String>(
                widget.venue?.name,
                'Host',
              ),
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Roboto',
                    color: Colors.black,
                    fontSize: 18.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBtnText,
            ),
            child: Form(
              key: _model.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 15.0, 10.0, 7.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Turf Size',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 5.0),
                            child: FlutterFlowChoiceChips(
                              options: widget.venue!.turfs
                                  .map((e) => e.size)
                                  .toList()
                                  .map((label) => ChipData(label))
                                  .toList(),
                              onChanged: (val) async {
                                setState(
                                    () => _model.turfsValue = val?.firstOrNull);
                                _model.numberOfTurfs = functions
                                    .getTurfRec(widget.venue!.turfs.toList(),
                                        _model.turfsValue!)
                                    ?.numberOfTurfs;
                                _model.turfCost = functions
                                    .getTurfRec(widget.venue!.turfs.toList(),
                                        _model.turfsValue!)
                                    ?.cost;
                                _model.turfPlayers = functions
                                    .getTurfRec(widget.venue!.turfs.toList(),
                                        _model.turfsValue!)
                                    ?.players;
                                _model.bookingCost = (double turfCost,
                                        String? numberOfTurfs, int hours) {
                                  return numberOfTurfs != null
                                      ? (int.parse(numberOfTurfs) *
                                          turfCost *
                                          hours)
                                      : turfCost * hours;
                                }(
                                    _model.turfCost!,
                                    _model.numberOfTurfsValue,
                                    ((int startIndex, int endIndex) {
                                      return startIndex != -1 && endIndex != -1
                                          ? (endIndex - startIndex + 1)
                                          : 1;
                                    }(_model.startTimeBtn!,
                                        _model.endTimeBtn!)));
                                setState(() {
                                  _model.applicableOffer =
                                      functions.getBestApplicableOffer(
                                          widget.venue?.availableOffers
                                              ?.toList(),
                                          _model.startTimeBtn!,
                                          _model.endTimeBtn!,
                                          _model.bookingCost);
                                });
                                setState(() {
                                  _model.participantsController?.text =
                                      _model.turfPlayers!.toString();
                                });
                              },
                              selectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Playfair Display',
                                      color:
                                          FlutterFlowTheme.of(context).accent4,
                                      letterSpacing: 0.0,
                                    ),
                                iconColor: FlutterFlowTheme.of(context).accent4,
                                iconSize: 18.0,
                                elevation: 4.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).secondary,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Playfair Display',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                    ),
                                iconColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                iconSize: 18.0,
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              chipSpacing: 12.0,
                              rowSpacing: 12.0,
                              multiselect: false,
                              alignment: WrapAlignment.start,
                              controller: _model.turfsValueController ??=
                                  FormFieldController<List<String>>(
                                [],
                              ),
                              wrapped: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if ((_model.validations != null) &&
                        !_model.validations!.turfSize &&
                        (_model.turfsValue == null || _model.turfsValue == ''))
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Please select turfSize',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto Condensed',
                                    color: FlutterFlowTheme.of(context).warning,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 5.0),
                            child: Text(
                              'Available sports',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 5.0),
                            child: FlutterFlowChoiceChips(
                              options: widget.venue!.availableSports
                                  .map((label) => ChipData(label))
                                  .toList(),
                              onChanged: (val) => setState(() =>
                                  _model.availsportsValue = val?.firstOrNull),
                              selectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Playfair Display',
                                      color:
                                          FlutterFlowTheme.of(context).accent4,
                                      letterSpacing: 0.0,
                                    ),
                                iconColor: FlutterFlowTheme.of(context).accent4,
                                iconSize: 18.0,
                                elevation: 4.0,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Playfair Display',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                    ),
                                iconColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                iconSize: 18.0,
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              chipSpacing: 12.0,
                              rowSpacing: 12.0,
                              multiselect: false,
                              alignment: WrapAlignment.start,
                              controller: _model.availsportsValueController ??=
                                  FormFieldController<List<String>>(
                                [],
                              ),
                              wrapped: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if ((_model.validations != null) &&
                        !_model.validations!.sport &&
                        (_model.availsportsValue == null ||
                            _model.availsportsValue == ''))
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Please select sport',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto Condensed',
                                    color: FlutterFlowTheme.of(context).warning,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 10.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 5.0),
                              child: Text(
                                'Number of Turfs',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Roboto',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 17.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 5.0),
                            child: FlutterFlowChoiceChips(
                              options: (int count) {
                                return new List<int>.generate(
                                    count, (i) => i + 1);
                              }(_model.numberOfTurfs!)
                                  .map((e) => e.toString())
                                  .toList()
                                  .map((label) => ChipData(label))
                                  .toList(),
                              onChanged: (_model.turfsValue == null ||
                                      _model.turfsValue == '')
                                  ? null
                                  : (val) async {
                                      setState(() => _model.numberOfTurfsValue =
                                          val?.firstOrNull);
                                      _model.bookingCost = (double turfCost,
                                              String? numberOfTurfs,
                                              int hours) {
                                        return numberOfTurfs != null
                                            ? (int.parse(numberOfTurfs) *
                                                turfCost *
                                                hours)
                                            : turfCost * hours;
                                      }(
                                          _model.turfCost!,
                                          _model.numberOfTurfsValue,
                                          ((int startIndex, int endIndex) {
                                            return startIndex != -1 &&
                                                    endIndex != -1
                                                ? (endIndex - startIndex + 1)
                                                : 1;
                                          }(_model.startTimeBtn!,
                                              _model.endTimeBtn!)));
                                      setState(() {
                                        _model.applicableOffer =
                                            functions.getBestApplicableOffer(
                                                widget.venue?.availableOffers
                                                    ?.toList(),
                                                _model.startTimeBtn!,
                                                _model.endTimeBtn!,
                                                _model.bookingCost);
                                      });
                                    },
                              selectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Playfair Display',
                                      color:
                                          FlutterFlowTheme.of(context).accent4,
                                      letterSpacing: 0.0,
                                    ),
                                iconColor: FlutterFlowTheme.of(context).accent4,
                                iconSize: 18.0,
                                elevation: 4.0,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Playfair Display',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                    ),
                                iconColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                iconSize: 18.0,
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              chipSpacing: 12.0,
                              rowSpacing: 12.0,
                              multiselect: false,
                              alignment: WrapAlignment.start,
                              controller:
                                  _model.numberOfTurfsValueController ??=
                                      FormFieldController<List<String>>(
                                [],
                              ),
                              wrapped: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if ((_model.validations != null) &&
                        !_model.validations!.numberOfTurfs &&
                        (_model.numberOfTurfsValue == null ||
                            _model.numberOfTurfsValue == ''))
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Please select turfs',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto Condensed',
                                    color: FlutterFlowTheme.of(context).warning,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 15.0, 0.0, 5.0),
                                      child: FlutterFlowChoiceChips(
                                        options: functions
                                            .getNextSevenDays(
                                                getCurrentTimestamp)!
                                            .map((e) =>
                                                dateTimeFormat('MMMEd', e))
                                            .toList()
                                            .map((label) => ChipData(label))
                                            .toList(),
                                        onChanged: (_model.datePicked != null)
                                            ? null
                                            : (val) => setState(() =>
                                                _model.eventDateValue =
                                                    val?.firstOrNull),
                                        selectedChipStyle: ChipStyle(
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Playfair Display',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
                                                letterSpacing: 0.0,
                                              ),
                                          iconColor:
                                              FlutterFlowTheme.of(context)
                                                  .accent4,
                                          iconSize: 18.0,
                                          labelPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 20.0, 10.0, 20.0),
                                          elevation: 4.0,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        unselectedChipStyle: ChipStyle(
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Playfair Display',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                              ),
                                          iconColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          iconSize: 18.0,
                                          labelPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 20.0, 10.0, 20.0),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        chipSpacing: 12.0,
                                        rowSpacing: 12.0,
                                        multiselect: false,
                                        alignment: WrapAlignment.start,
                                        controller: _model
                                                .eventDateValueController ??=
                                            FormFieldController<List<String>>(
                                          [],
                                        ),
                                        wrapped: false,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 7.0, 10.0, 0.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          final _datePickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: getCurrentTimestamp,
                                            firstDate: getCurrentTimestamp,
                                            lastDate: DateTime(2050),
                                            builder: (context, child) {
                                              return wrapInMaterialDatePickerTheme(
                                                context,
                                                child!,
                                                headerBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                headerForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                headerTextStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 32.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                pickerBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                pickerForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                selectedDateTimeBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                selectedDateTimeForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                actionButtonForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                iconSize: 24.0,
                                              );
                                            },
                                          );

                                          if (_datePickedDate != null) {
                                            safeSetState(() {
                                              _model.datePicked = DateTime(
                                                _datePickedDate.year,
                                                _datePickedDate.month,
                                                _datePickedDate.day,
                                              );
                                            });
                                          }
                                          setState(() {});
                                          setState(() {
                                            _model.eventDateValueController
                                                ?.reset();
                                          });
                                        },
                                        text: _model.datePicked == null
                                            ? 'Select Date'
                                            : dateTimeFormat(
                                                'MMMEd', _model.datePicked),
                                        options: FFButtonOptions(
                                          width: 95.0,
                                          height: 65.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 20.0, 10.0, 20.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: _model.datePicked != null
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryText
                                              : FlutterFlowTheme.of(context)
                                                  .alternate,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Roboto',
                                                    color: _model.datePicked !=
                                                            null
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .alternate
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    letterSpacing: 0.0,
                                                  ),
                                          elevation: 3.0,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if ((_model.validations != null) &&
                        !_model.validations!.date &&
                        ((_model.eventDateValue == null ||
                                _model.eventDateValue == '') &&
                            (_model.datePicked == null)))
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Please select date',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto Condensed',
                                    color: FlutterFlowTheme.of(context).warning,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          10.0, 15.0, 10.0, 15.0),
                      child: Builder(
                        builder: (context) {
                          final offers =
                              widget.venue?.availableOffers?.toList() ?? [];
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            children:
                                List.generate(offers.length, (offersIndex) {
                              final offersItem = offers[offersIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 5.0, 0.0),
                                child: Container(
                                  width: 150.0,
                                  decoration: BoxDecoration(
                                    color: (_model.applicableOffer != null) &&
                                            (_model.applicableOffer
                                                    ?.descriptionLine1 ==
                                                offersItem.descriptionLine1)
                                        ? FlutterFlowTheme.of(context)
                                            .primaryText
                                        : FlutterFlowTheme.of(context)
                                            .secondary,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: (_model.applicableOffer != null) &&
                                              (_model.applicableOffer
                                                      ?.descriptionLine1 ==
                                                  offersItem.descriptionLine1)
                                          ? FlutterFlowTheme.of(context)
                                              .primaryText
                                          : FlutterFlowTheme.of(context)
                                              .tertiary,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Icon(
                                          Icons.local_offer,
                                          color: (_model.applicableOffer !=
                                                      null) &&
                                                  (_model.applicableOffer
                                                          ?.descriptionLine1 ==
                                                      offersItem
                                                          .descriptionLine1)
                                              ? FlutterFlowTheme.of(context)
                                                  .alternate
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          size: 24.0,
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            offersItem.descriptionLine1,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: (_model.applicableOffer !=
                                                              null) &&
                                                          (_model
                                                                  .applicableOffer
                                                                  ?.descriptionLine1 ==
                                                              offersItem
                                                                  .descriptionLine1)
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .alternate
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Text(
                                            offersItem.descriptionLine2,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: (_model.applicableOffer !=
                                                              null) &&
                                                          (_model
                                                                  .applicableOffer
                                                                  ?.descriptionLine1 ==
                                                              offersItem
                                                                  .descriptionLine1)
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .alternate
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        final repeat =
                            _model.timeButtons.toList().take(4).toList();
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children:
                                List.generate(repeat.length, (repeatIndex) {
                              final repeatItem = repeat[repeatIndex];
                              return Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      final timeButtonsVar = _model.timeButtons
                                          .toList()
                                          .take(6)
                                          .toList();
                                      return Wrap(
                                        spacing: 0.0,
                                        runSpacing: 0.0,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children:
                                            List.generate(timeButtonsVar.length,
                                                (timeButtonsVarIndex) {
                                          final timeButtonsVarItem =
                                              timeButtonsVar[
                                                  timeButtonsVarIndex];
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 5.0, 10.0, 5.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                if (_model.startTimeBtn != -1) {
                                                  if (_model.startTimeBtn! <
                                                      ((6 * (repeatItem - 1)) +
                                                          timeButtonsVarItem)) {
                                                    _model.endTimeBtn =
                                                        (6 * (repeatItem - 1)) +
                                                            timeButtonsVarItem;
                                                  } else {
                                                    if ((_model.startTimeBtn ==
                                                            _model
                                                                .endTimeBtn) &&
                                                        (((6 *
                                                                    (repeatItem -
                                                                        1)) +
                                                                timeButtonsVarItem) ==
                                                            _model
                                                                .endTimeBtn)) {
                                                      _model.endTimeBtn = -1;
                                                      _model.startTimeBtn = -1;
                                                    } else {
                                                      _model.endTimeBtn =
                                                          _model.startTimeBtn;
                                                      _model.startTimeBtn = (6 *
                                                              (repeatItem -
                                                                  1)) +
                                                          timeButtonsVarItem;
                                                    }
                                                  }
                                                } else {
                                                  _model.startTimeBtn =
                                                      (6 * (repeatItem - 1)) +
                                                          timeButtonsVarItem;
                                                  _model.endTimeBtn =
                                                      _model.startTimeBtn;
                                                }

                                                _model.bookingCost = (double
                                                            turfCost,
                                                        String? numberOfTurfs,
                                                        int hours) {
                                                  return numberOfTurfs != null
                                                      ? (int.parse(
                                                              numberOfTurfs) *
                                                          turfCost *
                                                          hours)
                                                      : turfCost * hours;
                                                }(
                                                    _model.turfCost!,
                                                    _model.numberOfTurfsValue,
                                                    ((int startIndex,
                                                            int endIndex) {
                                                      return startIndex != -1 &&
                                                              endIndex != -1
                                                          ? (endIndex -
                                                              startIndex +
                                                              1)
                                                          : 1;
                                                    }(_model.startTimeBtn!,
                                                        _model.endTimeBtn!)));
                                                setState(() {
                                                  _model.applicableOffer = functions
                                                      .getBestApplicableOffer(
                                                          widget.venue
                                                              ?.availableOffers
                                                              ?.toList(),
                                                          _model.startTimeBtn!,
                                                          _model.endTimeBtn!,
                                                          _model.bookingCost);
                                                });
                                              },
                                              text: functions.getTimeString(
                                                  (6 * (repeatItem - 1)) +
                                                      timeButtonsVarItem),
                                              options: FFButtonOptions(
                                                width: 95.0,
                                                height: 32.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color: functions.isTimeSelected(
                                                        _model.startTimeBtn!,
                                                        _model.endTimeBtn!,
                                                        (6 * (repeatItem - 1)) +
                                                            timeButtonsVarItem)
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Roboto',
                                                      color: functions.isTimeSelected(
                                                              _model
                                                                  .startTimeBtn!,
                                                              _model
                                                                  .endTimeBtn!,
                                                              (6 *
                                                                      (repeatItem -
                                                                          1)) +
                                                                  timeButtonsVarItem)
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                                elevation: 3.0,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                    if ((_model.validations != null) &&
                        !_model.validations!.time &&
                        (_model.startTimeBtn == -1))
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Please select time',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto Condensed',
                                    color: FlutterFlowTheme.of(context).warning,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 15.0, 10.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Split Costs',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Switch.adaptive(
                              value: _model.spliCostValue ??= true,
                              onChanged: (newValue) async {
                                setState(
                                    () => _model.spliCostValue = newValue!);
                              },
                              activeColor: FlutterFlowTheme.of(context).primary,
                              activeTrackColor:
                                  FlutterFlowTheme.of(context).accent1,
                              inactiveTrackColor:
                                  FlutterFlowTheme.of(context).alternate,
                              inactiveThumbColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                            ),
                            if (widget.venue?.name == 'shweta')
                              FFButtonWidget(
                                onPressed: () async {
                                  await VenueRecord.collection.doc().set({
                                    ...createVenueRecordData(
                                      name: widget.venue?.name,
                                      cost: widget.venue?.cost,
                                      address: widget.venue?.address,
                                      shortAddress: widget.venue?.shortAddress,
                                      contactNumber1:
                                          widget.venue?.contactNumber1,
                                      avgRatings: widget.venue?.avgRatings,
                                      location: widget.venue?.location,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'availableSports':
                                            widget.venue?.availableSports,
                                        'photos': widget.venue?.photos,
                                        'aboutLines':
                                            getIconDescriptionListFirestoreData(
                                          widget.venue?.aboutLines,
                                        ),
                                        'amenities':
                                            getIconDescriptionListFirestoreData(
                                          widget.venue?.amenities,
                                        ),
                                        'turfs': getTurfListFirestoreData(
                                          widget.venue?.turfs,
                                        ),
                                        'availableOffers':
                                            getVenueOfferListFirestoreData(
                                          widget.venue?.availableOffers,
                                        ),
                                      },
                                    ),
                                  });
                                },
                                text: 'Clone Venue',
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              'Your booking will automatically be confirmed either when all spots get full or in 48 hours of the game. No refund will be provided if booking is canceled within 48 hours of the game.',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto Condensed',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 13.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              setState(() {
                                _model.participantsController?.text =
                                    ((String value) {
                                  return int.parse(value) == 1
                                      ? '1'
                                      : (int.parse(value) - 1).toString();
                                }(_model.participantsController.text));
                              });
                            },
                            child: FaIcon(
                              FontAwesomeIcons.minus,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 18.0,
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              child: Container(
                                width: 70.0,
                                child: TextFormField(
                                  controller: _model.participantsController,
                                  focusNode: _model.participantsFocusNode,
                                  autofocus: false,
                                  readOnly: _model.turfPlayers == null,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Roboto',
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Playfair Display',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                  textAlign: TextAlign.center,
                                  minLines: null,
                                  validator: _model
                                      .participantsControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              setState(() {
                                _model.participantsController?.text =
                                    ((int.parse(_model
                                                .participantsController.text) +
                                            1)
                                        .toString());
                              });
                            },
                            child: FaIcon(
                              FontAwesomeIcons.plus,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 18.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Players',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto Condensed',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if ((_model.validations != null) &&
                        !_model.validations!.participantCount &&
                        ((_model.participantsController.text == null ||
                                _model.participantsController.text == '') ||
                            (_model.participantsController.text == '0')))
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Please select participants',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto Condensed',
                                    color: FlutterFlowTheme.of(context).warning,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 5.0, 0.0),
                                      child: Icon(
                                        Icons.currency_rupee,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 18.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          3.0, 0.0, 3.0, 0.0),
                                      child: Text(
                                        _model.spliCostValue!
                                            ? (_model.applicableOffer != null
                                                ? formatNumber(
                                                    (_model.bookingCost -
                                                            functions.getDiscountAmount(
                                                                _model
                                                                    .bookingCost,
                                                                _model
                                                                    .applicableOffer)) *
                                                        0.3,
                                                    formatType:
                                                        FormatType.custom,
                                                    format: '####.0#',
                                                    locale: '',
                                                  )
                                                : formatNumber(
                                                    _model.bookingCost * 0.3,
                                                    formatType:
                                                        FormatType.custom,
                                                    format: '####.0#',
                                                    locale: '',
                                                  ))
                                            : (_model.applicableOffer != null
                                                ? formatNumber(
                                                    _model.bookingCost -
                                                        functions.getDiscountAmount(
                                                            _model.bookingCost,
                                                            _model
                                                                .applicableOffer),
                                                    formatType:
                                                        FormatType.custom,
                                                    format: '####.0#',
                                                    locale: '',
                                                  )
                                                : formatNumber(
                                                    _model.bookingCost,
                                                    formatType:
                                                        FormatType.custom,
                                                    format: '####.0#',
                                                    locale: '',
                                                  )),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Roboto',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                    Text(
                                      '(${formatNumber(
                                        _model.bookingCost,
                                        formatType: FormatType.decimal,
                                        decimalType: DecimalType.periodDecimal,
                                      )})',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Roboto',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                                if (_model.applicableOffer == null)
                                  Text(
                                    _model.startTimeBtn != -1
                                        ? functions.getBookingTime(
                                            functions.getTimeString(
                                                _model.startTimeBtn!),
                                            functions.getTimeString(
                                                _model.endTimeBtn != -1
                                                    ? _model.endTimeBtn!
                                                    : _model.startTimeBtn!))
                                        : ' ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Roboto',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                if (_model.applicableOffer != null)
                                  Text(
                                    _model.applicableOffer != null
                                        ? 'Discount: ${formatNumber(
                                            functions.getDiscountAmount(
                                                _model.bookingCost,
                                                _model.applicableOffer),
                                            formatType: FormatType.decimal,
                                            decimalType:
                                                DecimalType.periodDecimal,
                                            currency: '₹',
                                          )}'
                                        : ' ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Roboto',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 5.0, 5.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  setState(() {
                                    _model.validations =
                                        BookingValidationsStruct();
                                  });
                                  _model.updateValidationsStruct(
                                    (e) => e
                                      ..turfSize = _model.turfsValue != null &&
                                          _model.turfsValue != ''
                                      ..sport =
                                          _model.availsportsValue != null &&
                                              _model.availsportsValue != ''
                                      ..numberOfTurfs =
                                          _model.numberOfTurfsValue != null &&
                                              _model.numberOfTurfsValue != ''
                                      ..date = (_model.eventDateValue != null &&
                                              _model.eventDateValue != '') ||
                                          (_model.datePicked != null)
                                      ..time = _model.startTimeBtn != -1
                                      ..participantCount = (_model
                                                      .participantsController
                                                      .text !=
                                                  null &&
                                              _model.participantsController
                                                      .text !=
                                                  '') &&
                                          (_model.participantsController.text !=
                                              '0'),
                                  );
                                  _model.updateValidationsStruct(
                                    (e) => e
                                      ..formValid = _model
                                              .validations!.turfSize &&
                                          _model.validations!.sport &&
                                          _model.validations!.numberOfTurfs &&
                                          _model.validations!.date &&
                                          _model.validations!.time &&
                                          _model.validations!.participantCount,
                                  );
                                  if (_model.validations!.formValid) {
                                    _model.organizerShare = _model
                                            .spliCostValue!
                                        ? ((double cost, String? participants,
                                                double discount) {
                                            return participants == null
                                                ? 0.0
                                                : (cost - discount) * 0.3;
                                          }(
                                            _model.bookingCost,
                                            _model.participantsController.text,
                                            functions.getDiscountAmount(
                                                _model.bookingCost,
                                                _model.applicableOffer)))
                                        : (_model.bookingCost -
                                            functions.getDiscountAmount(
                                                _model.bookingCost,
                                                _model.applicableOffer));
                                    if (valueOrDefault(
                                            currentUserDocument?.walletBalance,
                                            0.0) >=
                                        _model.organizerShare) {
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Your share : ${formatNumber(
                                                      _model.organizerShare,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType: DecimalType
                                                          .periodDecimal,
                                                    )}              Current Balance :  ${formatNumber(
                                                      valueOrDefault(
                                                          currentUserDocument
                                                              ?.walletBalance,
                                                          0.0),
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType: DecimalType
                                                          .periodDecimal,
                                                      currency: '₹',
                                                    )}'),
                                                    content: Text(
                                                        'Your booking will automatically be confirmed either when all spots get full or in 48 hours of the game. No refund will be provided if booking is canceled within 48 hours of the game.'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                false),
                                                        child: Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                true),
                                                        child: Text(
                                                            'Pay & Book Venue'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ) ??
                                              false;
                                      if (confirmDialogResponse) {
                                        _model.createApiResponse =
                                            await WePlayApiGroup.createEventCall
                                                .call(
                                          jwtToken: currentJwtToken,
                                          venueId: widget.venue?.reference.id,
                                          playersCapacity: int.tryParse(_model
                                              .participantsController.text),
                                          sport: _model.availsportsValue,
                                          eventDate: functions
                                              .getDateTimeFromString(
                                                  _model.eventDateValue ==
                                                              null ||
                                                          _model.eventDateValue ==
                                                              ''
                                                      ? dateTimeFormat('MMMEd',
                                                          _model.datePicked)
                                                      : _model.eventDateValue!,
                                                  functions.getTimeString(
                                                      _model.startTimeBtn!))
                                              ?.toString(),
                                          numberOfTurfs: int.parse(
                                              (_model.numberOfTurfsValue!)),
                                          splitCost: _model.spliCostValue,
                                          bookingTime: functions.getBookingTime(
                                              functions.getTimeString(
                                                  _model.startTimeBtn!),
                                              functions.getTimeString(
                                                  _model.endTimeBtn!)),
                                          turfId: functions
                                              .getTurfRec(
                                                  widget.venue!.turfs.toList(),
                                                  _model.turfsValue!)
                                              ?.turfId,
                                        );
                                        if (CreateEventResponseStruct
                                                .maybeFromMap((_model
                                                        .createApiResponse
                                                        ?.jsonBody ??
                                                    ''))!
                                            .success) {
                                          _model.eventsCreated =
                                              await queryEventsRecordOnce(
                                            queryBuilder: (eventsRecord) =>
                                                eventsRecord
                                                    .where(
                                                      'createdOn',
                                                      isGreaterThanOrEqualTo:
                                                          functions
                                                              .currentDateWithoutTime(),
                                                    )
                                                    .where(
                                                      'status',
                                                      isEqualTo: 'In Progress',
                                                    )
                                                    .where(
                                                      'organizer',
                                                      isEqualTo:
                                                          currentUserReference,
                                                    )
                                                    .where(
                                                      'name',
                                                      isEqualTo:
                                                          widget.venue?.name,
                                                    )
                                                    .orderBy('createdOn',
                                                        descending: true),
                                          );

                                          context.goNamed(
                                            'GameInfo',
                                            queryParameters: {
                                              'eventRef': serializeParam(
                                                _model.eventsCreated
                                                    ?.where((e) =>
                                                        e.reference.id ==
                                                        CreateEventResponseStruct
                                                                .maybeFromMap((_model
                                                                        .createApiResponse
                                                                        ?.jsonBody ??
                                                                    ''))
                                                            ?.result
                                                            ?.eventId)
                                                    .toList()
                                                    ?.first
                                                    ?.reference,
                                                ParamType.DocumentReference,
                                              ),
                                              'fromPage': serializeParam(
                                                'BOOKING',
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );

                                          _model.usersForNotification =
                                              await queryUsersRecordOnce(
                                            queryBuilder: (usersRecord) =>
                                                usersRecord.where(
                                              'preferredSports',
                                              arrayContains:
                                                  _model.availsportsValue,
                                            ),
                                          );
                                          triggerPushNotification(
                                            notificationTitle: 'Event Created',
                                            notificationText:
                                                'Cricket this Sunday 12 PM to 2 PM',
                                            userRefs: _model
                                                .usersForNotification!
                                                .map((e) => e.reference)
                                                .toList(),
                                            initialPageName: 'GameInfo',
                                            parameterData: {
                                              'eventRef': _model.eventsCreated
                                                  ?.where((e) =>
                                                      e.reference.id ==
                                                      CreateEventResponseStruct
                                                              .maybeFromMap((_model
                                                                      .createApiResponse
                                                                      ?.jsonBody ??
                                                                  ''))
                                                          ?.result
                                                          ?.eventId)
                                                  .toList()
                                                  ?.first
                                                  ?.reference,
                                              'fromPage': 'Notification',
                                            },
                                          );
                                        }
                                      }
                                    } else {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => _model
                                                    .unfocusNode.canRequestFocus
                                                ? FocusScope.of(context)
                                                    .requestFocus(
                                                        _model.unfocusNode)
                                                : FocusScope.of(context)
                                                    .unfocus(),
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: LoadWalletWidget(),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    }
                                  }

                                  setState(() {});
                                },
                                text: 'Book Venue',
                                options: FFButtonOptions(
                                  width: 200.0,
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
