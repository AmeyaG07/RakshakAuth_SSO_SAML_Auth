import 'package:flutter/material.dart';

class appbar extends StatelessWidget {
  const appbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: const Text('RakshakAuth User Screen Management'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu), // Menu icon
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
              opacity: 0.6, // Fully visible row
              child: Container(
                color: Colors.blueGrey.withOpacity(0.1), // Background color with opacity
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
                opacity: 1.0,
            child: Container(
              color: Colors.blueGrey.withOpacity(0.1),
            child: ListTile(
              title: const Text('Screen Management'),
              onTap: () {
              },
            ),
            ),
            ),
            Opacity(
              opacity: 0.6,
            child: Container(
              color: Colors.blueGrey.withOpacity(0.3),
            child: ListTile(
              title: const Text('Adminpage'),
              onTap: () {
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
                  },
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
            const Center(child: CrudTableWidget()),
          ],
        )
     );
  }
}

class CrudTableWidget extends StatefulWidget {
  const CrudTableWidget({Key? key}) : super(key: key);

  @override
  _CrudTableWidgetState createState() => _CrudTableWidgetState();
}

class _CrudTableWidgetState extends State<CrudTableWidget> {
  final List<User> users = [
    User(screens: "HomeScreen", email: "john@example.com"),
    User(screens: "LandingPage", email: "jane@example.com"),
    User(screens: "Adminpage", email: "alice@example.com"),
    User(screens: "User Permissions", email: "john@example.com"),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
        ),
        child: DataTable(
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
              DataCell(Text(user.screens)),
              DataCell(Checkbox(
                value: user.create,
                onChanged: (bool? value) {
                  setState(() { user.create = value ?? false; });
                },
              )),
              DataCell(Checkbox(
                value: user.read,
                onChanged: (bool? value) {
                  setState(() { user.read = value ?? false; });
                },
              )),
              DataCell(Checkbox(
                value: user.update,
                onChanged: (bool? value) {
                  setState(() { user.update = value ?? false; });
                },
              )),
              DataCell(Checkbox(
                value: user.delete,
                onChanged: (bool? value) {
                  setState(() { user.delete = value ?? false; });
                },
              )),
              DataCell(Switch(
                value: user.isEnabled,
                onChanged: (bool value){
                  setState(() { user.isEnabled = value; });
                },
              ))
            ]);
          }).toList(),
        ),
      ),
    );
  }

}

class User {
  final String screens;
  final String email;
  bool create;
  bool read;
  bool update;
  bool delete;
  bool isEnabled;

  User({
    required this.screens,
    required this.email,
    this.create = false,
    this.read = false,
    this.update = false,
    this.delete = false,
    this.isEnabled = false,
  });
}

void main() {
  runApp(MaterialApp(
    home: appbar(),
  ));
}
