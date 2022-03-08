

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calander/calander_events.dart';
import 'package:flutter_calander/create_event.dart';
import 'package:flutter_calander/main.dart';
import 'package:intl/intl.dart';
import 'package:random_color/random_color.dart';

class EditEvent extends StatefulWidget {
  Events event;

  EditEvent({Key? key, required this.event}) : super(key: key);
  @override
  State<EditEvent> createState() => _EditEventState(this.event);
}

class _EditEventState extends State<EditEvent> {
   TextEditingController _eventSubjectController = TextEditingController();

   TextEditingController _eventDescriptionController = TextEditingController();

   TextEditingController _eventtoController = TextEditingController();
   TextEditingController _eventfromController = TextEditingController();

  _EditEventState(
    Events events,
  ) {
    _eventSubjectController.text = events.subject;
    _eventDescriptionController.text = events.description;
    _eventfromController.text = DateFormat('yyyy-MM-dd HH:mm').format(events.startTime);
    _eventtoController.text = DateFormat('yyyy-MM-dd HH:mm').format( events.endTime);
  }
  late DateTime? from;

  late DateTime? to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTextField(Icons.subject, "Event Subject", _eventSubjectController),
                buildTextField(Icons.class_, "Event Description", _eventDescriptionController), 
                buildDateTimeField(context,"From" , _eventfromController, (){
                  from = DateTime.parse(_eventfromController.text);
                  setState(() {
                    
                  });
                } ),
                buildDateTimeField(context, "To" , _eventtoController, () {
                  to = DateTime.parse(_eventtoController.text);
                } ),
                ElevatedButton(
                  onPressed: () {
                    RandomColor _randomColor = RandomColor();
                    log("${_eventtoController.text} ${_eventfromController.text}");
                    Events event = Events(
                        color: _randomColor.randomColor(), 
                        description: _eventDescriptionController.text,
                        subject: _eventSubjectController.text,
                        location: "location",
                        startTime:  DateTime.parse(_eventfromController.text),
                        endTime: DateTime.parse(_eventtoController.text) );
                     newEvents.removeWhere((element) => element == widget.event);
                     newEvents.add(event);
                    Navigator.pop(context, event);
                  },
                  child: Text("Edit"),
                ),
              ]),
        ),
      ),
    );
  }
}
