import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecotrack_mobile/screens/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'device_details.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  String fullName = "";
  String userName = "";
  String phone = "";
  String email = "";
  int _selectedIndex = 2;
  bool _isLoggingOut = false;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('fullName') ?? "Not set";
      userName = prefs.getString('userName') ?? "Not set";
      phone = prefs.getString('Phone') ?? "Not set";
      email = prefs.getString('Email') ?? "Not set";

      fullNameController.text = fullName;
      userNameController.text = userName;
      phoneController.text = phone;
      emailController.text = email;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DeviceDetailsPage()),
        );
        break;
      case 2:
        // Profile Settings
        break;
    }
  }

  Future<void> _updateEmail(String newEmail) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('Email', newEmail);

        setState(() {
          email = newEmail;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email updated successfully!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "Failed to update email: Please verify your current email account first.")),
      );
    }
  }

  Future<void> _editProfileField(
      String title, TextEditingController controller, String key) async {
    final prefs = await SharedPreferences.getInstance();
    controller.text = prefs.getString(key) ?? "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $title"),
          content: TextFormField(
            controller: controller,
            decoration: InputDecoration(labelText: title),
            keyboardType:
                title == 'Phone' ? TextInputType.phone : TextInputType.text,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final updatedValue = controller.text.trim();

                if (title == 'Phone') {
                  final phoneRegex = RegExp(r'^09\d{9}$');
                  if (!phoneRegex.hasMatch(updatedValue)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Phone number must start with '09' and be 11 digits long."),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                }

                await prefs.setString(key, updatedValue);

                setState(() {
                  if (key == 'fullName') fullName = updatedValue;
                  if (key == 'userName') userName = updatedValue;
                  if (key == 'Phone') phone = updatedValue;
                  if (key == 'Email') email = updatedValue;
                });

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50),
      appBar: AppBar(
        title: const Text("Profile Settings"),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const AssetImage("assets/profile_icon.png"),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 10),
                const Text("Account Number: 12395923",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                _buildProfileOption(
                    "Full Name", fullName, fullNameController, 'fullName'),
                _buildProfileOption(
                    "Username", userName, userNameController, 'userName'),
                _buildProfileOption(
                    "Email Address", email, emailController, 'Email'),
                _buildProfileOption("Phone", phone, phoneController, 'Phone'),
                const SizedBox(height: 40),
                _buildLogoutButton(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF2C3E50),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.only(top: 10),
              child: Icon(
                Icons.add_box,
                size: 32,
                color: Colors.grey,
              ),
            ),
            label: 'Add Device',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void _editEmailField() {
    TextEditingController emailController = TextEditingController(text: email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Email Address"),
          content: TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: "New Email"),
            keyboardType: TextInputType.emailAddress,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final newEmail = emailController.text.trim();
                if (newEmail.isNotEmpty && newEmail.contains('@')) {
                  await _updateEmail(newEmail);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please enter a valid email address.")),
                  );
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileOption(String title, String value,
      TextEditingController controller, String key) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.edit),
      onTap: () {
        if (title == "Email Address") {
          _editEmailField();
        } else {
          _editProfileField(title, controller, key);
        }
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoggingOut
          ? null
          : () async {
              setState(() => _isLoggingOut = true);

              await Future.delayed(const Duration(milliseconds: 500));

              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                  (Route<dynamic> route) => false,
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Failed to log out: $e")),
                );
              } finally {
                setState(() => _isLoggingOut = false);
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 193, 52, 42),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: _isLoggingOut
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const Text(
              "Logout",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
    );
  }
}
