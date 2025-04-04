import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/loginpage1.dart';
import 'package:untitled/SidebarWidget.dart';
import 'WidgetProviders.dart';
import 'loginprovider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class LandingPage extends StatefulWidget{
  const LandingPage({Key? key});


  @override
  State<LandingPage>  createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {


  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginprov, child) {
        return Scaffold(
          appBar: Provider.of<AppBarProvider>(context, listen: false).buildAppBar(context),
          drawer: buildSidebarMenu(context, 'HomePage'),
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
                        _buildCard(context, Icons.code, 'LeetCode ', 'https://leetcode.com/accounts/login/'),
                        _buildCard(context, Icons.device_hub_outlined, 'Github', 'https://github.com/login'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCard(context, Icons.add_chart_rounded, 'Pinterest', 'https://in.pinterest.com/login/'),
                        _buildCard(context, Icons.co_present_outlined, 'Canva', 'https://www.canva.com/en_in/'),
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

  Widget _buildCard(BuildContext context, IconData icon, String title, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
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


void _launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, webOnlyWindowName: '_blank');
  } else {
    throw 'Could not launch $url';
  }
}

