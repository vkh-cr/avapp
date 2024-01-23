import 'package:avapp/appConfig.dart';
import 'package:avapp/data/DataService.dart';
import 'package:avapp/models/EventModel.dart';
import 'package:avapp/models/PlaceModel.dart';
import 'package:avapp/pages/EventPage.dart';
import 'package:avapp/widgets/ButtonsHelper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({
    super.key,
    required this.items,
    required this.timetablePlaces,
  });

  final List<TimetableItem> items;
  final List<TimetablePlace> timetablePlaces;

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final double pixelsInHour = 200;
  final double placeTitleHeight = 40;
  final double timelineHeight = 30;
  final double itemHeight = 56;

  Offset offset = const Offset(0, 0);

  late TransformationController transformationController;
  late BoxConstraints constraints;

  Matrix4 matrixTimetable = Matrix4.translationValues(0, 0, 0);
  Matrix4 matrixPlaceTitles = Matrix4.translationValues(0, 0, 0);
  Matrix4 matrixTimeline = Matrix4.translationValues(0, 0, 0);

  int? hourCount;
  int? firstHour;
  int? lastHour;

  double getTimeTableHeight() => widget.timetablePlaces.length*(placeTitleHeight+itemHeight)+timelineHeight;
  double getTimeTableWidth() => (hourCount??24)*pixelsInHour;
  double getWidgetHeight() => getTimeTableHeight()>constraints.maxHeight?getTimeTableHeight():constraints.maxHeight;

  @override
  Widget build(BuildContext context) {

    if(widget.timetablePlaces.isEmpty||widget.timetablePlaces.isEmpty) {
      return SizedBox.shrink();
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints cConstraints) {
          constraints = cConstraints;

          List<Widget> allItems = buildTimeline();

          var timetableItems = Transform(
            transformHitTests: true,
            transform: matrixTimetable,
            child: Stack(
              children: allItems,
            ),
          );
          List<Widget> stackChildren = [timetableItems];

          var placeTitles = Transform(
            transform: matrixPlaceTitles,
            child: Stack(
                  children: List<Widget>.generate(widget.timetablePlaces.length, (i) => Padding(
                    padding: EdgeInsets.fromLTRB(0, i*(itemHeight+placeTitleHeight)+timelineHeight, 0, 0),
                    child: Container(
                      height: placeTitleHeight,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.timetablePlaces[i].title, style: const TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )),
                ),
          );
          stackChildren.add(placeTitles);

          var timeline = Transform(
            transform: matrixTimeline,
            child: Stack(
              children: List<Widget>.generate(hourCount!+1, (i) {
                var hour = firstHour!+i;
                if(hour>23)
                {
                  hour-=24;
                }
                return Padding(
                  padding: EdgeInsets.fromLTRB(i==0?0:i*pixelsInHour-pixelsInHour/2, 0, 0, 0),
                  child: Container(
                    color: AppConfig.color1,
                    height: timelineHeight,
                    width: (i==hourCount!||i==0)?pixelsInHour/2:pixelsInHour,
                    alignment: i==0?Alignment.centerLeft:i==hourCount!?Alignment.centerRight:Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("$hour:00", style: const TextStyle(color: Colors.white),),
                    ),
                  ),
                );
              }),
            ),
          );
          stackChildren.add(timeline);

          return Stack(
            children: [
              GestureDetector(
              behavior: HitTestBehavior.translucent,
                onPanUpdate: constrainBoundaries,
                child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical, child: Stack(children: stackChildren,))))],
          );
        }
    );
  }

  //support max 1 day skipping
  double timeRangeLength(double pixelsPerHour, DateTime startTime, DateTime endTime)
  {
    var range = DateTimeRange(start: startTime, end: endTime);
    return range.duration.inMinutes/60.0*pixelsPerHour;
  }

  List<Widget> buildTimeline() {
    List<Widget> allItems = [];
    var firstEvent = widget.items.reduce(
            (current, next) => current.startTime.compareTo(next.startTime) < 0 ? current : next);

    var lastEvent = widget.items.reduce(
            (current, next) => current.endTime.compareTo(next.endTime) > 0 ? current : next);

    var range = DateTimeRange(start: firstEvent.startTime, end: lastEvent.endTime);
    if(range.duration.inHours>48)
    {
      throw Exception("Events range cannot exceed 48 hours.");
    }
    firstHour = firstEvent.startTime.hour;
    lastHour = lastEvent.endTime.minute > 0 ? lastEvent.endTime.hour + 1 : lastEvent.endTime.hour;

    bool isSkipping = firstEvent.startTime.day != lastEvent.endTime.day;
    hourCount = isSkipping ? 24 - firstHour! + 24 - lastHour! : lastHour! - firstHour!;

    allItems.add(
      Row(
        children:
          List<Widget>.generate(
            hourCount!, (i) => Container(
            width: pixelsInHour,
            height: getWidgetHeight(),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: 0.25, color: Colors.grey),
                right: BorderSide(width: 0.25, color: Colors.grey),
              ),
              color: i%2==0 ? Colors.white70:Colors.white70,
            ),
          ),
        ),
    ));

    for(var p = 0; p < widget.timetablePlaces.length; p++)
    {
      var pItems = widget.items.where((element) => element.placeId==widget.timetablePlaces[p].id).toList();
      for(var i = 0; i < pItems.length; i++)
      {
        var item = pItems[i];
        var timeBlock = Positioned(
          left: timeRangeLength(pixelsInHour, firstEvent.startTime, item.startTime),
          top: (placeTitleHeight+itemHeight)*p+placeTitleHeight+timelineHeight,
          child: GestureDetector(
            onTap: ()=>context.push("${EventPage.ROUTE}/${item.id}"),
            child: Container(
              width: timeRangeLength(pixelsInHour, item.startTime, item.endTime),
              height: itemHeight,
              decoration: BoxDecoration(
                color: item.itemType==TimeTableItemType.signed?AppConfig.color2:Colors.black26,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: ButtonsHelper.getAddToMyProgramButton(
                        TimetableItem.getTimeTableItemTypeAsCanSignIn(item.itemType),
                            ()
                    async {await addToMyProgram(item);}, () async {await removeFromMyProgram(item);},
                        Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 40, 8),
                    child: Text(item.text, style: TextStyle(color: item.itemType==TimeTableItemType.signed?Colors.white:Colors.black), overflow: TextOverflow.fade),
                  ),
                ],
              ),
            ),
          ),
        );
        allItems.add(timeBlock);
      }
    }

    return allItems;
  }

  Future<void> addToMyProgram(TimetableItem item) async {
    await DataService.addToMyProgram(item.id);
    setState(() {
      item.itemType = TimeTableItemType.signed;
    });
  }

  Future<void> removeFromMyProgram(TimetableItem item) async {
    await DataService.removeFromMyProgram(item.id);
    setState(() {
      item.itemType = TimeTableItemType.notSigned;
    });
  }

  void constrainBoundaries(details) {
          var xOffset = matrixTimetable.row0.a+details.delta.dx;
          var yOffset = matrixTimetable.row1.a+details.delta.dy;
          if(xOffset>0) {
            xOffset = 0;
          }

          if(yOffset>0) {
            yOffset = 0;
          }

          var timetableHeight = getTimeTableHeight();
          var timetableWidth = getTimeTableWidth();
          var windowHeight = constraints.maxHeight;
          var windowWidth = constraints.maxWidth;



          if(timetableHeight<windowHeight) {
            yOffset = 0;
          }

          if(timetableWidth<windowWidth)
          {
            xOffset = 0;
          } else if(xOffset+timetableWidth-windowWidth<0)
          {
            xOffset = windowWidth-timetableWidth;
          }

          if(timetableHeight>windowHeight)
          {
            matrixPlaceTitles.setTranslationRaw(0, yOffset, 0);
            if(yOffset+timetableHeight-windowHeight<0) {
              yOffset = windowHeight-timetableHeight;
            }
          }
          if(timetableWidth>windowWidth)
          {
            matrixTimeline.setTranslationRaw(xOffset, 0, 0);
          }
          setState(() {
            matrixTimetable.setTranslationRaw(xOffset, yOffset, 0);
          });
      }
}

