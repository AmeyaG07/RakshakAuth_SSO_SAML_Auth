import 'package:flutter/material.dart';
import 'package:untitled/Loginpage1.dart';
import 'package:untitled/landingpage.dart';
import 'Screen_management.dart';
import 'package:untitled/Profilepage.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

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



class _AdminDashboardState extends State<AdminDashboard> {
  bool isUserEnabled = false;
void ShowDialogBox(bool isEditable){
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: isEditable?Text('Edit User') :Text('Add User'),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: const Text('RakshakAuth Admin Dashboard'),
        leading: Builder(
          builder: (context) => IconButton(
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
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
            ListTile(title: const Text('Profile'), onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            }),
            ListTile(title: const Text('HomePage'), onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
              );
            }),
            ListTile(title: const Text('Screen Management'), onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenManagement()),
              );
            }),
            ListTile(title: const Text('Adminpage'), onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminDashboard()),
              );
            }),
            ListTile(title: const Text('Logout'), onTap: () {
              confirmbox(context);
            }),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/Background.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          userTableWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        ShowDialogBox(false);
      },
      child: Icon(Icons.add),),
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

  void ShowDialogBox(bool isEditable){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: isEditable?Text('Edit User') :Text('Add User'),
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


  void confirmdeletebox(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
        title: Text('Confirm Delete '),
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
      MaterialPageRoute(builder: (context) => AdminDashboard()),
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
                  ShowDialogBox(true);
                },
              ),
            ),
            DataCell(
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  confirmdeletebox(context);
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