import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecotrack_mobile/screens/landing_page.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Settings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/profile_icon.png"), // Replace with actual profile image
            ),
            const SizedBox(height: 10),
            const Text("Account Number: 12395923", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildProfileOption("Name", "Luis Gabriel H. Laguardia"),
            _buildProfileOption("Username", "luislaguardia"),
            _buildProfileOption("Email Address", "laguardialuis@gmail.com"),
            _buildProfileOption("Link Phone", "*********061"),
            const SizedBox(height: 40),
            _buildLogoutButton(context), // Logout Button
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Add edit functionality if needed
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        // Navigate back to Landing Page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LandingPage()),
          (Route<dynamic> route) => false,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Logout button color
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        "Logout",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}