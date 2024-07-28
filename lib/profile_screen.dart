import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:project_graduated/screens/Sigin_screen.dart';
import 'package:project_graduated/screens/help_screen.dart';
import 'package:project_graduated/provide/user_provider.dart';
import 'package:project_graduated/screens/settings_screen.dart';
import 'package:project_graduated/screens/update_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadUserFromStorage();
    });
  }

  void _onProfileTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateProfile()),
    );
  }

  void _onSettingsTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  void _onHelpCenterTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HelpScreen()),
    );
  }

  void _onLogOutTap() {
    Provider.of<UserProvider>(context, listen: false).logout();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (e) => const SigIn(),
      ),
    );
  }

  void _showProfilePhoto(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(imageUrl),
              backgroundDecoration: BoxDecoration(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                String imageUrl = userProvider.user?.image ??
                    'https://via.placeholder.com/150';

                return GestureDetector(
                  onTap: () => _showProfilePhoto(context, imageUrl),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                  "https://st3.depositphotos.com/9998432/13335/v/450/depositphotos_133352156-stock-illustration-default-placeholder-profile-icon.jpg"),
           
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return Text(
                  userProvider.user?.name ?? 'Guest',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            SizedBox(height: 20),
            _buildListTile(IconlyLight.user, 'Your profile', _onProfileTap),
            _buildListTile(IconlyLight.setting, 'Settings', _onSettingsTap),
            _buildListTile(Icons.help_outline, 'Help Center', _onHelpCenterTap),
            _buildListTile(IconlyLight.logout, 'LogOut', _onLogOutTap),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(title),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.blue,
        ),
        onTap: onTap,
      ),
    );
  }
}