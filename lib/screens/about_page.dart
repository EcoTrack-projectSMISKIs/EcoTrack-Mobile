import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About EcoTrack"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF2C3E50),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "EcoTrack",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "EcoTrack is a smart energy management app designed to help users monitor and optimize their energy consumption. With real-time insights, AI-driven recommendations, and intuitive controls, EcoTrack empowers you to make informed decisions about your energy usage, reducing costs and environmental impact.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Key Features:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.insights, color: Colors.green),
              title: Text(
                "Real-Time Energy Monitoring",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Track energy consumption for all connected devices.",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.lightbulb, color: Colors.yellow),
              title: Text(
                "AI Recommendations",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Receive personalized suggestions to optimize energy use.",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.bar_chart, color: Colors.blue),
              title: Text(
                "Detailed Usage Reports",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Analyze historical usage patterns and trends.",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[300],
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Back to Home",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
