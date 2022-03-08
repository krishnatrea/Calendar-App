
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Events> events) {
   appointments = events;
  }


  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject;
  }
  @override
  Color getColor(int index) {
    return appointments![index].color;
  }

}
class Events  {
  String subject;
  String location;
  String description;
  DateTime startTime;
  DateTime endTime;
  Color color;
  Events({required this.subject, required this.location, required this.description, required this.startTime,
      required this.endTime, required this.color});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Events &&
      other.subject == subject &&
      other.location == location &&
      other.description == description &&
      other.startTime == startTime &&
      other.endTime == endTime &&
      other.color == color;
  }

  @override
  int get hashCode {
    return subject.hashCode ^
      location.hashCode ^
      description.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      color.hashCode;
  }
}
