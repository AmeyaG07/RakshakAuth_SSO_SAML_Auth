import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Loginpage1.dart';
import 'package:untitled/SidebarWidget.dart';
import 'Screen_management.dart';


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
      drawer: buildSidebarMenu(context, 'AdminPage'),
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
  List<User> users = [];

  bool _isLoading = true;//
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }
  void fetchUsers() async {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("users");

    dbRef.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.exists) {
        List<User> tempUsers = [];
        Map<dynamic, dynamic> usersData = snapshot.value as Map<dynamic, dynamic>;

        usersData.forEach((key, value) {//
          // Check the data structure and handle accordingly
          if (value is Map) {
            String username = value["username"] ?? "Unknown";
            String email = value["email"] ?? "No email";

            // If there's a nested structure like the one in your database
            if (username == "Unknown" && value.containsKey("username") && value["username"] is String) {
              username = value["username"];
            }

            tempUsers.add(User(
              id: key,
              Users: username,
              email: email, //195
            ));
          }
        });//

        setState(() {
          users = tempUsers;
          _isLoading = false;
        });
      }
    }).catchError((error) {
      print("Error fetching users: $error");
      setState(() {
        _isLoading = false;
      });
    });
  }



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


  void confirmdeletebox(BuildContext context , String userId, String username) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
        title: Text('Confirm Delete '),
        content: Text('Are you sure you want to delete user "$username"?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => { deleteUser(context, userId, username) },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
  void deleteUser(BuildContext context, String userKey, String username) {
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users").child(userKey);
    userRef.remove().then((_) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User "$username" deleted successfully')),
      );
      Navigator.pop(context, 'OK');
      setState(() {
        _isLoading = true;
      });
      fetchUsers();
    }).catchError((error) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: $error')),
      );
      Navigator.pop(context, 'OK');
    });
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
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : users.isEmpty
          ? Center(child: Text("No users found"))
          : DataTable(
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
                  confirmdeletebox(context, user.id, user.Users);
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
  final String id;
  final String Users;
  final String email;
  bool create;
  bool read;
  bool update;
  bool delete;
  bool isEnabled;

  User({
    required this.id,
    required this.Users,
    required this.email,
    this.create = false,
    this.read = false,
    this.update = false,
    this.delete = false,
    this.isEnabled = false,
  });
}