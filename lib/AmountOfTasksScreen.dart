import 'dart:convert';
import 'package:TaskManagerApp/DialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'RadioSelection.dart';
import 'config.dart';

class AmountOfTasksScreen extends StatefulWidget {
  @override
  _AmountOfTasksScreenState createState() => _AmountOfTasksScreenState();
}

class _AmountOfTasksScreenState extends State<AmountOfTasksScreen> {
  String selectedPriority = '';
  String result = '';
  String errorMessage = '';
  int numberOfTasks = 0;
  List<String> namesOfProperties = ["All", "High", "Medium", "Low"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Tell me how much",
          style: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),),
        backgroundColor: Colors.purple[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RadioSelection(
              onOptionSelected: (priority) {
                setState(() {
                  selectedPriority = priority;
                });
              },
              namesOfOptions: namesOfProperties,
            ),
            ElevatedButton(
              onPressed: selectedPriority.isEmpty ? null : () {
                getNumberOfTasks();
                errorMessage = '';
              },
              child: Text('Get Number Of Tasks'),
            ),
            Text(
              errorMessage,
              style: TextStyle(fontSize: 15.0, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getNumberOfTasks() async {
    final url = '${AppConfig.baseUrl}:3000/task/size?priority=${selectedPriority.toUpperCase()}';
    try {
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          result = responseData['result'].toString();
          numberOfTasks = int.parse(result);
          result = selectedPriority == "All" ? 'The total number of tasks is $numberOfTasks' : 'The total number of tasks at priority $selectedPriority is $numberOfTasks';
          DialogUtils.showInfoDialog(context, 'Message', result, Icons.format_list_numbered, Colors.green);
        });
      } else {
        setState(() {
          final responseData = json.decode(response.body);
          errorMessage = responseData['errorMessage'].toString();
        });
      }
    } catch (error) {
      setState(() {
      errorMessage ='Encountered a network problem, please try again';
      });
    }
  }
}