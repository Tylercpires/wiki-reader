//T. Pires - main.dart - Files that contains main logic for the wiki-reader project.
//Created 2026-04-14
//Last updated 2026-04-14

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'summary.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    final viewModel = ArticleViewModel(ArticleModel());

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("WikiReader"),
        ),
        body: const Center(
          child: Text("Check Debug Console for article summary."),
        ),
      ),
    );
  }
}

//Handles data operations
class ArticleModel {

  Future<Summary> getRandomArticleSummary() async{
    final uri = Uri.https(
      "en.wikipedia.org",
      "/api/rest_v1/page/random/summary",
    );

    final response = await get(uri);

    if(response.statusCode != 200){
      throw HttpException("Failed to load article summary");
    }

    return Summary.fromJson(jsonDecode(response.body));
  }
}

//Displays UI
class ArticleView{

}

//Manages state and connects ArticleModel and ArticleView.
class ArticleViewModel extends ChangeNotifier{

  final ArticleModel model;
  Summary? summary;
  String? errorMessage;
  bool loading = false;

  ArticleViewModel(this.model){
    getRandomArticleSummary();
  }

  Future<void> getRandomArticleSummary() async{

    loading = true;
    notifyListeners();

    try{
      summary = await model.getRandomArticleSummary();
      print("Article loaded: ${summary!.titles.normalized}");
      errorMessage = null;
    } on HttpException catch(error){
      print("Error loading article: ${error.message}");
      errorMessage = error.message;
      summary = null;
    }

    loading = false;
    notifyListeners();
  }

}