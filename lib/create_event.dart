
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calander/calander_events.dart';
import 'package:flutter_calander/main.dart';
import 'package:intl/intl.dart';
import 'package:random_color/random_color.dart';

class CreateEvent extends StatefulWidget {
  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
 final  TextEditingController _eventSubjectController = TextEditingController();

 final  TextEditingController _eventDescriptionController = TextEditingController();

 final  TextEditingController _eventtoController = TextEditingController();
 final  TextEditingController _eventfromController = TextEditingController();



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
                buildDateTimeField(context,"From" , _eventfromController , (){
                  setState(() {
                    // from = _eventfromController.text.isEmpty ? null : DateTime.parse(_eventfromController.text);
                  });
                }),
                buildDateTimeField(context, "To" , _eventtoController, (){
                  setState(() {
                    // to = _eventtoController.text.isEmpty ? null : DateTime.parse(_eventtoController.text);
                  });
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
                       newEvents.add(event); 
                    Navigator.pop(context, event);
                  },
                  child: Text("Submit"),
                ),
              ]),
        ),
      ),
    );
  }
}

TextField buildDateTimeField(BuildContext context,String lable,  TextEditingController controller, VoidCallback onPressed) {
  return TextField(
    controller: controller,
    decoration:  InputDecoration(
      labelText: lable,
      suffixIcon: const Icon(Icons.calendar_today),
    ),
    onTap: () async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context, 
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (picked != null ) {
        final String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        final String formattedTime = time!.hour.toString().padLeft(2, '0') + ':' + time.minute.toString().padLeft(2, '0');
        controller.text = formattedDate + " " + formattedTime;
      }
      onPressed();
    } catch (e) {
       showAboutDialog(context: context, children: [
        Center(child: Text("Error: $e")),]);
    }
    },
  );
}



  TextField buildTextField(icon, name, controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }