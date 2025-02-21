import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_details.dart';
import 'profile_settings.dart';
import 'device_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> newsArticles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    const String apiKey = "f43a7266d7314d63bea2db43f02236d4";
    const String url = "https://newsapi.org/v2/everything?q=Philippines&apiKey=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          newsArticles = data['articles'];
        });
      } else {
        throw Exception("Failed to load news");
      }
    } catch (e) {
      print("Error fetching news: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text("Homepage"),
        backgroundColor: Colors.white,
        elevation: 0, // Make the app bar smooth
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileSettingsPage()),
                );
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/profile_icon.png"),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100), // Moved button lower
                const Text(
                  "News and Updates",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: newsArticles.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: newsArticles.length,
                          itemBuilder: (context, index) {
                            final news = newsArticles[index];
                            return Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: news['urlToImage'] != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(news['urlToImage'], width: 80, height: 80, fit: BoxFit.cover),
                                      )
                                    : const Icon(Icons.article, size: 50, color: Colors.grey),
                                title: Text(
                                  news['title'] ?? "No Title",
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  news['description'] ?? "No Description Available",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsDetailsPage(article: news),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
            // Centered Circular Button - Moved Down
            Positioned(
            top: 10, // Move button down further to avoid overlap 15 or 10
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(37), // Keeps the button bigger
                backgroundColor: Colors.grey[300],
                elevation: 3,
              ),
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeviceDetailsPage()),
                );
              },
              child: const Text(
                'Add Device',
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              ),
            ),
            ),
          ],
      ),
    );
  }
}


