import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_assignment/Model/news.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  final News news;

  const NewsDetails({super.key, required this.news});

  void _openExternalBrowser() async {
    if (await canLaunchUrl(Uri.parse(news.url))) {
      await launchUrl(Uri.parse(news.url));
    } else {
      throw 'Could not launch ${news.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              news.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('Source: ${news.sourceName}'),
            const SizedBox(height: 10),
            Text('Published At: ${news.publishedAt}'),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                news.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, widget, event) {
                  if (event == null) {
                    return widget;
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(news.description),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                log("Checking if printing");
                _openExternalBrowser();
              },
              child: const Text('Read More'),
            ),
          ],
        ),
      ),
    );
  }
}
