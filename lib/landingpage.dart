import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Homepage.dart'; // Import Homepage
import 'package:untitled/loginpage1.dart';
import 'Profilepage.dart';
import 'loginprovider.dart';
import 'Contactus.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginprov, child) {
        return Scaffold(
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
              IconButton(icon: Icon(Icons.account_circle_outlined), onPressed: () {}),
              Text(' Profile     '),
              IconButton(
                icon: Icon(Icons.account_balance_sharp),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ContactPage()),
                  );
                },
              ),

              Text('   Contact Us   '),
              IconButton(icon: Icon(Icons.add_call), onPressed: () {}),
              Text('   Home    '),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Provider.of<LoginProvider>(context, listen: false).signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              Text(' Logout '),
            ],
          ),
          drawer: SidebarMenu(),
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/Background.png',
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCard(context, Icons.person, 'Profile', () {}),
                        _buildCard(context, Icons.home, 'Home', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCard(context, Icons.admin_panel_settings, 'Admin Page', () {}),
                        _buildCard(context, Icons.logout, 'Logout', () {
                          Provider.of<LoginProvider>(context, listen: false).signOut();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 300,
          height: 270,
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.blueGrey),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class SidebarMenu extends StatelessWidget {
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
              child: ListTile(title: const Text('Profile'), onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              }
              ),
            ),
          ),
          Opacity(
            opacity: 1.0,
            child: Container(
              color: Colors.blueGrey.withOpacity(0.3),
              child: ListTile(title: const Text('HomePage'), onTap: ()
              {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                );
              }),
            ),
          ),
          Opacity(
            opacity: 0.6,
            child: Container(
              color: Colors.blueGrey.withOpacity(0.1),
              child: ListTile(title: const Text('Screen Management'), onTap: ()
              {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AppBar()),
                );
              }),
            ),
          ),
          Opacity(
            opacity: 0.6,
            child: Container(
              color: Colors.blueGrey.withOpacity(0.3),
              child: ListTile(title: const Text('Adminpage'), onTap: () {}),
            ),
          ),
          Opacity(
            opacity: 0.6,
            child: Container(
              color: Colors.blueGrey.withOpacity(0.1),
              child: ListTile(title: const Text('Logout'), onTap: () {}),
            ),
          ),
        ],
      ),
    );
  }
}