import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Nala Soo Xiriir',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Haddii aad qabto wax su\'aalo ah ama aad u baahan tahay caawimaad dheeraad ah, fadlan nala soo xiriir adoo isticmaalaya kanaalada hoos ku xusan:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            buildSocialMediaButton(CupertinoIcons.phone, 'Taageerada Telefoonka', () {
              _launchURL('tel:+252617372514');
            }),
            buildSocialMediaButton(CupertinoIcons.mail, 'Taageerada Emailka', () {
              _launchURL('mailto:miskiali491@gmail.com');
            }),
            buildSocialMediaButton(CupertinoIcons.chat_bubble_text, 'WhatsApp', () {
              _launchURL('https://wa.me/252617372514');
            }),
            buildSocialMediaButton(CupertinoIcons.person_2, 'Facebook', () {
              _launchURL('https://www.facebook.com/example');
            }),
          ],
        ),
      ),
    );
  }

  Widget buildSocialMediaButton(IconData icon, String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: Size(double.infinity, 50),
        ),
        onPressed: onPressed,
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
