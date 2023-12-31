import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'DialogUtils.dart';
import 'config.dart';

class DeleteTaskScreen extends StatefulWidget {
  @override
  State<DeleteTaskScreen> createState() => _DeleteTaskScreenState();
}

class _DeleteTaskScreenState extends State<DeleteTaskScreen> {
  TextEditingController idController = TextEditingController();
  bool isButtonEnabled = false;
  String errorMessage = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Delete task",
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
              controller: idController,
              keyboardType: TextInputType.number,
              onChanged: (value) => validateForm(),
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Enter the id of the task you want to delete:',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 50.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: isButtonEnabled
                          ? MaterialStateProperty.all<Color>(Colors.red)
                          : MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    onPressed: isButtonEnabled ? () => deleteTask(context) : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Delete',
                          style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
                        SizedBox(width: 10.0),
                        Icon(Icons.delete,
                          color: Colors.white,)
                      ],
                    )
                ),
                ElevatedButton(
                    onPressed: () => clearFields(),
                    child: Text('Clear')
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void validateForm() {
    setState(() {
      if(idController.text.isNotEmpty ){
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
      idController.clear();
      isButtonEnabled = false;
      errorMessage = "";
    });
  }
  Future<void> deleteTask(BuildContext context) async {
    final url = '${AppConfig.baseUrl}:3000/task?id=${idController.text}';
    try {
      final response = await http.delete(Uri.parse(url)).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        setState(() {
          final Map<String, dynamic> result = jsonDecode(response.body);
          final deleteMessage = result['message'];
          DialogUtils.showInfoDialog(context, 'Message', deleteMessage, Icons.done, Colors.green);
        });
      } else {
        setState(() {
          final Map<String, dynamic> result = json.decode(response.body);
          errorMessage = result['errorMessage'];
        });
      }
    } on FormatException {
      setState(() {
        errorMessage = 'Invalid id, please enter positive integer.';
      });}
    catch (error) {
      setState(() {
        errorMessage = 'Encountered a network problem, please try again';
      });
    }
  }
}