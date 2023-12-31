# Task Management App (Flutter)
A Flutter-based task management application that serves as a client for the Node.js-based Task Management Application server.
This app allows users to interact with the server's endpoints for creating, updating, deleting, searching, and retrieving tasks.

## Overview

This Flutter application serves as a front-end for the Task Management Application server, 
providing a user-friendly interface for managing tasks with various functionalities.

## Features

- Create, view, search, delete, update tasks using the server's endpoints.
- Interact with the server for task management operations.
- Intuitive user interface for task-related actions.

## Getting Started

### Prerequisites

- Flutter and Dart installed.
- Created virtual device for display the application.
- Git installed.
- A clone of the Task Management Application server repository. Follow the server README for setup.

### Installation

#### 1. Clone the repository

   ```bash 
   git clone https://github.com/YarinBenZimra/Task-Management-Application.git
```

#### 2. Navigate to the project directory

  ```bash 
cd TaskManagerApp
```

#### 3. Configure the server URL
   Edit the config.dart file in the lib directory and replace the serverUrl with your server's IP address.

 ```bash
class AppConfig {
  static const String serverUrl = 'http://your_server_ip:3000';
}
```

#### 4. Install the dependencies

 ```bash 
 flutter pub get
```

#### 5. Run the app

 ```bash 
flutter run
```

### Usage
Navigate through the app to view, create, update, delete, and search for tasks.
Interact with the server for seamless task management.
Screenshots and details of app screens below.

## Screenshots
### Home Page

![](/Screenshots/Home_Page.png)

### Create Task Page

![](/Screenshots/Create_A_New_Task.png)

### Number Of Tasks Page

![](/Screenshots/Number_Of_Tasks.png)

### Search By Keyword Page

![](/Screenshots/Search_By_Keyword.png)

### Show Content Page

![](/Screenshots/Show_Content.png)

### Update Priority Page

![](/Screenshots/Update_Priority.png)

### Delete Task Page

![](/Screenshots/Delete_Task.png)


### Contributing
Feel free to contribute to the project by opening issues or submitting pull requests. Follow the Contribution Guidelines.

### License
This project is licensed under the MIT License.




