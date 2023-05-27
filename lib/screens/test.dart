import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../api/news_api.dart';
import '../localizations/localizations.dart';

class ScrollDownNewsPage extends StatefulWidget {
  @override
  _ScrollDownNewsPageState createState() => _ScrollDownNewsPageState();
}

class _ScrollDownNewsPageState extends State<ScrollDownNewsPage> {
  List<Article> newsList = [];
  bool isLoading = false;
  bool isError = false;
  String errorMessage = '';
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadBitcoinArticles();

    _scrollController.addListener(_scrollListener);
  }

  void loadBitcoinArticles() async {
    setState(() {
      isLoading = true;
      isError = false;
      errorMessage = '';
    });

    try {
      final List<Article> bitcoinArticles = await NewsAPI.getBitcoinArticles();
      setState(() {
        newsList.addAll(bitcoinArticles);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
        errorMessage = 'Failed to load articles.';
      });
    }
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;

    // Check if the user reached the bottom of the list
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!isLoading) {
        loadBitcoinArticles(); // Fetch new articles
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('${AppLocalizations.of(context).getTranslate('homepage')}: '),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              child: Icon(Iconsax.setting_2),
              onTap: () => GoRouter.of(context).push('/settings'),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemCount: newsList.length + 1,
            itemBuilder: (context, index) {
              if (index == newsList.length) {
                if (isError) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (isLoading) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox(); // Display an empty container at the bottom when not loading or error
                }
              } else {
                final article = newsList[index];
                return Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          article.source.name,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          article.description,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          if (isError)
            Positioned.fill(
              child: Container(
                color: Colors.red.withOpacity(0.8),
                child: Center(
                  child: Text(
                    errorMessage,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
