import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: const Text('RakshakAuth AdminPage'),
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
                  onTap: () {},
                ),
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: Container(
                color: Colors.blueGrey.withOpacity(0.3),
                child: ListTile(
                  title: const Text('HomePage'),
                  onTap: () {},
                ),
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: Container(
                color: Colors.blueGrey.withOpacity(0.1),
                child: ListTile(
                  title: const Text('Screen Management'),
                  onTap: () {},
                ),
              ),
            ),
            Opacity(
              opacity: 1.0,
              child: Container(
                color: Colors.blueGrey.withOpacity(0.3),
                child: ListTile(
                  title: const Text('Adminpage'),
                  onTap: () {},
                ),
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: Container(
                color: Colors.blueGrey.withOpacity(0.1),
                child: ListTile(
                  title: const Text('Logout'),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background.png',
              fit: BoxFit.cover,
            ),
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // Centers tables vertically
              crossAxisAlignment: CrossAxisAlignment.center,
              // Centers tables horizontally
              children: const [
                CrudTableWidget(), // Displayed first (on top)
                SizedBox(height: 20), // Adds spacing between tables
                userTableWidget(), // Displayed second (below)
              ],
            ),
          )
        ],
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
    User(Users: "Admin", email: "john@example.com"),
    User(Users: "Manager", email: "jane@example.com"),
    User(Users: "TeamLead", email: "alice@example.com"),
    User(Users: "Employee", email: "john@example.com"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Users')),
            DataColumn(label: Text('Homepage')),
            DataColumn(label: Text('Screen Management')),
            DataColumn(label: Text('Admin Page')),
            DataColumn(label: Text('Product 1')),
            DataColumn(label: Text('Product2')),
            DataColumn(label: Text('Enable/Disable')),
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
              )
              ),
              DataCell(Checkbox(
                value: user.update,
                onChanged: (bool? value) {
                  setState(() {
                    user.update = value ?? false;
                  });
                },
              )),
              DataCell(
                  Switch(
                    value: user.isEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        user.isEnabled = value;
                      });
                    },
                  )
              )
            ]
            );
          }
          ).toList(),
        ),
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
    Switch(value: true, onChanged: (value) {

    })
  ], ),
          DataTable(
            columns: const [
              DataColumn(label: Text('Screens')),
              DataColumn(label: Text('Create')),
              DataColumn(label: Text('Read')),
              DataColumn(label: Text('Update')),
              DataColumn(label: Text('Delete')),
              DataColumn(label: Text('Enable/Disable')),
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
                DataCell(
                  Switch(
                    value: user.isEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        user.isEnabled = value;
                      });
                    },
                  ),
                ),
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


void main() {
  runApp(MaterialApp(
    home: Appbar(),
  ));
}
