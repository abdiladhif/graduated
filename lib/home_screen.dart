import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_graduated/About.dart';
import 'package:project_graduated/Thank.dart';
import 'package:project_graduated/model/user_model.dart';
import 'package:project_graduated/screens/results_page.dart';
import 'package:provider/provider.dart';
import 'package:project_graduated/provide/user_provider.dart';
import 'package:project_graduated/screens/estate_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildHeader(user),
                Expanded(child: _buildContent(user)),
              ],
            ),
    );
  }

  Widget _buildHeader(User user) {
    // Use the provided fixed path
    final String imagePath =
        'C:/Users/HP/Desktop/flutter_application_7/inheritance-api/uploads/1720818368009-1000004479.jpg';

    // Check if the file exists
    final File imageFile = File(imagePath);
    final bool fileExists = imageFile.existsSync();

    print('Image path: $imagePath');
    print('File exists: $fileExists');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                  "https://st3.depositphotos.com/9998432/13335/v/450/depositphotos_133352156-stock-illustration-default-placeholder-profile-icon.jpg"),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_getGreeting()},',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '${user.name}!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome to your dashboard',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(User user) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          _buildCard('Estate Input', Icons.input, Colors.orange,
              InheritanceCalculator()),
          _buildCard('About', Icons.calculate, Colors.blue, AboutPage()),
          _buildCard(
              'Results Display',
              Icons.show_chart,
              Colors.green,
              ResultsPage(
                email: '${user.email}',
              )),
          _buildCard('Thank', Icons.book, Colors.grey, ContactUsPage()),
        ],
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, Color color, Widget page) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}