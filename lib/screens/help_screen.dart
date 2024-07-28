import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('Xarunta Caawinta', style: TextStyle(color: Colors.black)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(text: 'Su\'aalo'),
            Tab(text: 'Nala Soo Xiriir'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildFaqList(),
          buildContactUs(),
        ],
      ),
    );
  }

  Widget buildFaqList() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        buildFaqItem('Waa maxay dhaxalka (inheritance) oo loo adeegsado barnaamijyada?',
            'Dhaxalka waa sifo barnaamijyada ku dhex jirta oo oggolaanaysa in fasal (class) cusub uu ka dhaxlo sifaha iyo hababka (methods) fasal hore.'),
        buildFaqItem('Sidee ayuu fasal uga dhaxli karaa fasal kale?',
            'Fasal wuxuu uga dhaxli karaa fasal kale adoo isticmaalaya erayga "extends" marka aad samaynayso fasal cusub. Tusaale: class A extends B {}.'),
        buildFaqItem('Maxay yihiin faa\'iidooyinka dhaxalka?',
            'Dhaxalka wuxuu fududeeyaa isticmaalka dib-u-isticmaalka koodhka, wuxuu kor u qaadaa habka abaabulka koodhka, wuxuuna yareeyaa koodhka la qoro.'),
        buildFaqItem('Maxaa laga wadaa "super" ee barnaamijyada ku jira?',
            'Erayga "super" waxaa loo adeegsadaa in lagu soo waco habab iyo sifooyin fasalka hooyo (parent class). Tusaale: super.methodName().'),
        buildFaqItem('Sidee baa loo xakameeyaa dhaxalka badan (multiple inheritance)?',
            'Barnaamijyada qaarkood sida Java ma taageeraan dhaxalka badan ee tooska ah, laakiin waxay isticmaalaan interfaces si ay ugu daydaan.'),
        buildFaqItem('Waa maxay kala-duwanaanshaha u dhexeeya dhaxalka tooska ah iyo dhaxalka aan tooska ahayn?',
            'Dhaxalka tooska ah wuxuu dhaxlaa sifaha iyo hababka fasalka hooyo si toos ah, halka dhaxalka aan tooska ahayn (composition) uu isticmaalo sifaha iyo hababka fasalo kale iyagoo aan si toos ah uga dhaxlin.'),
        buildFaqItem('Sideen ugu isticmaalaa dhaxalka koodhka ku qoran Dart?',
            'Dart, waxaad samayn kartaa dhaxal adoo isticmaalaya erayga "extends" si aad u abuurto fasal cusub oo ka dhaxlaya fasal kale.'),
      ],
    );
  }

  Widget buildFaqItem(String question, String answer) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(question, style: TextStyle(fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer),
          ),
        ],
      ),
    );
  }

  Widget buildContactUs() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Nala Soo Xiriir',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text(
              'Haddii aad qabto wax su\'aalo ah ama aad u baahan tahay caawimaad dheeraad ah, fadlan nala soo xiriir adoo isticmaalaya kanaalada hoos ku xusan:'),
          SizedBox(height: 16),
          buildSocialMediaButton(CupertinoIcons.phone, 'Taageerada Telefoonka', () {
            // Call support number
            _launchURL('tel:+252612345678');
          }),
          buildSocialMediaButton(CupertinoIcons.mail, 'Taageerada Emailka', () {
            // Email support
            _launchURL('mailto:support@example.com');
          }),
          buildSocialMediaButton(CupertinoIcons.chat_bubble_text, 'WhatsApp', () {
            // WhatsApp support
            _launchURL('https://wa.me/252612345678');
          }),
          buildSocialMediaButton(CupertinoIcons.person_2, 'Facebook', () {
            // Facebook support
            _launchURL('https://www.facebook.com/example');
          }),
        ],
      ),
    );
  }

  Widget buildSocialMediaButton(
      IconData icon, String label, VoidCallback onPressed) {
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
