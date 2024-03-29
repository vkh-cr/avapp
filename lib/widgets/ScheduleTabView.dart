import 'package:festapp/styles/Styles.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:festapp/appConfig.dart';

import 'ScheduleTimeline.dart';

  class ScheduleTabView extends StatefulWidget {
    Function(int)? onEventPressed;

    List<TimeLineItem> events = [];

   ScheduleTabView({super.key, required this.events, this.onEventPressed});

    @override
    _ScheduleTabViewState createState() => _ScheduleTabViewState(events, onEventPressed);
  }

  class _ScheduleTabViewState extends State<ScheduleTabView> {

    Map<int, List<TimeLineItem>> eventsMap = {};
    final List<TimeLineItem> events;
    Function(int)? onEventPressed;

  _ScheduleTabViewState(this.events, this.onEventPressed);


    @override
    Widget build(BuildContext context) {

      List<Widget> programLineChildren = [];

      eventsMap = events.groupListsBy((e)=>e.startTime.weekday);
      for(var e in eventsMap.values)
      {
        var timeline = ScheduleTimeline(events: e, onEventPressed: onEventPressed, key: UniqueKey(),);
        programLineChildren.add(SingleChildScrollView(child: timeline));
      }
      return Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: DefaultTabController(
          initialIndex: getInitialIndex(),
          length: eventsMap.length,
          child: Scaffold(
            appBar: TabBar(
              isScrollable: eventsMap.length > 4 ? true : false,
              unselectedLabelColor: Colors.grey,
              labelColor: AppConfig.color1,
              indicatorColor: AppConfig.color1,
              indicatorWeight: 3.0,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: const EdgeInsets.symmetric(vertical: 12.0),
              tabs: [
                  for(var e in eventsMap.keys)
                    Tab(child: Text(indexToDay(e), style: timeLineTabNameTextStyle,))
              ],
            ),
            body: TabBarView(
              children: programLineChildren,
            ),
          ),
        ),
      );
    }

  getInitialIndex() {
      var index = eventsMap.keys.toList().indexOf(DateTime.now().weekday);
      if(index == -1)
      {
        return 0;
      }
      return index;
  }

  String indexToDay(int index)
  {
    var now = DateTime.now();
    var d = now.subtract(Duration(days: now.weekday - index));
    return DateFormat("EEEE", context.locale.languageCode).format(d);
  }

  }