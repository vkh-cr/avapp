import 'package:avapp/pages/EventPage.dart';
import 'package:avapp/services/DataService.dart';
import 'package:avapp/widgets/ProgramTimeline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/EventModel.dart';
import '../styles/Styles.dart';

class ProgramPage extends StatefulWidget {
  static const ROUTE = "/program";
  const ProgramPage({Key? key}) : super(key: key);

  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {

  @override
  void initState() {
    super.initState();
    DataService.updateEvents(_events, true).whenComplete(() async {
      _dots.clear();
      _dots.addAll(_events.map((e) => TimeLineItem.fromEventModel(e)));
      await loadEventParticipants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My program").tr(),
      ),
      body: Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: appMaxWidth),
            child: SingleChildScrollView(child: ProgramTimeline(events: _dots, onEventPressed: _eventPressed, splitByDay: true, nodePosition: 0.3)))
    ));
  }

  final List<EventModel> _events = [];
  final List<TimeLineItem> _dots = [];

  Future<void> loadEventParticipants() async {
    await DataService.loadEventsParticipantsAndStatus(_events);
    for (var e in _events)
    {
      var dot = _dots.singleWhere((element) => element.id == e.id!);
      setState(() {
        dot.rightText = e.toString();
        dot.leftText = e.durationTimeString();
        dot.dotType = TimeLineItem.getIndicatorFromEvent(e);
      });
    }
  }

  _eventPressed(int id) {
    context.push("${EventPage.ROUTE}/$id");
  }
}