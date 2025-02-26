import 'package:flutter/material.dart';

class UsageHistoryPage extends StatelessWidget {
  final String deviceName;

  const UsageHistoryPage({Key? key, required this.deviceName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> usageHistory = [
      {'date': '2025-02-25', 'usage': '1.8 kWh', 'duration': '5h 13m'},
      {'date': '2025-02-24', 'usage': '2.1 kWh', 'duration': '6h 05m'},
      {'date': '2025-02-23', 'usage': '1.6 kWh', 'duration': '4h 32m'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$deviceName Usage History',
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1,), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E293B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF1E293B),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: usageHistory.length,
          itemBuilder: (context, index) {
            final entry = usageHistory[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.history, color: Colors.blueGrey),
                title: Text('Usage: ${entry['usage']}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Duration: ${entry['duration']}'),
                trailing: Text(entry['date']!),
              ),
            );
          },
        ),
      ),
    );
  }
}
