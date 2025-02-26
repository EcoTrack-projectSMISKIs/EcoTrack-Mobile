import 'package:flutter/material.dart';

class AIRecommendationPage extends StatelessWidget {
  final String deviceName;

  const AIRecommendationPage({super.key, required this.deviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Recommendations', 
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E293B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF1E293B),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recommended Actions",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            _buildRecommendationTile("Reduce Runtime",
                "Consider turning off the device during inactive hours to save energy."),
            _buildRecommendationTile("Adjust Power Settings",
                "Lower the power mode to eco-friendly settings for optimal consumption."),
            _buildRecommendationTile("Schedule Usage",
                "Set a timer to run the device only during peak efficiency periods."),
            const SizedBox(height: 20),
            const Text(
              "Projected Savings",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            _buildSavingsCard("Energy Saved", "1.2 kWh per day"),
            _buildSavingsCard("Cost Saved", "\$0.50 per day"),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationTile(String title, String description) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.lightbulb_outline, color: Colors.green),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }

  Widget _buildSavingsCard(String title, String value) {
    return Card(
      color: Colors.green[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(value, style: const TextStyle(color: Colors.green, fontSize: 16)),
      ),
    );
  }
}
