import 'package:flutter/material.dart';
import 'package:untitled/Admin_Dashboard.dart';
import 'package:untitled/Loginpage1.dart';
import 'package:untitled/Profilepage.dart';
import 'package:untitled/landingpage.dart';

class ScreenManagement extends StatefulWidget {
  const ScreenManagement({Key? key});

  @override
  State<ScreenManagement> createState() => _ScreenManagement();
}

class _ScreenManagement extends State<ScreenManagement> {

  void confirmbox(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
        title: Text('Logout'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => { logout(context)
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void logout(BuildContext context){
    Navigator.pop(context, 'OK');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: const Text('RakshakAuth User Screen Management'),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Column(
                children: [
                  Image.asset('assets/images/RA.png', width: 80),
                  SizedBox(height: 10),
                  Text(
                      'Menu',
                      style: TextStyle(color: Colors.white, fontSize: 24)
                  ),
                ],
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: Container(
                color: Colors.blueGrey.withOpacity(0.1),
                child: ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                ),
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: Container(
                color: Colors.blueGrey.withOpacity(0.3),
                child: ListTile(
                  title: const Text('HomePage'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                    );
                  },
                ),
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: Container(
                color: Colors.blueGrey.withOpacity(0.1),
                child: ListTile(
                  title: const Text('Screen Management'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScreenManagement()),
                    );
                  },
                ),
              ),
            ),
            Opacity(
              opacity: 1.0,
              child: Container(
                color: Colors.blueGrey.withOpacity(0.3),
                child: ListTile(
                  title: const Text('Adminpage'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminDashboard()),
                    );
                  },
                ),
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: Container(
                color: Colors.blueGrey.withOpacity(0.1),
                child: ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    confirmbox(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/Background.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: CrudTableWidget()),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class userTableWidget extends StatefulWidget {
  const userTableWidget({Key? key}) : super(key: key);

  @override
  _userTableWidgetState createState() => _userTableWidgetState();
}

class _userTableWidgetState extends State<userTableWidget> {
  final List<User> users = [
    User(Users: "User_1", email: "john@example.com"),
    User(Users: "User_2", email: "jane@example.com"),
    User(Users: "User_3", email: "alice@example.com"),
    User(Users: "User_4", email: "john@example.com"),
  ];

  void ShowDialogBox(){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Add User'),
          content: CrudTableWidget(),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: 1500,
      child: DataTable(
        columnSpacing: 20,
        columns: const [
          DataColumn(label: Text('Users')),
          DataColumn(label: Text('Emails')),
          DataColumn(label: Text('Update')),
          DataColumn(label: Text('Delete')),
        ],
        rows: users.map((user) {
          return DataRow(cells: [
            DataCell(Text(user.Users)),
            DataCell(Text(user.email)),
            DataCell(
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.grey,
                onPressed: () {
                  ShowDialogBox();
                },
              ),
            ),
            DataCell(
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  ShowDialogBox();
                },
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }
}


class User {
  final String Users;
  final String email;
  bool create;
  bool read;
  bool update;
  bool delete;
  bool isEnabled;

  User({
    required this.Users,
    required this.email,
    this.create = false,
    this.read = false,
    this.update = false,
    this.delete = false,
    this.isEnabled = false,
  });
}


class CrudTableWidget extends StatefulWidget {
  const CrudTableWidget({Key? key}) : super(key: key);

  @override
  _CrudTableWidgetState createState() => _CrudTableWidgetState();
}

class _CrudTableWidgetState extends State<CrudTableWidget> {
  bool isEmailEnabled = false;
  final List<User> users = [
    User(Users: "HomeScreen", email: "john@example.com"),
    User(Users: "LandingPage", email: "jane@example.com"),
    User(Users: "Adminpage", email: "alice@example.com"),
    User(Users: "User Permissions", email: "john@example.com"),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 350,
        child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('Email', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
    Switch(value:isEmailEnabled , onChanged: (value) {
      setState(() {
        isEmailEnabled = value; // Toggle state
      });
    },
    )
  ],
        ),
          DataTable(
            columns: const [
              DataColumn(label: Text('Screens')),
              DataColumn(label: Text('Create')),
              DataColumn(label: Text('Read')),
              DataColumn(label: Text('Update')),
              DataColumn(label: Text('Delete')),
            ],
            rows: users.map((user) {
              return DataRow(cells: [
                DataCell(Text(user.Users)),
                DataCell(Checkbox(
                  value: user.create,
                  onChanged: (bool? value) {
                    setState(() {
                      user.create = value ?? false;
                    });
                  },
                )),
                DataCell(Checkbox(
                  value: user.read,
                  onChanged: (bool? value) {
                    setState(() {
                      user.read = value ?? false;
                    });
                  },
                )),
                DataCell(Checkbox(
                  value: user.update,
                  onChanged: (bool? value) {
                    setState(() {
                      user.update = value ?? false;
                    });
                  },
                )),
                DataCell(Checkbox(
                  value: user.delete,
                  onChanged: (bool? value) {
                    setState(() {
                      user.delete = value ?? false;
                    });
                  },
                )),
              ]);
            }).toList(),
          )
        ]));
/*    Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.8),
    borderRadius: BorderRadius.circular(10),
    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
    ),
    child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child:  )
    );*/
  }
}
