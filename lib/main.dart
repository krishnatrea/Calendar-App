import 'package:flutter/material.dart';
import 'package:flutter_calander/calander_events.dart';
import 'package:flutter_calander/create_event.dart';
import 'package:flutter_calander/edit_calander.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(const MyApp());
}

List<Events> newEvents = [
  Events(
    color: Colors.red,
    description: "description",
    endTime: DateTime(2022, 3, 9, 10, 0, 0),
    subject: "subject",
    location: "location",
    startTime: DateTime(2022, 3, 9, 1, 0, 0),
  ),
  Events(
    color: Colors.blue,
    description: "description 2",
    endTime: DateTime(2022, 3, 9, 12, 0, 0),
    subject: "subject 4",
    location: "location 5",
    startTime: DateTime(2022, 3, 9, 5, 0, 0),
  ),
  Events(
    color: Colors.yellow,
    description: "description 2",
    endTime: DateTime(2022, 3, 10, 11, 0, 0),
    subject: "subject 4",
    location: "location 5",
    startTime: DateTime(2022, 3, 10, 8, 0, 0),
  ),
  Events(
    color: Colors.green,
    description: "description 2",
    endTime: DateTime(2022, 3, 6, 12, 0, 0),
    subject: "subject 4",
    location: "location 5",
    startTime: DateTime(2022, 3, 6, 5, 0, 0),
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Calender Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  IconData calanderIcon = Icons.calendar_view_month;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final CalendarController _controller = CalendarController();
  void addevent() {
    _controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          DropdownButton(
            items: const [
              DropdownMenuItem(
                child: Text("Month"),
                value: CalendarView.month,
              ),
              DropdownMenuItem(
                child: Text("Week"),
                value: CalendarView.week,
              ),
              DropdownMenuItem(
                child: Text("Work Week"),
                value: CalendarView.workWeek,
              ),
              DropdownMenuItem(
                child: Text("Day"),
                value: CalendarView.day,
              ),
            ],
            onChanged: (CalendarView? value) {
              setState(() {
                _controller.view = value ?? CalendarView.month;
                switch (value) {
                  case CalendarView.month:
                    calanderIcon = Icons.calendar_today;
                    break;
                  case CalendarView.week:
                    calanderIcon = Icons.calendar_view_week;
                    break;
                  case CalendarView.day:
                    calanderIcon = Icons.calendar_view_day;
                    break;

                  case CalendarView.workWeek:
                    calanderIcon = Icons.calendar_view_week_rounded;
                    break;
                  default:
                    calanderIcon = Icons.calendar_view_month;
                }
              });
            },
            icon: Icon(calanderIcon, color: Colors.white),
          ),
        ],
      ),
      body: Center(child: CalendarWidget(controller: _controller)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateEvent()));
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    Key? key,
    required CalendarController controller,
  })  : _controller = controller,
        super(key: key);

  final CalendarController _controller;

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      controller: widget._controller,
      view: CalendarView.week,
      dataSource: EventDataSource(newEvents),
      showDatePickerButton: true,
       allowDragAndDrop: true,
      dragAndDropSettings: DragAndDropSettings(
        allowScroll: true,
        allowNavigation: true,
        autoNavigateDelay: Duration(seconds: 1),
      ),
      onDragEnd: (appointmentDragEndDetails) {
        print(appointmentDragEndDetails.droppingTime);
        
      },
      onDragStart: (appointmentDragStartDetails) {
        
      },
      onDragUpdate: (appointmentDragUpdateDetails) {
        
      },
      onTap: (calendarTapDetails) {
        showBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                    "Appointment ${DateFormat("yyyy-MM-dd").format(calendarTapDetails.date!)}"),
              ),
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Material(
                  elevation: 5,
                  child: calendarTapDetails.appointments != null &&
                          calendarTapDetails.appointments!.isNotEmpty
                      ? ListView.builder(
                          itemCount: calendarTapDetails.appointments!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                // subtitle: Text(calendarTapDetails.appointments!.elementAt(index).discription),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => EditEvent(
                                                        event:
                                                            calendarTapDetails
                                                                .appointments!
                                                                .elementAt(
                                                                    index))));
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            newEvents.removeWhere((element) =>
                                                element ==
                                                calendarTapDetails.appointments!
                                                    .elementAt(index));
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.delete))
                                    ],
                                  ),
                                ),
                                onTap: () async {},
                                title: Text(calendarTapDetails.appointments!
                                    .elementAt(index)
                                    .subject));
                          },
                        )
                      : Center(child: Text("No Events")),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
