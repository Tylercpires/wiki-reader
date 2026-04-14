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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WikiReader'),
        ),
        body: const Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}
