
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/landingpage.dart';
import 'Contactus.dart';
import 'loginprovider.dart';
import 'Profilepage.dart';


class AppBarProvider extends ChangeNotifier {
  PreferredSizeWidget buildAppBar(BuildContext context) {
    final loginprov = Provider.of<LoginProvider>(context, listen: false);

    return AppBar(
      backgroundColor: Colors.blueGrey,
      foregroundColor: Colors.white,
      title: Text('${loginprov.currentuser?.username ?? "Admin"} Login'),
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
        Text(' Profile     '),


        IconButton(
          icon: Icon(Icons.add_ic_call_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactPage()),
            );
          },
        ),
        Text('   Contact Us   '),


        IconButton(icon: Icon(Icons.home), onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LandingPage()),
          );}),
        Text('   Home    '),


        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            loginprov.signOut();
            confirmbox(context);
          },
        ),
        Text('   Logout    '),
      ],
    );
  }





  void confirmbox(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Logout'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              logout(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void logout(BuildContext context) {
    Navigator.pop(context, 'OK');
    Navigator.pushReplacementNamed(context, '/login');
  }
}


class SidebarProvider extends ChangeNotifier {

  List<Screens> screens = [
    Screens(name: "HomeScreen", create: true, read: true , update: true , delete: true),
    Screens(name: "Admin_Dashboard", create: true, read: true , update: true , delete: true),
    Screens(name: "Screen_management", create: true, read: true , update: true , delete: true),
    Screens(name: "Contactus", create: true, read: true , update: true , delete: true),
    Screens(name: "Profilepage", create: true, read: true , update: true , delete: true),
  ];
}

/*
  class SidebarMenu extends StatefulWidget {
  const SidebarMenu({Key? key});

  @override
  State<SidebarMenu> createState() => _SidebarMenu();
}

class _SidebarMenu extends State<SidebarMenu> {

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
    return Drawer(
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
            opacity: 1.0,
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
            opacity: 0.6,
            child: Container(
              color: Colors.blueGrey.withOpacity(0.1),
              child: ListTile(
                title: const Text('Contact Us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactPage()),
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
    );
  }
}

*/


/*


  APPBAR CLASS

  appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            title: Text('${loginprov.user?.username ?? "Admin"} Login'),
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            actions: [
              IconButton(icon: Icon(Icons.account_circle_outlined), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              }),
              Text(' Profile     '),
              IconButton(
                icon: Icon(Icons.add_ic_call_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactPage()),
                  );
                },
              ),

              Text('   Contact Us   '),
              IconButton(icon: Icon(Icons.home), onPressed: () {

              }),
              Text('   Home    '),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Provider.of<LoginProvider>(context, listen: false).signOut();
                  confirmbox(context);
                },
              ),
              Text('   Logout    '),
            ],
          ),
   */


