import 'package:flutter/material.dart';
import 'Task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'Task Id ${task.id}',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'IndieFlower',
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[900],
                  ),
                ),
              ),
              Divider(
                color: Colors.grey[800],
                height: 30.0,
              ),
              Text(
                'TITLE',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '${task.title}',
                style: TextStyle(
                  color: Colors.purple[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'DESCRIPTION',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '${task.description}',
                style: TextStyle(
                  color: Colors.purple[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'DEADLINE',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '${task.deadline}',
                style: TextStyle(
                  color: Colors.purple[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'PRIORITY',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '${task.priority}',
                style: TextStyle(
                  color: Colors.purple[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Divider(
                color: Colors.grey[800],
                height: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}