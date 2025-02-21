import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsPage extends StatelessWidget {
  final Map<String, dynamic> article;

  const NewsDetailsPage({Key? key, required this.article}) : super(key: key);

  String cleanContent(String? content) {
    if (content == null) return "No additional content available.";
    return content.split(" [+")[0]; // Removes truncated part
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article['title'] ?? 'News Details',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article['urlToImage'],
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              article['title'] ?? "No Title",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "By ${article['author'] ?? 'Unknown Author'} - ${article['source']['name'] ?? 'Unknown Source'}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            Text(
              cleanContent(article['content']),
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Color(0xFFEAF6E3),
                ),
                onPressed: () async {
                  if (article['url'] != null) {
                    final Uri url = Uri.parse(article['url']);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch ${article['url']}';
                    }
                  }
                },
                child: const Text(
                  "Read Full Article",
                  style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
