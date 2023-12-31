import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'RadioSelection.dart';
import 'DialogUtils.dart';
import 'config.dart';

class CreateNewTaskScreen extends StatefulWidget {
  @override
  _CreateNewTaskScreenState createState() => _CreateNewTaskScreenState();
}

class _CreateNewTaskScreenState extends State<CreateNewTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  DateTime selectedDateTime =  DateTime.now();

  List<String> namesOfProperties = ["High", "Medium", "Low"];
  String selectedPriority = '';
  String errorMessage = '';
  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Let's create a new task",
          style: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),),
        backgroundColor: Colors.purple[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              onChanged: (value) => validateForm(),
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Title:',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),
            TextField(
              controller: descriptionController,
              onChanged: (value) => validateForm(),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: 'Description:',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ListTile(
              title: Row(
                  children: [
                    Text(
                      'Deadline:',
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10.0),
                    Icon( Icons.date_range_outlined
                    ),
                  ]),
              subtitle: Row(
                children: [
                  SizedBox(height: 30.0),
                  Text(
                    _formattedDateTime(selectedDateTime),
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              onTap: () async {
                await _selectDate(context);
                validateForm();
              },
              contentPadding: EdgeInsets.only(left: 0.0),
            ),
            SizedBox(height: 20.0),
            RadioSelection(
              onOptionSelected: (priority) {
                setState(() {
                  selectedPriority = priority;
                  validateForm();
                });
              },
              namesOfOptions: namesOfProperties,
            ),
            SizedBox(height: 20.0),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
              child: ElevatedButton(
                onPressed: isButtonEnabled ? () => createTask() : null,
                child: Text('Add'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                clearFields();
              },
              child: Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }


  void validateForm() {
    setState(() {
      if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty &&
          selectedPriority.isNotEmpty ){
        isButtonEnabled = true;
      }
      else{
        isButtonEnabled = false;
      }
      errorMessage = "";
    });
  }

  void clearFields() {
    setState(() {
      titleController.clear();
      descriptionController.clear();
      deadlineController.clear();
      isButtonEnabled = false;
      errorMessage = "";
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        pickedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          selectedDateTime = pickedDate!;
          deadlineController.text = _formattedDateTime(selectedDateTime);
        });
      }
    }
  }

  String _formattedDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }


  Future<void> createTask() async {
    final url = '${AppConfig.baseUrl}:3000/task/create';
    final body = {
      "title": titleController.text,
      "description": descriptionController.text,
      "deadline": deadlineController.text,
      "priority": selectedPriority.toUpperCase(),
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 201) {
        DialogUtils.showInfoDialog(
            context,
            'Message',
            'The task has been successfully added.',
            Icons.add_task,
            Colors.green);
        clearFields();
      } else {
        final jsonResponse = json.decode(response.body);
        setState(() {
          errorMessage = jsonResponse['errorMessage'];
        });
      }
    }
    catch (error) {
      setState(() {
        errorMessage = 'Encountered a network problem, please try again';
      });
    }
  }
}
