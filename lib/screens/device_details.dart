import 'package:flutter/material.dart';
import 'device_usage_page.dart';
import 'profile_settings.dart';
import 'home_page.dart';

class DeviceDetailsPage extends StatefulWidget {
  @override
  _DeviceDetailsPageState createState() => _DeviceDetailsPageState();
}

class _DeviceDetailsPageState extends State<DeviceDetailsPage> {
  List<Map<String, dynamic>> devices = [
    {'name': 'Television', 'isActive': true},
    {'name': 'Aircon', 'isActive': false},
    {'name': 'Electric Fan', 'isActive': true},
    {'name': 'Washing Machine', 'isActive': true},
  ];

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/device');
        break;
      case 2:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  void _showAddDeviceDialog() {
    final TextEditingController deviceController = TextEditingController();
    bool isActive = false;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Device"),
        content: StatefulBuilder(
          builder: (context, setDialogState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: deviceController,
                decoration: const InputDecoration(labelText: "Device Name"),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  const Text("Is Active:"),
                  Switch(
                    value: isActive,
                    onChanged: (value) {
                      setDialogState(() => isActive = value);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (deviceController.text.isNotEmpty) {
                setState(() {
                  devices.add(
                      {'name': deviceController.text, 'isActive': isActive});
                });
                Navigator.of(context).pop();
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceTile(BuildContext context, String name, bool isActive) {
    return ListTile(
      leading: Icon(
        Icons.circle,
        color: isActive ? Colors.green : Colors.red,
      ),
      title: Text(name, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceUsagePage(deviceName: name),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50),
      appBar: AppBar(
        title: const Text("Smart Meter Devices"),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileSettingsPage()),
                );
              },
              child: const CircleAvatar(
                radius: 26,
                backgroundImage: AssetImage("assets/profile_icon.png"),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "List of your devices",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  for (var device in devices)
                    _buildDeviceTile(
                        context, device['name'], device['isActive']),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDeviceDialog,
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Color(0xFF2C3E50)),
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
                color: Color(0xFF2C3E50),
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
}
