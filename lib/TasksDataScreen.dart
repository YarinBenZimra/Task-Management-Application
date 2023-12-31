import 'package:flutter/material.dart';
import 'RadioSelection.dart';
import 'Task.dart';
import 'DialogUtils.dart';
import 'TaskCardsScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';

class TasksDataScreen extends StatefulWidget {
  @override
  _TasksDataScreenState createState() => _TasksDataScreenState();
}

class _TasksDataScreenState extends State<TasksDataScreen> {
  String selectedPriority = '';
  String selectedSortBy = '';
  String errorMessage = '';
  List<String> namesOfPriorities = ["All", "High", "Medium", "Low"];
  List<String> namesOfSortBy = ['Id', 'Deadline', 'Title'];
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Show me the content',
          style: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50.0),
              RadioSelection(
                onOptionSelected: (priority) {
                  setState(() {
                    selectedPriority = priority;
                    errorMessage = '';
                  });
                },
                namesOfOptions: namesOfPriorities,
              ),
              SizedBox(height: 50.0),
              RadioSelection(
                  onOptionSelected: (sortBy) {
                    setState(() {
                      selectedSortBy = sortBy;
                      errorMessage = '';
                    });
                  },
                  namesOfOptions: namesOfSortBy,
                  titleName: 'Sort By:'
              ),
              SizedBox(height: 10),
              Text(errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 15.0), ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: (selectedPriority.isNotEmpty && selectedSortBy.isNotEmpty)
                    ? () {
                  setState(() {
                    getTasksData(context);
                    errorMessage = '';
                  });
                }  : null,
                child: Text("Show Tasks's Content"),
              ),
            ]),
      ),
    );
  }
  void showTasksCardsScreenOrNoTaskMessage(){
    setState(() {
      if(tasks.isEmpty){
        final message = 'There are not tasks at priority ${selectedPriority}';
        DialogUtils.showInfoDialog(context, 'Message', message, Icons.no_accounts, Colors.red);
      }
      else if(selectedPriority.isNotEmpty && selectedSortBy.isNotEmpty){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskCardsScreen(tasks: tasks)),
        );
      }
    });
  }
  List<Task> parseTasks(String responseBody) {
    final List<dynamic> parsed = json.decode(responseBody);
    return parsed.map((taskJson) => Task.fromJson(taskJson)).toList();
  }

  Future<void> getTasksData(BuildContext context) async {
    final url = '${AppConfig.baseUrl}:3000/task/data?priority=${selectedPriority.toUpperCase()}&sortBy=${selectedSortBy.toUpperCase()}';
    try {
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        setState(() {
          tasks = parseTasks(response.body);
          showTasksCardsScreenOrNoTaskMessage();
        });
      } else {
        setState(() {
          final Map<String, dynamic> result = json.decode(response.body);
          errorMessage = result['errorMessage'];
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Encountered a network problem, please try again';
      });
    }
  }
}