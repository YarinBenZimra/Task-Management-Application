import 'package:flutter/material.dart';
import 'Task.dart';
import 'TaskCard.dart';

class TaskCardsScreen extends StatefulWidget {
  final List<Task> tasks;

  TaskCardsScreen({required this.tasks});

  @override
  State<TaskCardsScreen> createState() => _TaskCardsScreenState();
}

class _TaskCardsScreenState extends State<TaskCardsScreen> {
  int currentIndex =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Details",
          style: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),),
        backgroundColor: Colors.purple[900],
      ),
      backgroundColor: Colors.purple[900],
      body: Column(
        children: [
          TaskCard(task: widget.tasks[currentIndex]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: currentIndex > 0 ? () => navigateToTask(currentIndex - 1) : null,
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: currentIndex < widget.tasks.length - 1 ? () => navigateToTask(currentIndex + 1) : null,
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void navigateToTask(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}