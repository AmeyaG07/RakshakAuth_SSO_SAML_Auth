import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/landingpage.dart';
import 'package:untitled/loginprovider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showLoginCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: const Text('RakshakAuth Login'),
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
            icon: Icon(Icons.login),
            onPressed: () {
              setState(() {
                showLoginCard = true;
              });
            },
          ),
          Text(' Login     '),
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {
              setState(() {
                showLoginCard = !showLoginCard;
              });
            },
          ),
          Text('   Signup       '),
        ],
      ),
      drawer: SidebarMenu(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/homescreen.png',
              fit: BoxFit.cover,
            ),
          ),
          if (showLoginCard)
            Center(
              child: Logincard(
                onClose: () {
                  setState(() {
                    showLoginCard = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}

class Logincard extends StatelessWidget {
  final VoidCallback onClose;

  const Logincard({Key? key, required this.onClose}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return SizedBox(
      width: 800,
      height: 600,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 100.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                ),
              ),
              Image.asset('assets/images/RA.png',
                height: 40,
                width: 40,
              ),
              const Text(
                '  Rakshakauth Login  ',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8 , width: 8),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                    labelText: 'Username', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8 , width: 8),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 40 , width: 80),
              Consumer<LoginProvider>(
                builder: (context, loginprov, child) {
                  return ElevatedButton.icon(
                    icon: Image.asset('assets/images/Google.png', height: 20 , width: 40,),
                    label: const Text('Sign in with Google'),
                    onPressed: () async {
                      bool success = await loginprov.signInWithGoogle(context);

                      if (success) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const LandingPage()),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (ctx) =>
                              AlertDialog(
                                title: const Text("Login Failed"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text("Close"),
                                  ),
                                ],
                              ),
                        );
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  User user = User();
                  user.username = usernameController.text;
                  user.password = passwordController.text;
                  bool success = (usernameController.text == "admin" &&
                      passwordController.text == "admin");
                  String message = success
                      ? "Login Successful"
                      : "Invalid Login";

                  if (success) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const LandingPage()),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(
                            title: const Text("Login Failed"),
                            content: const Text("Invalid Username or Password"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Close"),
                              ),
                            ],
                          ),
                    );
                  }
                },
                child: const Text("Login"),
              ),
            ],
          ),

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
            opacity: 1.0,
            child: Container(
              color: Colors.blueGrey.withOpacity(0.1), // Background color with opacity
              child: ListTile(
                title: const Text('LoginPage'),
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
    );
  }
}

