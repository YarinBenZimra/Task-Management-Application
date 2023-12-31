import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'RadioSelection.dart';
import 'DialogUtils.dart';
import 'config.dart';

class UpdatePriorityScreen extends StatefulWidget {
  @override
  State<UpdatePriorityScreen> createState() => _UpdatePriorityScreenState();
}

class _UpdatePriorityScreenState extends State<UpdatePriorityScreen> {
  TextEditingController idController = TextEditingController();
  bool isButtonEnabled = false;
  List<String> namesOfProperties = ["High", "Medium", "Low"];
  String selectedPriority = '';
  String errorMessage = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update priority",
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
                  labelText: 'Id:',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  )
              ),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    onPressed: isButtonEnabled ? () => updatePriority(context) : null,
                    child: Text('Update')
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
      if(idController.text.isNotEmpty && selectedPriority.isNotEmpty ){
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
      errorMessage = '';
    });
  }
  Future<void> updatePriority(BuildContext context) async {
    final url = '${AppConfig.baseUrl}:3000/task/priority?id=${idController.text}&priority=${selectedPriority.toUpperCase()}';
    try {
      final response = await http.put(Uri.parse(url)).timeout(Duration(seconds: 5));
      final Map<String, dynamic> result = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          DialogUtils.showInfoDialog(context, 'Message', result['result'], Icons.update, Colors.green);
        });
      } else {
        setState(() {
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