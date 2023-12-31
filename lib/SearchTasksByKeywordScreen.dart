import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'DialogUtils.dart';
import 'TaskCardsScreen.dart';
import 'Task.dart';
import 'config.dart';

class SearchTasksByKeywordScreen extends StatefulWidget {
  @override
  State<SearchTasksByKeywordScreen> createState() => _SearchTasksByKeywordScreenState();
}

class _SearchTasksByKeywordScreenState extends State<SearchTasksByKeywordScreen> {
  TextEditingController searchController = TextEditingController();
  String errorMessage = '';
  bool isButtonEnabled = false;
  List<Task> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search by keyword',
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
              TextField(
                controller: searchController,
                onChanged: (value) => validateForm(),
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Enter keyword:',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                errorMessage,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 15.0),
              ),
              SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: isButtonEnabled ? () => getTasksData(context) : null,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                  backgroundColor: isButtonEnabled
                      ? MaterialStateProperty.all<Color>(Colors.purple[900]!)
                      : MaterialStateProperty.all<Color>(Colors.grey),
                ),
              ),
            ]),
      ),
    );
  }
  void showTasksCardsScreenOrNoTaskMessage(){
    setState(() {
      if(tasks.isEmpty){
        final message = 'There are no tasks with keyword ${searchController.text}';
        DialogUtils.showInfoDialog(context, 'Message', message, Icons.no_accounts, Colors.red);
      }
      else if(searchController.text.isNotEmpty){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskCardsScreen(tasks: tasks)),
        );
      }
    });
  }
  void validateForm() {
    setState(() {
      if(searchController.text.isNotEmpty ){
        isButtonEnabled = true;
      }
      else{
        isButtonEnabled = false;
      }
      errorMessage = "";
    });
  }
  Future<void> getTasksData(BuildContext context) async {
    final url = '${AppConfig.baseUrl}:3000/task/search?keyword=${searchController.text}';
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
  List<Task> parseTasks(String responseBody) {
    final List<dynamic> parsed = json.decode(responseBody);
    return parsed.map((taskJson) => Task.fromJson(taskJson)).toList();
  }
}