enum TimeTableItemType {
  signed, notSigned, disabled
}

class TimetablePlace {
  String title;
  int id;

  TimetablePlace({
    required this.title,
    required this.id
  });

  factory TimetablePlace.fromJson(Map<String, dynamic> json) {
    return TimetablePlace(
      id: json[PlaceModel.idColumn],
      title: json[PlaceModel.titleColumn],
    );
  }
}

class TimetableItem{
  DateTime startTime;
  DateTime endTime;
  String text;
  TimeTableItemType itemType;
  int placeId;
  int id;

  TimetableItem({
    required this.itemType,
    required this.startTime,
    required this.endTime,
    required this.text,
    required this.placeId,
    required this.id
  });

  static TimeTableItemType getIndicatorFromEvent(EventModel model)
  {
    if (model.isSignedIn) {
      return TimeTableItemType.signed;
    }
    else if(model.isEventInMyProgram==true)
    {
      return TimeTableItemType.signed;
    }
    else if(model.isGroupEvent && DataService.currentUserGroup() != null)
    {
      return TimeTableItemType.signed;
    }
    else if(model.currentParticipants != null && model.maxParticipants != null && (!DataService.isLoggedIn() || model.isFull()))
    {
      return TimeTableItemType.disabled;
    }
    else if (EventModel.canSignIn(model))
    {
      return TimeTableItemType.notSigned;
    }
    return TimeTableItemType.notSigned;
  }

  static bool? getTimeTableItemTypeAsCanSignIn(TimeTableItemType type) {
    if(type==TimeTableItemType.disabled) {
      return null;
    }
    else if(type==TimeTableItemType.notSigned) {
      return true;
    }
    return false;
  }

  factory TimetableItem.fromEventModel(EventModel model) {
    return TimetableItem(
      startTime: model.startTime,
      endTime: model.endTime,
      itemType: getIndicatorFromEvent(model),
      id: model.id!,
      text: model.startTimeString(),
      placeId: model.place!.id!,
    );
  }

}