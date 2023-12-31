import 'package:flutter/material.dart';
import 'HomeButton.dart';
import 'CreateNewTaskScreen.dart';
import 'AmountOfTasksScreen.dart';
import 'TasksDataScreen.dart';
import 'UpdatePriorityScreen.dart';
import 'SearchTasksByKeywordScreen.dart';
import 'DeleteTaskScreen.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title:Center(
          child: Text(
            'Task Management',
            style: TextStyle(
              fontFamily: 'IndieFlower',
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/HomeScreen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            padding: EdgeInsets.all(25.0),
            children: [
              HomeButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateNewTaskScreen()),
                  );
                },
                icon: Icons.add,
                label: 'Create a new task',

              ),
              HomeButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AmountOfTasksScreen()),
                  );
                },
                icon: Icons.format_list_numbered,
                label: 'Number of tasks',
              ),
              HomeButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TasksDataScreen()),
                  );
                },
                icon: Icons.list,
                label: 'Tasks data',
              ),
              HomeButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdatePriorityScreen()),
                  );
                },
                icon: Icons.update,
                label: 'Update priority',
              ),
              HomeButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchTasksByKeywordScreen()),
                  );
                },
                icon: Icons.search,
                label: 'Search by keyword',
              ),
              HomeButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeleteTaskScreen()),
                  );
                },
                icon: Icons.delete_forever,
                label: 'Delete task',
              ),
            ],
          ),
        ),
      ),
    );
  }
}