import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/landingpage.dart';
import 'package:untitled/loginprovider.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: const Text('RakshakAuth Login'),
        leading: Image.asset('assets/images/RA.png',
          height: 10,
          width: 10,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: ()
            {},
          ),
          Text(' Login     '),
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: ()
            {
            },
          ),
          Text('   Signup       '),

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
          Center(
            child: Logincard(),
          ),
        ],
      ),
    );
  }
}

class Logincard extends StatelessWidget {
  const Logincard({Key? key});

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
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/RA.png',
                height: 50,
                width: 50,
              ),
              const Text(
                '  Rakshakauth Login  ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                    labelText: 'Username', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 25),
              Consumer<LoginProvider>(
                builder: (context, loginprov, child) {
                  return ElevatedButton.icon(
                    icon: Image.asset('assets/images/Google.png', height: 25),
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
    );
  }


}
