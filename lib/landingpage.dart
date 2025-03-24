import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/loginpage1.dart';
import 'loginprovider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<LoginProvider>(

        builder: (context,loginprov,child){return Scaffold(
    appBar: AppBar(
    backgroundColor: Colors.blueGrey,
    foregroundColor: Colors.white,
      title: Text('${loginprov.user?.username ?? "Guest"} Login'),
    leading: Image.asset('assets/images/RA.png',
    height: 10,
    width: 10,
    ),
    actions: [
    IconButton(
    icon: Icon(Icons.account_circle_outlined),
    onPressed: ()
    {},
    ),
    Text(' Profile     '),
    IconButton(
    icon: Icon(Icons.account_balance_sharp),
    onPressed: ()
    {
    },
    ),
    Text('   Contact Us   '),
    IconButton(
    icon: Icon(Icons.add_call),
    onPressed: ()
    {
    },
    ),
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
    body: Stack(
    children: [
    Positioned.fill(
    child: Image.asset(
    'assets/images/Background.png',
    fit: BoxFit.cover,
    ),
    ),
    ],
    ),
    );});
  }
}

