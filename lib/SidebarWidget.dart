
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/WidgetProviders.dart';
import 'Admin_Dashboard.dart';
import 'Contactus.dart';
import 'Profilepage.dart';
import 'Screen_management.dart';
import 'landingpage.dart';
import 'loginprovider.dart';

Widget buildSidebarMenu(BuildContext context, String currentPage) {
  return Consumer<SidebarProvider>(
    builder: (context, sidebarProvider, _) {
      List<Widget> screens = [];
      for (Screens screen in sidebarProvider.screens) {
        screens.add(_buildMenuItem(context, screen.name!, ProfileScreen(), currentPage));
      }

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
                    currentPage,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
            _buildMenuItem(context, 'Profile', ProfileScreen(), currentPage),
            _buildMenuItem(context, 'HomePage', LandingPage(), currentPage),
            _buildMenuItem(context, 'Screen Management', ScreenManagement(), currentPage),
            _buildMenuItem(context, 'Contact Us', ContactPage(), currentPage),
            _buildMenuItem(context, 'Admin Dashboard', AdminDashboard(), currentPage),
            _buildLogoutItem(context),
          ],
        ),
      );
    },
  );
}

Widget _buildMenuItem(BuildContext context, String title, Widget page, String currentPage) {
  bool isActive = title == currentPage;

  return Container(
    color: isActive ? Colors.blueGrey[50] : Colors.blueGrey[50],
    child: ListTile(
      title: Text
        (
        title, style: TextStyle(
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        color: isActive ? Colors.white : Colors.black,
      ),
      ),
      onTap: () {
        if (!isActive) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
    ),
  );
}


Widget _buildLogoutItem(BuildContext context) {
  return Opacity(
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
  );
}
