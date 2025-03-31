import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: const Color(0xFFF5F5F5),
      ),
      home: const ContactScreen(),
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.lightBlueAccent,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.healing, color: Colors.amber[300], size: 40),
                    Row(
                      children: const [
                        NavItem(title: 'Mobile App'),
                        SizedBox(width: 20),
                        NavItem(title: 'Tandvård'),
                        SizedBox(width: 20),
                        NavItem(title: 'Om Oss'),
                        SizedBox(width: 20),
                        NavItem(title: 'Blog'),
                        SizedBox(width: 20),
                        Icon(Icons.headset_mic, color: Colors.amber, size: 30),
                      ],
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Row(
                    children: [
                      // Left side - Contact Info
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contact Us',
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'RakshakAuth tagline',
                              style: TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                            const SizedBox(height: 50),
                            const ContactInfoItem(icon: Icons.location_on, title: 'Address', detail: 'India'),
                            const SizedBox(height: 30),
                            const ContactInfoItem(icon: Icons.email, title: 'Email', detail: 'ingaleprachi133@gmail.com'),
                            const SizedBox(height: 30),
                            const ContactInfoItem(icon: Icons.phone, title: 'Phone', detail: '(+91) 9370932686'),
                          ],
                        ),
                      ),

                      // Right side - Contact Form
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: const Color(0xFF60A5FA).darker(0.1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Contact Us',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              const SizedBox(height: 30),

                              // Name field
                              const Text('Name', style: TextStyle(fontSize: 16, color: Colors.white)),
                              const SizedBox(height: 10),
                              const CustomFormField(placeholder: 'Enter your full name'),
                              const SizedBox(height: 25),

                              // Email field
                              const Text('Email', style: TextStyle(fontSize: 16, color: Colors.white)),
                              const SizedBox(height: 10),
                              const CustomFormField(placeholder: 'LoremIpsum@gmail.com'),
                              const SizedBox(height: 25),

                              // Details field
                              const Text('Details', style: TextStyle(fontSize: 16, color: Colors.white)),
                              const SizedBox(height: 10),
                              const CustomFormField(placeholder: 'Enter your problem details'),
                              const SizedBox(height: 30),

                              // Send button
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF60A5FA),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                  ),
                                  child: const Text('Send Message', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                ),
                              ),

                              // Social icons
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SocialIcon(icon: FontAwesomeIcons.youtube),
                                  SizedBox(width: 15),
                                  SocialIcon(icon: FontAwesomeIcons.instagram),
                                  SizedBox(width: 15),
                                  SocialIcon(icon: FontAwesomeIcons.linkedin),
                                  SizedBox(width: 15),
                                  SocialIcon(icon: FontAwesomeIcons.facebook),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  const NavItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500));
  }
}

class ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;

  const ContactInfoItem({Key? key, required this.icon, required this.title, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.amber[300], size: 24),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500)),
            Text(detail, style: const TextStyle(fontSize: 14, color: Colors.white70)),
          ],
        ),
      ],
    );
  }
}

class CustomFormField extends StatelessWidget {
  final String placeholder;
  const CustomFormField({Key? key, required this.placeholder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: Colors.white54),
        border: InputBorder.none,
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData icon;
  const SocialIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: Colors.white, size: 20);
  }
}

// Extension to create darker shades of a color
extension ColorExtension on Color {
  Color darker([double amount = 0.1]) {
    return HSLColor.fromColor(this).withLightness((HSLColor.fromColor(this).lightness - amount).clamp(0.0, 1.0)).toColor();
  }
}
