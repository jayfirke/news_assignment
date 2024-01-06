import 'package:flutter/material.dart';
import 'package:news_assignment/API/news_service.dart';
import 'package:news_assignment/Model/news.dart';
import 'package:news_assignment/UI/Screens/news_details.dart';

class Home extends StatelessWidget {
  final NewsService newsService = NewsService();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: FutureBuilder<List<News>>(
        future: newsService.getNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<News> newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(newsList[index].title),
                    subtitle: Text('Source: ${newsList[index].sourceName}'),
                    leading: CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          newsList[index].imageUrl,
                          width: 50,
                          height: 50,
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
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsDetails(news: newsList[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}